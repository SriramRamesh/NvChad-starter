# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a Neovim configuration built on **NvChad v2.5**, a comprehensive Neovim distribution that provides a solid foundation with sensible defaults. The configuration extends NvChad with custom plugins and settings.

### Key Components

**Core Structure:**
- `init.lua` - Main entry point, bootstraps Lazy.nvim and loads NvChad
- `lua/chadrc.lua` - NvChad-specific configuration (themes, UI, statusline)
- `lua/plugins/init.lua` - Custom plugin definitions extending NvChad base
- `lua/configs/` - Individual plugin configuration files
- `lua/mappings.lua` - Custom keybindings and overrides

**Plugin Management:**
- Uses **Lazy.nvim** as the plugin manager
- NvChad base plugins are imported via `import = "nvchad.plugins"`
- Custom plugins are defined in `lua/plugins/` directory
- Plugin configurations are modularized in `lua/configs/`

**Language Support:**
- **LSP**: Multiple language servers configured (Go, Python, Lua, TypeScript, F#, Protocol Buffers)
- **Testing**: Neotest with Go support via `neotest-golang`
- **Debugging**: nvim-dap with Go debugging via `nvim-dap-go`
- **Formatting**: Conform.nvim for code formatting

**Key Features:**
- FZF-lua for fuzzy finding (preferred over Telescope)
- Treesitter for syntax highlighting and text objects
- Git integration with advanced linking capabilities
- AI assistance via CodeCompanion
- Jupyter notebook support via Molten
- Advanced navigation with Navbuddy and context display

## Development Commands

**Plugin Management:**
- `:Lazy` - Open Lazy.nvim interface to manage plugins
- `:Lazy sync` - Update and sync all plugins
- `:Mason` - Manage LSP servers, DAP adapters, linters, formatters

**Testing (Go-focused):**
- `<leader>tn` - Run nearest test
- `<leader>tf` - Run all tests in current file
- `<leader>tA` - Run all tests in project
- `<leader>ts` - Toggle test summary
- `<leader>td` - Debug nearest test
- `<leader>to` - Show test output

**Debugging:**
- `<leader>db` - Toggle breakpoint
- `<leader>dc` - Start debugging (continue)
- `<leader>do` - Step over
- `<leader>di` - Step into
- `<leader>dt` - Terminate debug session
- `<leader>du` - Toggle debug UI

**Code Navigation:**
- `<leader><leader>` - Find files (FZF)
- `<leader>sp` - Live grep with glob patterns
- `gd` - Go to definition
- `gr` - Find references
- `gs` - Open Navbuddy (symbol navigation)
- `<leader>cd` - Open diagnostics (Trouble)

**LSP Management:**
- All language servers are configured in `lua/configs/lspconfig.lua`
- Custom server: `pbls` for Protocol Buffer files
- Python uses `basedpyright` for type checking
- Go uses `gopls` with enhanced completion settings

## Custom Keybinding System

The configuration completely overrides NvChad's default keybindings in favor of a custom mapping system defined in `lua/mappings.lua`. Key features:

- Removes default NvChad mappings (lines 5-29)
- Implements modular mapping system via tables (e.g., `M.general`, `M.Neotest`, `M.dap`)
- Uses structured approach: `[key] = { command, description }`
- All mappings are automatically registered via loop at end of file

## File Organization Patterns

**Configuration Files:** Each plugin has its own config file in `lua/configs/` (e.g., `lspconfig.lua`, `telescope.lua`)

**Plugin Definitions:** Main plugin specs in `lua/plugins/init.lua` with dependency management

**Filetype Specific:** Custom filetype settings in `after/ftplugin/` (Python, SQL)

**Theme Customization:** Uses NvChad's base46 system with custom highlight overrides in `chadrc.lua`

## Important Notes

- Configuration disables NvChad's default file explorer in favor of nvim-tree
- Uses FZF-lua as primary finder instead of Telescope
- Includes comprehensive test coverage tooling focused on Go development
- Has specialized support for data science workflows (Molten for Jupyter)
- Font configured for JetBrainsMono Nerd Font
- Lazy loading extensively used for optimal startup performance