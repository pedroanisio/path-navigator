# path-navigator 🧭

A fast and intuitive CLI tool for navigating to your favorite directories in Linux/Unix shells. Stop typing long paths - just press `n` and select where you want to go!

## Features ✨

- **Quick Navigation**: Jump to any of your saved directories with just a number (1-10)
- **Interactive Menu**: Visual menu with path validation (✓ valid, ✗ invalid)
- **Direct Jump**: Skip the menu entirely with `n 3` to go directly to path #3
- **Custom Paths**: Save up to 10 frequently used directories
- **Persistent Configuration**: Your custom paths are saved between sessions
- **Shell Integration**: Actually changes your current shell directory (not just a subshell)
- **Path Validation**: Shows which paths exist and are accessible
- **Home Path Expansion**: Supports `~` for home directory

## Demo 📸

```bash
➜ ~ n
📁 Path Navigator - Select a directory:
----------------------------------------
  1. ✓ ~
  2. ✓ ~/Documents
  3. ✓ ~/Downloads
  4. ✓ /var/log
  5. ✓ /etc
  6. ✓ /usr/local
----------------------------------------
  e. Edit paths
  q. Quit

Select (1-6, e, q): 5
📍 Changed to: /etc
➜ /etc
```

## Installation 🚀

### Prerequisites

- Python 3.x
- Bash or Zsh shell
- Debian/Ubuntu (or any Linux distribution)

### Step 1: Install the Python Script

```bash
# Create a bin directory in your home (if it doesn't exist)
mkdir -p ~/bin

# Download or create the script
nano ~/bin/path_navigator.py

# Paste the Python script content and save (Ctrl+X, Y, Enter)

# Make it executable
chmod +x ~/bin/path_navigator.py
```

### Step 2: Add Shell Function to Your Shell Config

#### For Bash Users

```bash
# Add to ~/.bashrc
cat >> ~/.bashrc << 'EOF'

# Path Navigator Function
nav() {
    local chosen_path
    chosen_path=$(python3 ~/bin/path_navigator.py "$@")
    
    if [ $? -eq 0 ] && [ -n "$chosen_path" ]; then
        cd "$chosen_path"
        echo "📍 Changed to: $(pwd)"
    fi
}

# Aliases
alias n='nav'
alias nedit='python3 ~/bin/path_navigator.py --edit'
alias nlist='python3 ~/bin/path_navigator.py --list'
alias ndebug='python3 ~/bin/path_navigator.py --debug'

# Quick jump aliases (optional)
alias n1='nav 1'
alias n2='nav 2'
alias n3='nav 3'
alias n4='nav 4'
alias n5='nav 5'
alias n6='nav 6'
alias n7='nav 7'
alias n8='nav 8'
alias n9='nav 9'
alias n10='nav 10'
EOF

# Reload configuration
source ~/.bashrc
```

#### For Zsh Users

```bash
# Add to ~/.zshrc (same content as above)
# Then reload:
source ~/.zshrc
```

## Usage 📖

### Basic Commands

| Command | Description |
|---------|-------------|
| `n` | Show interactive menu and navigate |
| `n 3` | Jump directly to path #3 (no menu) |
| `nedit` | Edit your saved paths |
| `nlist` | List all configured paths |
| `ndebug` | Show debug information |

### Quick Jump Shortcuts

| Shortcut | Equivalent | Description |
|----------|------------|-------------|
| `n1` | `n 1` | Jump to path #1 (usually home) |
| `n2` | `n 2` | Jump to path #2 |
| ... | ... | ... |
| `n10` | `n 10` | Jump to path #10 |

### Interactive Menu Options

- **1-10**: Select a path to navigate to
- **e**: Enter edit mode to customize paths
- **q**: Quit without changing directory

### Edit Mode Commands

- **a**: Add a new path
- **d**: Delete a path by number
- **r**: Reset to default paths
- **s**: Save changes and exit
- **q**: Quit without saving

## Configuration 📁

### Config File Location

```
~/.config/path_navigator/paths.json
```

### Default Paths

1. `~` (Home directory)
2. `~/Documents`
3. `~/Downloads`
4. `/var/log`
5. `/etc`
6. `/usr/local`

### Customizing Paths

```bash
# Method 1: Use the edit command
nedit

# Method 2: Edit the config file directly
nano ~/.config/path_navigator/paths.json
```

Example config file:

```json
{
  "paths": [
    "/home/username",
    "/home/username/projects",
    "/var/www/html",
    "/etc/nginx",
    "/opt/docker",
    "/usr/local/bin"
  ]
}
```

## Examples 🎯

### Example 1: Quick Home Navigation

```bash
# From anywhere, go home instantly
n1
# or
n 1
```

### Example 2: Add Your Project Directory

```bash
nedit
# Press 'a' to add
# Enter: ~/projects/my-app
# Press 's' to save
```

### Example 3: Navigate to Logs

```bash
# If /var/log is path #4
n 4
# Now you're in /var/log
```

### Example 4: Check Your Paths

```bash
nlist

📁 Configured paths:
----------------------------------------
  1. ✓ ~
  2. ✓ ~/projects
  3. ✓ ~/Documents
  4. ✓ /var/log
  5. ✓ /etc
  6. ✗ /some/invalid/path

Total: 6 paths configured
```

## Advanced Features 🔧

### Path Validation

- ✓ indicates the path exists and is accessible
- ✗ indicates the path doesn't exist or isn't accessible
- You can still save invalid paths (they might be mounted later)

### Direct Navigation

Skip the menu when you know the path number:

```bash
n 5  # Goes directly to path #5
```

### Debugging

If something isn't working:

```bash
ndebug
```

This shows:

- Config file location
- File permissions
- Current configuration
- Loaded paths

## Troubleshooting 🔍

### Paths Not Saving

1. Check permissions: `ndebug`
2. Ensure config directory exists: `ls -la ~/.config/path_navigator/`
3. Try saving again with `nedit`

### Command Not Found

1. Ensure the script is executable: `chmod +x ~/bin/path_navigator.py`
2. Reload your shell config: `source ~/.bashrc` or `source ~/.zshrc`
3. Check if Python 3 is installed: `python3 --version`

### Menu Shows Wrong Number of Paths

- The tool supports up to 10 paths
- Use `nlist` to see all configured paths
- Use `nedit` to add or remove paths

## Technical Details 🛠

### How It Works

1. The Python script handles the menu and path selection
2. It outputs the selected path to stdout
3. The shell function captures this output
4. The shell function performs the actual `cd` command
5. This allows changing the parent shell's directory (not possible from a subprocess)

### File Structure

```
~/
├── bin/
│   └── path_navigator.py          # Main Python script
└── .config/
    └── path_navigator/
        └── paths.json              # Saved paths configuration
```

### Requirements

- Python 3.x (uses pathlib, json)
- Unix-like shell (Bash, Zsh)
- Read/write permissions for ~/.config directory

## Contributing 🤝

Feel free to modify the script to suit your needs! Some ideas for enhancements:

- Add path history/frecency tracking
- Integrate with fuzzy finders (fzf, etc.)
- Add path categories or tags
- Support for bookmarking paths with names
- Integration with project management tools

## License 📄

This tool is provided as-is for personal use. Feel free to modify and share!

## Author ✍️

Created for easy directory navigation on Debian/Linux systems.

---

**Pro Tip**: Add your most frequently used directories and use the number shortcuts (`n1`, `n2`, etc.) for lightning-fast navigation! 🚀
