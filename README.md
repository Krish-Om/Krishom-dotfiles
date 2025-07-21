# 🏠 Krishom's Dotfiles

A comprehensive collection of configuration files for a modern Linux development environment, primarily focused on Arch Linux with Fish shell, Neovim, and Hyprland.

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Cross-Platform Setup](#cross-platform-setup)
- [Software & Tools](#software--tools)
- [Configuration Overview](#configuration-overview)
- [Usage](#usage)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)

## 🔧 Prerequisites

Before setting up these dotfiles, ensure you have the following installed:

- **GNU Stow** - For managing symlinks
- **Git** - For cloning the repository
- **Arch Linux** (or compatible distribution)

```bash
# Install prerequisites on Arch Linux
sudo pacman -S stow git
```

> **⚠️ Platform Compatibility:** 
> - The automated installation script (`install.sh`) is designed specifically for **Arch Linux** and uses `pacman` and AUR helpers.
> - **Manual installation** with GNU Stow works on Linux, macOS, and Windows (WSL).
> - For other platforms, see the [Cross-Platform Setup](#cross-platform-setup) section below.

## 🚀 Installation

### Option 1: Automated Installation (Recommended)

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Krish-Om/Krishom-dotfiles.git
   cd Krishom-dotfiles
   ```

2. **Run the installation script:**
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

   The script will automatically:
   - Check for existing installations
   - Install missing packages using pacman and AUR
   - Set up Fish shell as default
   - Install development tools (Bun, Node.js, etc.)
   - Stow all dotfiles configurations
   - Create necessary directories

3. **Script Options:**
   ```bash
   ./install.sh --help          # Show help and available options
   ./install.sh --core-only     # Install only core tools (fish, starship, kitty)
   ./install.sh --dev-only      # Install only development tools
   ./install.sh --hypr-only     # Install only Hyprland and related tools
   ./install.sh --stow-only     # Only stow configurations (skip packages)
   ```

### Option 2: Manual Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Krish-Om/Krishom-dotfiles.git
   cd Krishom-dotfiles
   ```

2. **Use GNU Stow to symlink configurations:**
   ```bash
   # Individual configurations
   stow fish      # Fish shell configuration
   stow nvim      # Neovim configuration
   stow kitty     # Kitty terminal configuration
   stow hypr      # Hyprland window manager
   stow tmux      # Tmux configuration
   stow starship  # Starship prompt
   stow ghostty   # Ghostty terminal
   stow vscode    # VS Code settings
   stow bash      # Bash configuration
   stow zsh       # Zsh configuration
   
   # Or stow all at once
   stow */
   ```

3. **Install required software packages** (see Software & Tools section below)

## 🌍 Cross-Platform Setup

### macOS

1. **Install Homebrew** (if not already installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install compatible tools**:
   ```bash
   # Core tools
   brew install fish starship neovim tmux git stow
   brew install --cask kitty
   
   # Development tools
   brew install ripgrep fzf lazygit
   brew install node bun
   ```

3. **Set Fish as default shell**:
   ```bash
   echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
   chsh -s /opt/homebrew/bin/fish
   ```

4. **Stow configurations**:
   ```bash
   # Only stow compatible configs
   stow fish starship nvim tmux kitty vscode
   ```

### Windows (WSL2)

1. **Install WSL2 with Ubuntu/Arch**:
   ```powershell
   wsl --install -d Ubuntu
   # or for Arch: wsl --install -d ArchWSL
   ```

2. **For Ubuntu WSL**:
   ```bash
   # Update and install tools
   sudo apt update && sudo apt upgrade
   sudo apt install fish neovim tmux git stow curl
   
   # Install additional tools
   curl -sS https://starship.rs/install.sh | sh
   cargo install ripgrep  # or use apt if available
   ```

3. **For Arch WSL**:
   ```bash
   # Use the main install script
   ./install.sh
   ```

4. **Windows Terminal integration**:
   - Install Windows Terminal from Microsoft Store
   - Configure Fish as default profile
   - Import Kitty colorschemes for Windows Terminal

### Other Linux Distributions

#### Ubuntu/Debian
```bash
# Install via apt
sudo apt update
sudo apt install fish neovim tmux git stow
sudo snap install starship

# Manual installations
curl -fsSL https://bun.sh/install | bash
```

#### Fedora
```bash
# Install via dnf
sudo dnf install fish neovim tmux git stow
sudo dnf install starship ripgrep fzf

# Flatpak for additional apps
flatpak install flathub org.kde.konsole
```

### Limitations by Platform

| Feature | Linux | macOS | Windows | WSL2 |
|---------|-------|-------|---------|------|
| Hyprland | ✅ | ❌ | ❌ | ❌ |
| Fish Shell | ✅ | ✅ | ❌ | ✅ |
| Kitty Terminal | ✅ | ✅ | ❌ | ✅ |
| Neovim Config | ✅ | ✅ | ✅ | ✅ |
| Starship Prompt | ✅ | ✅ | ✅ | ✅ |
| AppImages | ✅ | ❌ | ❌ | ❌ |

> **Note:** Hyprland is a Wayland compositor and only works on Linux. For macOS/Windows, consider using alternative window managers or terminal setups.

## 🛠️ Software & Tools

### Core Terminal & Shell
- **Fish Shell** - Modern shell with autocompletion
  ```bash
  sudo pacman -S fish
  chsh -s /usr/bin/fish
  ```

- **Starship** - Cross-shell prompt
  ```bash
  sudo pacman -S starship
  ```

- **Kitty Terminal** - GPU-accelerated terminal emulator
  ```bash
  sudo pacman -S kitty
  ```

- **Ghostty Terminal** - Alternative terminal emulator
  ```bash
  yay -S ghostty
  ```

### Development Tools
- **Neovim** - Modern Vim-based editor
  ```bash
  sudo pacman -S neovim
  ```

- **Tmux** - Terminal multiplexer
  ```bash
  sudo pacman -S tmux
  ```

- **Lazygit** - Simple terminal UI for git
  ```bash
  sudo pacman -S lazygit
  ```

- **Ripgrep** - Fast search tool
  ```bash
  sudo pacman -S ripgrep
  ```

- **FZF** - Fuzzy finder
  ```bash
  sudo pacman -S fzf
  ```

- **Autojump** - Smart directory navigation
  ```bash
  yay -S autojump
  ```

### Window Manager & Desktop
- **Hyprland** - Dynamic tiling Wayland compositor
  ```bash
  sudo pacman -S hyprland
  ```

- **Hyprlock** - Screen locker for Hyprland
  ```bash
  sudo pacman -S hyprlock
  ```

- **Hypridle** - Idle daemon for Hyprland
  ```bash
  sudo pacman -S hypridle
  ```

### Applications (AppImages & Flatpaks)
- **Zen Browser** - Privacy-focused browser
  ```bash
  # Download from zen-browser.app
  ```

- **WakaTime** - Code time tracking
  ```bash
  # Download AppImage from wakatime.com
  ```

### Development Environment
- **Bun** - Fast JavaScript runtime
  ```bash
  curl -fsSL https://bun.sh/install | bash #Linux/wsl
  ```

## 📁 Configuration Overview

### Fish Shell (`fish/`)
- Custom functions for git operations (`gcom`, `lazyg`, `lazygb`)
- Directory navigation helpers (`up`, `mkdirg`, `cpg`, `mvg`)
- Comprehensive aliases for common commands
- Integration with Starship, FZF, and Autojump
- Conda environment management

### Neovim (`nvim/`)
- Lua-based configuration with modern plugin management
- LSP support for multiple languages
- Discord integration for activity tracking
- Custom colorschemes and editor settings
- Plugin management with lazy.nvim

### Hyprland (`hypr/`)
- Modular configuration with separate files for:
  - User settings and preferences
  - Keybindings and shortcuts
  - Window rules and animations
  - Monitor and workspace configuration
  - Startup applications

### Kitty Terminal (`kitty/`)
- Custom color schemes
- Optimized font and rendering settings
- Keyboard shortcuts configuration

### Tmux (`tmux/`)
- Custom key bindings
- Status bar configuration
- Session management settings

### Starship (`starship/`)
- Custom prompt with Git integration
- Language-specific indicators
- Performance optimizations

## 🎯 Usage

### Fish Shell Functions
```bash
# Git operations
gcom "commit message"           # Add, commit
lazyg "commit message"          # Add, commit, push
lazygb "commit message" branch  # Add, commit, push to branch

# Directory navigation
up 3                           # Go up 3 directories
mkdirg new_project            # Create and enter directory
j project                     # Jump to project directory (autojump)

# File operations
cpg file.txt ~/Documents      # Copy and follow
mvg file.txt ~/Documents      # Move and follow
```

### Neovim
- Leader key is set to `<space>`
- Use `:Lazy` to manage plugins
- LSP features available for most languages

### Hyprland
- `Super + Enter` - Open terminal
- `Super + Q` - Close window
- `Super + 1-9` - Switch workspaces
- `Super + Shift + 1-9` - Move window to workspace

## 🎨 Customization

### Modifying Configurations
1. **Fish Shell**: Edit `fish/.config/fish/config.fish`
2. **Neovim**: Modify files in `nvim/.config/nvim/lua/`
3. **Hyprland**: Update configs in `hypr/.config/hypr/UserConfigs/`
4. **Starship**: Edit `starship/.config/starship.toml`

### Adding New Software
1. Update the relevant configuration files
2. Add installation instructions to this README
3. Test the configuration thoroughly

## 🔧 Troubleshooting

### Common Issues

**Fish shell not loading configurations:**
```bash
# Reload Fish configuration
source ~/.config/fish/config.fish
```

**Neovim plugins not working:**
```bash
# Update plugins
:Lazy update
```

**Hyprland not starting:**
```bash
# Check configuration syntax
hyprland --check-config
```

**Stow conflicts:**
```bash
# Remove existing config and re-stow
rm -rf ~/.config/fish
stow fish
```

**Installation script issues:**
```bash
# Make script executable if needed
chmod +x install.sh

# Run with verbose output for debugging
bash -x ./install.sh

# Check specific component installation
./install.sh --dev-only
```

### Application Paths
Most applications are installed in `~/Softwares/` as AppImages. Update paths in Fish config if you install them elsewhere.

## 📝 Notes

- This configuration is optimized for Arch Linux with Fish shell
- Some applications use AppImages stored in `~/Softwares/`
- Custom Fish functions provide enhanced git and directory navigation

## 🤝 Contributing

Feel free to:
- Submit issues for bugs or improvements
- Create pull requests for enhancements
- Share your own customizations

---

*Last updated: July 2025*