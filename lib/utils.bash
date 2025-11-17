#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/ghostty-org/ghostty/"
TOOL_NAME="ghostty"
TOOL_TEST="ghostty --version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if ghostty is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  list_github_tags
}

get_latest_version() {
  list_github_tags | grep -v "^tip" | sort_versions | tail -n1
}

get_required_zig_version() {
  local ghostty_version="$1"

  if [ "$ghostty_version" == "tip" ]; then
    echo "0.15.1"
  elif [[ "$ghostty_version" =~ ^1\.0\. ]]; then
    echo "0.13.0"
  elif [[ "$ghostty_version" =~ ^1\.1\. ]]; then
    echo "0.13.0"
  elif [[ "$ghostty_version" =~ ^1\.2\. ]]; then
    echo "0.14.1"
  else
    echo ""
  fi
}

check_zig_version() {
  local required_version="$1"
  local ghostty_version="$2"

  if ! command -v zig &> /dev/null; then
    echo "⚠️  WARNING: Zig compiler not found. ghostty $ghostty_version requires Zig $required_version"
    echo "   See: https://ghostty.org/docs/install/build"
    return
  fi

  local installed_version
  installed_version=$(zig version 2>/dev/null || echo "unknown")

  if [ "$installed_version" != "$required_version" ]; then
    echo "⚠️  WARNING: Zig version mismatch detected"
    echo "   Found: $installed_version"
    echo "   Required for ghostty $ghostty_version: $required_version"
    echo "   Build may fail. See: https://ghostty.org/docs/install/build"
  else
    echo "* Using Zig $installed_version"
  fi
}

download_release() {
  local install_type="$1"
  local version="$2"
  local filename="$3"
  local url

  if [ "$install_type" == "version" ]; then
    if [ "$version" == "latest" ]; then
      version=$(get_latest_version)
    fi

    if [ "$version" == "tip" ]; then
      url="$GH_REPO/archive/refs/tags/${version}.tar.gz"
    else
      url="$GH_REPO/archive/refs/tags/v${version}.tar.gz"
    fi
  elif [ "$install_type" == "ref" ]; then
    if [[ "$version" =~ ^v[0-9] ]]; then
      url="$GH_REPO/archive/refs/tags/${version}.tar.gz"
    elif git ls-remote --tags --refs "$GH_REPO" | grep -q "refs/tags/${version}$"; then
      url="$GH_REPO/archive/refs/tags/${version}.tar.gz"
    else
      url="$GH_REPO/archive/${version}.tar.gz"
    fi
  else
    fail "Unsupported install type: $install_type"
  fi

  echo "* Downloading $TOOL_NAME $install_type $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ] && [ "$install_type" != "ref" ]; then
    fail "asdf-$TOOL_NAME supports version and ref installs only"
  fi

  local required_zig_version
  required_zig_version=$(get_required_zig_version "$version")

  if [ -n "$required_zig_version" ]; then
    check_zig_version "$required_zig_version" "$version"
  fi

  (
    cd "$ASDF_DOWNLOAD_PATH" && zig build -Doptimize=ReleaseFast -fsys=fontconfig

    mkdir -p "$install_path"
    cp -r "$ASDF_DOWNLOAD_PATH"/zig-out/* "$install_path"

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}
