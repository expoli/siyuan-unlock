# .deb Package Generation

This document describes the .deb package generation for SiYuan Note.

## Overview

SiYuan Note generates professional .deb packages for Ubuntu/Debian systems with:

- Comprehensive package metadata
- File associations for `.sy` workspace files
- Full desktop integration
- Automatic dependency resolution

## Building .deb Packages Locally

### Prerequisites

- Node.js 20+
- pnpm 9.x
- Go (check `kernel/go.mod` for version)
- musl-cross toolchains (for static linking)

### Build Commands

```bash
# Build for amd64
cd app
pnpm run dist-linux

# Build for arm64
pnpm run dist-linux-arm64
```

### Output

Generated packages appear in `app/build/`:

- `siyuan-{version}-linux.deb`
- `siyuan-{version}-linux-arm64.deb`

## Installation

### Download from GitHub Releases

Download the appropriate .deb package for your architecture:

```bash
# amd64 (most common)
wget https://github.com/appdev/siyuan-unlock/releases/download/{version}/siyuan-unlock-{version}-linux.deb

# arm64 (ARM processors)
wget https://github.com/appdev/siyuan-unlock/releases/download/{version}/siyuan-unlock-{version}-linux-arm64.deb
```

### Install

```bash
sudo dpkg -i siyuan-unlock-*.deb
sudo apt install -f  # Install dependencies
```

### Uninstall

```bash
sudo dpkg --remove siyuan
```

## Package Features

### Metadata

- **Maintainer:** expoli <31023767+expoli@users.noreply.github.com>
- **Homepage:** https://github.com/appdev/siyuan-unlock
- **Description:** Privacy-first personal knowledge management system
- **Dependencies:** All required Electron dependencies auto-installed

### File Associations

- `.sy` files (SiYuan Workspace) automatically open in SiYuan
- File icon displays in file managers (Nautilus, Dolphin, Thunar)
- MIME type: `application/x-siyuan-workspace`

### Desktop Integration

- **Menu Location:** Office → SiYuan Note
- **Categories:** Office, Utility, TextEditor
- **Search Keywords:** note, knowledge, markdown, productivity, writing, editor
- **Startup Notification:** Loading cursor shown during launch

## CI/CD Integration

GitHub Actions automatically builds and uploads .deb packages to releases:

1. Workflow: `.github/workflows/desktop-release.yml`
2. Triggers: Manual dispatch with version tag
3. Builds: amd64 and arm64 .deb packages
4. Uploads: Attached to GitHub release

## Verifying Package Contents

### Inspect Package Metadata

```bash
dpkg-deb -I siyuan-unlock-*-linux.deb
```

### List Package Contents

```bash
dpkg-deb -c siyuan-unlock-*-linux.deb
```

### Check Desktop Entry

```bash
dpkg-deb -c siyuan-unlock-*-linux.deb | grep .desktop
```

## Configuration Files

Package generation is configured in:

- `app/electron-builder-linux.yml` - amd64 package configuration
- `app/electron-builder-linux-arm64.yml` - arm64 package configuration

## Troubleshooting

### Missing Dependencies

If installation fails with dependency errors:

```bash
sudo apt update
sudo apt install -f
```

### File Associations Not Working

Update desktop database:

```bash
sudo update-desktop-database
```

### Application Not in Menu

Reinstall package:

```bash
sudo dpkg --remove siyuan
sudo dpkg -i siyuan-unlock-*.deb
```

## Testing

For comprehensive testing instructions, see:
- `docs/superpowers/specs/2026-03-30-deb-package-generation-design.md`

## References

- [electron-builder Linux Options](https://www.electron.build/configuration/linux)
- [Debian Policy Manual](https://www.debian.org/doc/debian-policy/)
- [Desktop Entry Specification](https://specifications.freedesktop.org/desktop-entry-spec/latest/)
