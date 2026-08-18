# Environment files

This repository is a chezmoi source state for macOS and Windows.

## Bootstrap

macOS:

```sh
./bootstrap-macos.sh
```

Windows PowerShell:

```powershell
.\bootstrap-windows.ps1
```

The bootstrap script installs chezmoi, applies the configuration, and then
installs the configured command-line and GUI applications. Package installation
is idempotent and reruns when the package script changes.

## Daily usage

```sh
chezmoi --source /path/to/envfiles diff
chezmoi --source /path/to/envfiles apply
```

Platform-specific files are filtered automatically. Edit
`.chezmoidata.toml` to change the VS Code workspace folders.
