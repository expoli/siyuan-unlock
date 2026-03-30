# Enhanced .deb Package Generation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Enable comprehensive .deb package generation with full desktop integration for Ubuntu/Debian distribution and automatic GitHub releases upload.

**Architecture:** Enhance existing electron-builder configuration with comprehensive package metadata, file associations, MIME types, and desktop entry improvements. Add CI/CD workflow matrix entries to upload .deb packages to GitHub releases. No changes to build scripts needed.

**Tech Stack:** Electron-builder, YAML configuration, GitHub Actions

---

## Files Modified

| File | Purpose | Changes |
|------|---------|---------|
| `app/electron-builder-linux.yml` | Linux amd64 package config | Add maintainer, description, dependencies, file associations, MIME types, enhanced desktop entry |
| `app/electron-builder-linux-arm64.yml` | Linux arm64 package config | Same changes as amd64 config, architecture-specific paths already correct |
| `.github/workflows/desktop-release.yml` | CI/CD pipeline | Add two new matrix entries for .deb package builds (amd64 and arm64) |

---

## Task 1: Update electron-builder-linux.yml with Package Metadata

**Files:**
- Modify: `app/electron-builder-linux.yml`

- [ ] **Step 1: Read the current electron-builder-linux.yml configuration**

Run: `cat app/electron-builder-linux.yml`

Expected: See current configuration with basic desktop entry and minimal metadata

- [ ] **Step 2: Add comprehensive package metadata to linux section**

Add the following to the `linux:` section in `app/electron-builder-linux.yml`, after the `executableName: "siyuan"` line:

```yaml
linux:
  icon: "src/assets/icon.icns"
  category: "Office;Utility;TextEditor"
  executableName: "siyuan"

  # Package metadata
  maintainer: "expoli <31023767+expoli@users.noreply.github.com>"
  homepage: "https://github.com/appdev/siyuan-unlock"
  synopsis: "Privacy-first personal knowledge management system"
  description: |
    SiYuan Note is a privacy-first personal knowledge management system with
    block-level references and Markdown WYSIWYG. This is the unlock version
    with additional features enabled.

    Features:
    - Block-level references and bidirectional links
    - Markdown WYSIWYG editing
    - Local-first with end-to-end encryption
    - Cross-platform support
    - Plugin and theme marketplace

  keywords: ["note-taking", "knowledge-management", "markdown", "productivity"]

  # Runtime dependencies (standard Electron dependencies)
  depends: [
    "libgtk-3-0 (>= 3.10)",
    "libnotify4 (>= 0.7)",
    "libnss3 (>= 3.26)",
    "libxss1",
    "libxtst6",
    "xdg-utils",
    "libatspi2.0-0 (>= 2.9.90)",
    "libuuid1",
    "libsecret-1-0",
    "libgbm1"
  ]

  # Keep existing extraResources and target sections below
```

Note: Preserve all existing `extraResources`, `target`, and other configuration below this addition.

- [ ] **Step 3: Verify YAML syntax is correct**

Run: `python3 -c "import yaml; yaml.safe_load(open('app/electron-builder-linux.yml'))"`

Expected: No output (success) or detailed YAML syntax error if malformed

- [ ] **Step 4: Commit the package metadata changes**

```bash
git add app/electron-builder-linux.yml
git commit -m "feat: add comprehensive package metadata for .deb packages

- Add maintainer information (expoli)
- Add detailed package description
- Add runtime dependencies for Electron
- Add keywords for package manager search
- Add homepage URL

This enables professional .deb package generation with proper metadata."
```

---

## Task 2: Add File Associations and MIME Types to electron-builder-linux.yml

**Files:**
- Modify: `app/electron-builder-linux.yml`

- [ ] **Step 1: Add file associations configuration**

Add the following to the `linux:` section in `app/electron-builder-linux.yml`, after the `depends:` array and before `extraResources:`:

```yaml
  # File associations and MIME types
  fileAssociations:
    - ext: "sy"
      name: "SiYuan Workspace"
      description: "SiYuan Note Workspace"
      mimeType: "application/x-siyuan-workspace"
      role: "Editor"

  mimeTypes:
    - "application/x-siyuan-workspace"
```

- [ ] **Step 2: Verify YAML syntax**

Run: `python3 -c "import yaml; yaml.safe_load(open('app/electron-builder-linux.yml'))"`

Expected: No output (success)

- [ ] **Step 3: Commit file associations**

```bash
git add app/electron-builder-linux.yml
git commit -m "feat: add .sy file association and MIME type

- Register .sy files as SiYuan Workspace
- Define application/x-siyuan-workspace MIME type
- Enable file manager integration (icon, open with)

Users can now double-click .sy files to open in SiYuan."
```

---

## Task 3: Enhance Desktop Entry in electron-builder-linux.yml

**Files:**
- Modify: `app/electron-builder-linux.yml`

- [ ] **Step 1: Replace the desktop entry section**

Replace the existing `desktop:` section in `app/electron-builder-linux.yml` with:

```yaml
desktop: {
  "Name": "SiYuan Note",
  "Comment": "Privacy-first personal knowledge management system",
  "GenericName": "Note Taking Application",
  "Type": "Application",
  "Categories": "Office;Utility;TextEditor;",
  "Keywords": "note;knowledge;markdown;productivity;writing;editor;",
  "StartupNotify": "true",
  "StartupWMClass": "siyuan",
  "DBusActivatable": "false",
  "Terminal": "false"
}
```

- [ ] **Step 2: Verify YAML syntax**

Run: `python3 -c "import yaml; yaml.safe_load(open('app/electron-builder-linux.yml'))"`

Expected: No output (success)

- [ ] **Step 3: Commit desktop entry enhancement**

```bash
git add app/electron-builder-linux.yml
git commit -m "feat: enhance desktop entry for better menu integration

- Update name to 'SiYuan Note' for clarity
- Add GenericName for app launcher search
- Expand categories to include Office and TextEditor
- Add search keywords
- Enable startup notification
- Add StartupWMClass for proper window grouping

SiYuan will now appear in Office menu and be searchable by keywords."
```

---

## Task 4: Update electron-builder-linux-arm64.yml with Identical Changes

**Files:**
- Modify: `app/electron-builder-linux-arm64.yml`

- [ ] **Step 1: Read current arm64 configuration**

Run: `cat app/electron-builder-linux-arm64.yml`

Expected: Similar structure to amd64 config, with arm64-specific paths

- [ ] **Step 2: Add package metadata to linux section**

Add the following to the `linux:` section in `app/electron-builder-linux-arm64.yml`, after the `executableName: "siyuan"` line:

```yaml
linux:
  icon: "src/assets/icon.icns"
  category: "Office;Utility;TextEditor"
  executableName: "siyuan"

  # Package metadata
  maintainer: "expoli <31023767+expoli@users.noreply.github.com>"
  homepage: "https://github.com/appdev/siyuan-unlock"
  synopsis: "Privacy-first personal knowledge management system"
  description: |
    SiYuan Note is a privacy-first personal knowledge management system with
    block-level references and Markdown WYSIWYG. This is the unlock version
    with additional features enabled.

    Features:
    - Block-level references and bidirectional links
    - Markdown WYSIWYG editing
    - Local-first with end-to-end encryption
    - Cross-platform support
    - Plugin and theme marketplace

  keywords: ["note-taking", "knowledge-management", "markdown", "productivity"]

  # Runtime dependencies (standard Electron dependencies)
  depends: [
    "libgtk-3-0 (>= 3.10)",
    "libnotify4 (>= 0.7)",
    "libnss3 (>= 3.26)",
    "libxss1",
    "libxtst6",
    "xdg-utils",
    "libatspi2.0-0 (>= 2.9.90)",
    "libuuid1",
    "libsecret-1-0",
    "libgbm1"
  ]

  # File associations and MIME types
  fileAssociations:
    - ext: "sy"
      name: "SiYuan Workspace"
      description: "SiYuan Note Workspace"
      mimeType: "application/x-siyuan-workspace"
      role: "Editor"

  mimeTypes:
    - "application/x-siyuan-workspace"

  # Keep existing extraResources section below
```

- [ ] **Step 3: Replace desktop entry section**

Replace the existing `desktop:` section in `app/electron-builder-linux-arm64.yml` with:

```yaml
desktop: {
  "Name": "SiYuan Note",
  "Comment": "Privacy-first personal knowledge management system",
  "GenericName": "Note Taking Application",
  "Type": "Application",
  "Categories": "Office;Utility;TextEditor;",
  "Keywords": "note;knowledge;markdown;productivity;writing;editor;",
  "StartupNotify": "true",
  "StartupWMClass": "siyuan",
  "DBusActivatable": "false",
  "Terminal": "false"
}
```

- [ ] **Step 4: Verify YAML syntax**

Run: `python3 -c "import yaml; yaml.safe_load(open('app/electron-builder-linux-arm64.yml'))"`

Expected: No output (success)

- [ ] **Step 5: Commit arm64 configuration changes**

```bash
git add app/electron-builder-linux-arm64.yml
git commit -m "feat: add comprehensive package metadata for arm64 .deb packages

- Add maintainer information
- Add detailed package description
- Add runtime dependencies
- Add file associations for .sy files
- Enhance desktop entry

Identical to amd64 config, ensures consistent arm64 package quality."
```

---

## Task 5: Add .deb Package Matrix Entries to GitHub Actions Workflow

**Files:**
- Modify: `.github/workflows/desktop-release.yml`

- [ ] **Step 1: Read current workflow matrix configuration**

Run: `cat .github/workflows/desktop-release.yml | grep -A 20 "strategy:"`

Expected: See existing matrix entries for tar.gz, AppImage, mac, and windows builds

- [ ] **Step 2: Add amd64 .deb package matrix entry**

Add the following matrix entry to the `config:` array in `.github/workflows/desktop-release.yml`, after the existing linux-arm64.tar.gz entry (around line 42):

```yaml
      - os: ubuntu-22.04
        kernel_path: "../app/kernel-linux/SiYuan-Kernel"
        build_args: "-s -w -X github.com/siyuan-note/siyuan/kernel/util.Mode=prod"
        electron_args: "dist-linux"
        goos: "linux"
        goarch: "amd64"
        cc_path: "x86_64-linux-musl-cross/bin/x86_64-linux-musl-gcc"
        suffix: "linux-amd64.deb"
```

Place this after the `suffix: "linux.tar.gz"` or `suffix: "linux.AppImage"` entries.

- [ ] **Step 3: Add arm64 .deb package matrix entry**

Add the following matrix entry after the amd64 .deb entry:

```yaml
      - os: ubuntu-22.04
        kernel_path: "../app/kernel-linux-arm64/SiYuan-Kernel"
        build_args: "-s -w -X github.com/siyuan-note/siyuan/kernel/util.Mode=prod"
        electron_args: "dist-linux-arm64"
        goos: "linux"
        goarch: "arm64"
        cc_path: "aarch64-linux-musl-cross/bin/aarch64-linux-musl-gcc"
        suffix: "linux-arm64.deb"
```

- [ ] **Step 4: Verify YAML syntax**

Run: `python3 -c "import yaml; yaml.safe_load(open('.github/workflows/desktop-release.yml'))"`

Expected: No output (success)

- [ ] **Step 5: Review the complete matrix configuration**

Run: `cat .github/workflows/desktop-release.yml | grep -B 2 -A 8 "suffix:"`

Expected: See all suffix entries including the two new .deb entries

- [ ] **Step 6: Commit workflow changes**

```bash
git add .github/workflows/desktop-release.yml
git commit -m "feat: add .deb package builds to GitHub Actions workflow

- Add linux-amd64.deb matrix entry
- Add linux-arm64.deb matrix entry
- Enables automatic .deb package uploads to releases

Users can now download and install .deb packages directly from GitHub releases."
```

---

## Task 6: Verify Configuration and Create Summary Documentation

**Files:**
- Create: `docs/DEB_PACKAGING.md`

- [ ] **Step 1: Verify all configuration files are syntactically correct**

Run:
```bash
python3 -c "import yaml; yaml.safe_load(open('app/electron-builder-linux.yml'))"
python3 -c "import yaml; yaml.safe_load(open('app/electron-builder-linux-arm64.yml'))"
python3 -c "import yaml; yaml.safe_load(open('.github/workflows/desktop-release.yml'))"
```

Expected: No output from all three commands (all valid YAML)

- [ ] **Step 2: Create documentation for .deb packaging**

Create `docs/DEB_PACKAGING.md` with the following content:

```markdown
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

- `siyuan-{version}-linux-amd64.deb`
- `siyuan-{version}-linux-arm64.deb`

## Installation

### Download from GitHub Releases

Download the appropriate .deb package for your architecture:

```bash
# amd64 (most common)
wget https://github.com/appdev/siyuan-unlock/releases/download/{version}/siyuan-unlock-{version}-linux-amd64.deb

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
dpkg-deb -I siyuan-unlock-*-linux-amd64.deb
```

### List Package Contents

```bash
dpkg-deb -c siyuan-unlock-*-linux-amd64.deb
```

### Check Desktop Entry

```bash
dpkg-deb -c siyuan-unlock-*-linux-amd64.deb | grep .desktop
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
```

- [ ] **Step 3: Commit documentation**

```bash
git add docs/DEB_PACKAGING.md
git commit -m "docs: add .deb packaging documentation

- Document build process
- Document installation procedures
- Document package features
- Add troubleshooting guide
- Add configuration file references

Helps users and developers understand .deb package generation."
```

---

## Task 7: Final Verification and Push

**Files:**
- None (verification only)

- [ ] **Step 1: Review all commits**

Run: `git log --oneline --graph --all -10`

Expected: See all 7 commits from this plan

- [ ] **Step 2: Verify no uncommitted changes**

Run: `git status`

Expected: "nothing to commit, working tree clean"

- [ ] **Step 3: Push branch to remote**

```bash
git push -u origin worktree-deb-package-enhancement
```

Expected: Branch pushed successfully

---

## Summary

This implementation plan adds comprehensive .deb package generation to SiYuan Note:

✅ **Package Metadata** - Professional metadata including maintainer, description, dependencies, keywords
✅ **File Associations** - .sy files associated with SiYuan, custom MIME type
✅ **Desktop Integration** - Enhanced menu placement, search keywords, startup notification
✅ **CI/CD Integration** - Automatic .deb package uploads to GitHub releases
✅ **Documentation** - Complete user and developer documentation

**Files Modified:**
- `app/electron-builder-linux.yml`
- `app/electron-builder-linux-arm64.yml`
- `.github/workflows/desktop-release.yml`

**Files Created:**
- `docs/DEB_PACKAGING.md`

**No Changes Required:**
- `scripts/linux-build.sh` (already works)

All changes maintain backward compatibility and follow existing patterns in the codebase.
