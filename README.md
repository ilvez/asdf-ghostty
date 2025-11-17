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
- Platform-specific system dependencies (GTK4/libadwaita on Linux, Xcode on macOS). Note: macOS building currently is untested.

For complete build requirements and dependency installation instructions, see the [official ghostty build documentation](https://ghostty.org/docs/install/build).

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

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/ilvez/asdf-ghostty/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Taavi Ilves](https://github.com/ilvez/)
