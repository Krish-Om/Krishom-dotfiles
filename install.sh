#!/bin/sh
# Krishom's Dotfiles Installation Script
# This script checks for installed applications and installs missing ones

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${PURPLE}=== $1 ===${NC}"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if package is installed (pacman)
package_installed() {
    pacman -Qi "$1" >/dev/null 2>&1
}

# Function to check if AUR package is installed
aur_package_installed() {
    yay -Qi "$1" >/dev/null 2>&1 || paru -Qi "$1" >/dev/null 2>&1
}

# Function to install package with pacman
install_package() {
    local package="$1"
    if package_installed "$package"; then
        print_success "$package is already installed"
    else
        print_status "Installing $package..."
        if sudo pacman -S --noconfirm "$package"; then
            print_success "$package installed successfully"
        else
            print_error "Failed to install $package"
            return 1
        fi
    fi
}

# Function to install AUR package
install_aur_package() {
    local package="$1"
    local helper="$2"
    
    if aur_package_installed "$package"; then
        print_success "$package is already installed"
    else
        print_status "Installing $package from AUR..."
        if command_exists "$helper"; then
            if "$helper" -S --noconfirm "$package"; then
                print_success "$package installed successfully"
            else
                print_error "Failed to install $package from AUR"
                return 1
            fi
        else
            print_error "AUR helper ($helper) not found. Please install $package manually"
            return 1
        fi
    fi
}

# Function to check and install AUR helper
check_aur_helper() {
    if command_exists yay; then
        echo "yay"
    elif command_exists paru; then
        echo "paru"
    else
        print_warning "No AUR helper found. Installing yay..."
        if ! package_installed "base-devel" || ! package_installed "git"; then
            sudo pacman -S --noconfirm base-devel git
        fi
        
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ..
        rm -rf yay
        echo "yay"
    fi
}

# Function to setup Fish shell
setup_fish() {
    if package_installed "fish"; then
        print_status "Setting Fish as default shell..."
        if [[ "$SHELL" != *"fish"* ]]; then
            if chsh -s /usr/bin/fish; then
                print_success "Fish shell set as default"
                print_warning "Please log out and log back in for the shell change to take effect"
            else
                print_error "Failed to set Fish as default shell"
            fi
        else
            print_success "Fish is already the default shell"
        fi
    fi
}

# Function to install Bun
install_bun() {
    if command_exists bun; then
        print_success "Bun is already installed"
    else
        print_status "Installing Bun..."
        if curl -fsSL https://bun.sh/install | bash; then
            print_success "Bun installed successfully"
            print_warning "Please restart your terminal or run: source ~/.bashrc"
        else
            print_error "Failed to install Bun"
        fi
    fi
}

# Function to install Node.js and npm
install_nodejs() {
    install_package "nodejs"
    install_package "npm"
}

# Function to create Softwares directory and download AppImages
setup_appimages() {
    local install_dir="$HOME/Softwares"
    mkdir -p "$install_dir"
    
    print_status "AppImage directory created at $install_dir"
    print_warning "Please manually download the following AppImages to $install_dir:"
    echo "  - Zen Browser: https://zen-browser.app"
    echo "  - WakaTime: https://wakatime.com"
    print_warning "Make sure to make them executable with: chmod +x $install_dir/*.AppImage"
}

# Function to stow configurations
stow_configs() {
    if command_exists stow; then
        print_status "Stowing dotfiles configurations..."
        
        local configs=("fish" "nvim" "kitty" "hypr" "tmux" "starship" "ghostty" "vscode" "bash" "zsh")
        
        for config in "${configs[@]}"; do
            if [[ -d "$config" ]]; then
                print_status "Stowing $config configuration..."
                if stow "$config" 2>/dev/null; then
                    print_success "$config configuration linked"
                else
                    print_warning "Failed to stow $config (might already exist)"
                fi
            else
                print_warning "$config directory not found, skipping..."
            fi
        done
    else
        print_error "GNU Stow is required but not installed"
    fi
}

# Function to install prerequisites
install_prerequisites() {
    print_header "Installing Prerequisites"
    install_package "stow"
    install_package "git"
    install_package "base-devel"
}

# Function to install core terminal and shell tools
install_core_tools() {
    print_header "Installing Core Terminal & Shell Tools"
    install_package "fish"
    install_package "starship"
    install_package "kitty"
    
    # Get AUR helper and install ghostty
    local aur_helper
    aur_helper=$(check_aur_helper)
    install_aur_package "ghostty" "$aur_helper"
}

# Function to install development tools
install_dev_tools() {
    print_header "Installing Development Tools"
    install_package "neovim"
    install_package "tmux"
    install_package "lazygit"
    install_package "ripgrep"
    install_package "fzf"
    
    # AUR packages
    local aur_helper
    aur_helper=$(check_aur_helper)
    install_aur_package "autojump" "$aur_helper"
}

# Function to install Hyprland and related tools
install_hyprland() {
    print_header "Installing Hyprland & Desktop Tools"
    install_package "hyprland"
    install_package "hyprlock"
    install_package "hypridle"
}

# Function to install system tools
install_system_tools() {
    print_header "Installing System Tools"
    install_package "multitail"
    install_package "clamav"
}

# Function to install development environment
install_dev_environment() {
    print_header "Installing Development Environment"
    install_bun
    install_nodejs
}

# Function to show post-installation instructions
show_post_install() {
    print_header "Post-Installation Instructions"
    echo
    print_warning "Manual steps required:"
    echo "1. Download AppImages manually (see AppImage section above)"
    echo "2. If you changed your shell to Fish, log out and log back in"
    echo "3. Open Fish shell and run your custom functions"
    echo "4. Configure Hyprland if you plan to use it"
    echo "5. Run 'nvim' and let plugins install automatically"
    echo
    print_success "Installation completed! Enjoy your dotfiles setup!"
}

# Main installation function
main() {
    clear
    print_header "Krishom's Dotfiles Installation Script"
    echo
    print_status "Starting installation process..."
    echo
    
    # Check if running on Arch Linux
    if [[ ! -f /etc/arch-release ]]; then
        print_warning "This script is designed for Arch Linux. Some packages might not be available."
        read -p "Do you want to continue? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_status "Installation cancelled"
            exit 0
        fi
    fi
    
    # Update system
    print_status "Updating system packages..."
    sudo pacman -Syu --noconfirm
    echo
    
    # Install components
    install_prerequisites
    echo
    
    install_core_tools
    echo
    
    install_dev_tools
    echo
    
    install_hyprland
    echo
    
    install_system_tools
    echo
    
    install_dev_environment
    echo
    
    setup_appimages
    echo
    
    # Setup Fish shell
    setup_fish
    echo
    
    # Stow configurations
    stow_configs
    echo
    
    show_post_install
}

# Check if script is run with --help
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Krishom's Dotfiles Installation Script"
    echo
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  --core-only    Install only core tools (fish, starship, kitty)"
    echo "  --dev-only     Install only development tools"
    echo "  --hypr-only    Install only Hyprland and related tools"
    echo "  --stow-only    Only stow configurations (skip package installation)"
    echo
    echo "This script will:"
    echo "  - Check for existing installations"
    echo "  - Install missing packages using pacman and AUR"
    echo "  - Set up Fish shell as default"
    echo "  - Install Bun and Node.js"
    echo "  - Stow dotfiles configurations"
    echo
    exit 0
fi

# Handle specific installation options
case "$1" in
    --core-only)
        install_prerequisites
        install_core_tools
        setup_fish
        ;;
    --dev-only)
        install_prerequisites
        install_dev_tools
        install_dev_environment
        ;;
    --hypr-only)
        install_prerequisites
        install_hyprland
        ;;
    --stow-only)
        if ! command_exists stow; then
            install_package "stow"
        fi
        stow_configs
        ;;
    *)
        main
        ;;
esac
