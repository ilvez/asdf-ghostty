<div align="center">

# asdf-ghostty [![Build](https://github.com/ilvez/asdf-ghostty/actions/workflows/build.yml/badge.svg)](https://github.com/ilvez/asdf-ghostty/actions/workflows/build.yml) [![Lint](https://github.com/ilvez/asdf-ghostty/actions/workflows/lint.yml/badge.svg)](https://github.com/ilvez/asdf-ghostty/actions/workflows/lint.yml)

[ghostty](https://ghostty.org/docs/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

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
ghosty --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/ilvez/asdf-ghostty/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Taavi Ilves](https://github.com/ilvez/)
