# JDbrowser - Terminal TUI Sqlite Browser V1.4 (FORK)

Browse an Sqlite database from the terminal with a text user interface.

![table_view](docs/t_view.png)

## Fork Changes

This fork includes several enhancements over the original:

### Static Linking
- **No GLIBC dependencies**: Binary is statically linked using musl, works on any Linux system
- Bundled SQLite library for complete portability
- Single binary with no external dependencies

### Enhanced Navigation
- **Arrow key support**: Use arrow keys (↑↓←→) in addition to vim-style keys (hjkl)
- **Tab key focus switching**: Press Tab to switch between navigation panel and table data panel
- **Visual focus indicators**: Double borders show which panel is currently focused
- **'q' key to quit**: Exit the application with 'q' in addition to Escape

### Developer Experience
- **Context-aware footer**: Shows relevant keybindings based on current focus
- Updated to latest dependencies (ratatui 0.30, rusqlite 0.38) 

# Usage

- Run the application from the directory containing the database.

```bash
jdbrowser
```

- Select your database from the initial file menu.

> [!NOTE]
> File menu looks for files with extentions ".db", ".sqlite3", ".db3". To open databases with custom extenstions types, see "Open File Directly".

- Use the keybindings to browse the tables and views of your database.

- Copy data to clipboard with `y` key. ( On wayland clipboard text is cleared after exiting JDbrowser )

### Open File Directly

You can open a database file directly by passing the file path as an argument.

```bash
jdbrowser -f file_name.my_wierd_extention
```

## Key Binds

### General

| Action | Keybind |
| -------------- | --------------- |
| Switch Focus Panel | Tab |
| Exit Application | Escape / q |
| Help Menu Open/Close | ? | 

### File Menu

| Action | Keybind |
| ------------- | -------------- |
| Up        |  k / ↑        |
| Down      |  j / ↓        |
| Select    |  Enter    |

### Main view left side navigation

| Action | Keybind |
| ------------- | -------------- |
| Show Table/Views        |  q, e        |
| Up        |  shift + k / ↑        |
| Down      |  shift + j / ↓        |

### Table View

| Action | Keybind |
| ------------- | -------------- |
| View Data/Schema        |  shift + h, l        |
| Page Up / Down Half |  u, d |  
| Move Cell Up | k / ↑    |
| Move Cell Down | j / ↓ |
| Move Cell Left| h / ← |
| Move Cell Right | l / → |
| Yank Cell to Clipboard | y |


# Installation and Building

### Prerequisites

For static linking (recommended), you need musl-tools:

```bash
# Ubuntu/Debian
sudo apt-get install musl-tools

# Arch Linux
sudo pacman -S musl

# Then add the musl target
rustup target add x86_64-unknown-linux-musl
```

### Quick Build (Recommended)

Use the included Makefile for easy building:

```bash
# Build statically-linked release binary
make

# Copy to local and remote locations
make copy

# Install to /usr/local/bin
make install

# Check if binary is statically linked
make check-static
```

The binary will be available at `target/x86_64-unknown-linux-musl/release/jdbrowser`

### Arch Linux

You can install JDbrowser from the AUR. Example using yay.

```bash
yay -S jdbrowser-git
```

### Download Binary

Binaries are available for download [Here](https://github.com/Jkeyuk/JDbrowser/releases) 

Simply download the binary run `chmod +x ./jdbrowser` and use where ever you want.

### Install With Rust

A simple way to install the binary using Rust:

```bash
cargo install --path .
```

### Build with Rust Manually

Build a statically-linked binary (recommended):

```bash
cargo build --release --target x86_64-unknown-linux-musl
```

Or build with system glibc (may have compatibility issues):

```bash
cargo build --release 
```

The binary will be available at:
- Static: `target/x86_64-unknown-linux-musl/release/jdbrowser`
- Dynamic: `target/release/jdbrowser`

# Screen Shots

![file_menu](docs/f_view.png) 

![schema_view](docs/s_view.png) 

# TODO

- error handling popup
- handle blob data
