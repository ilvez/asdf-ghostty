<div align="center">

# asdf-ghostty [![Build](https://github.com/ilvez/asdf-ghostty/actions/workflows/build.yml/badge.svg)](https://github.com/ilvez/asdf-ghostty/actions/workflows/build.yml) [![Lint](https://github.com/ilvez/asdf-ghostty/actions/workflows/lint.yml/badge.svg)](https://github.com/ilvez/asdf-ghostty/actions/workflows/lint.yml)

[ghostty](https://ghostty.org/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**Note**: This plugin builds ghostty from source, which requires:

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html)
- **Zig compiler** (version-specific to ghostty release)
- For platform-specific system dependencies see the [official ghostty build documentation](https://ghostty.org/docs/install/build).
- MacOS build hasn't been tested yet.

# Install

Plugin:

```shell
asdf plugin add ghostty
# or
asdf plugin add ghostty https://github.com/ilvez/asdf-ghostty.git
```

ghostty:

```shell
# Show all installable versions
asdf list-all ghostty

# Install specific version
asdf install ghostty latest

# Set a version globally (on your ~/.tool-versions file)
asdf global ghostty latest

# Now ghostty commands are available
ghostty --version
```

## Version Options

- **Stable releases**: `asdf install ghostty 1.2.3`
- **`latest`**: Resolves to the most recent stable release tag
- **`tip`**: Installs from the `tip` tag (development snapshot)
- **`ref:<reference>`**: Build from any git reference:
  - Branch: `asdf install ghostty ref:main`
  - Tag: `asdf install ghostty ref:v1.2.3`
  - Commit: `asdf install ghostty ref:abc123`

## Build Options

You can customize the build by setting the `GHOSTTY_BUILD_OPTIONS` environment variable before installation:

```shell
# Example: Build with debug optimization and without themes:
export GHOSTTY_BUILD_OPTIONS="-Doptimize=Debug -Demit-themes=false"
asdf install ghostty 1.2.3
```

The plugin uses these default options: `-Doptimize=ReleaseFast -fsys=fontconfig`

Your custom options are appended to the defaults. For available build options, see the [ghostty build documentation](https://ghostty.org/docs/install/build).

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/ilvez/asdf-ghostty/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Taavi Ilves](https://github.com/ilvez/)
