# 🐧 My Linux Configuration Files

A collection of my personal Linux configuration files (some of which were taken from other users repositories)

## 📋 Overview

This repository mainly just consists of  common nordic theme and nvim plugins for creating a basic IDE

## 🎨 Theme

- **Main Theme**: `Nordic`
- **Color Scheme**: Consistent Nordic palette across all/most applications
- **Terminal**: **Alacritty** with Nordic colors

## 🔧 Core Components

### **Neovim**
- **Configuration Language**: Lua
- **Plugin Manager**: Lazy.nvim
- **Key Features**:
  - ✅ LSP support for multiple languages
  - 🔍 Telescope fuzzy finder
  - 🌳 Treesitter syntax highlighting
  - ❄️ Nord color scheme integration

### **i3 Window Manager**
- **Gaps**: Smart gaps with i3-gaps
- **Workspaces**: 10 standard workspaces (1-0)
- **Keybindings**: Customized for efficient window management and application launching (e.g. browser $MOD + b)
- **Status Bar**: Polybar with Nordic theme

### **Alacritty Terminal**
- **Font**: JetBrains Mono Nerd Font 
- **Colors**: Nordic theme palette

## 📦 Plugin Highlights

### Neovim Plugins
- `nvim-treesitter` - Enhanced syntax highlighting
- `telescope.nvim` - Fuzzy finder
- `nvim-lspconfig` - LSP integration  
- `nord.nvim` - Nord theme for Neovim
- `lazy.nvim` - Plugin manager
- `nvim-cmp` - Autocompletion
- `nvim-harpoon` - The greatest file hopper known to man

### i3 Ecosystem
- `i3-gaps` - Window gaps
- `polybar` - Status bar (not implemented yet or config doesnt work)
- `rofi` - Application launcher
- `picom` - Compositor for effects
- `feh` - Wallpaper management
