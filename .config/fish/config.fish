# WSL specific stuff
if string match "*WSL*" (uname -r) > /dev/null
    # Some black magic voodoo to make wslg sort of work
    # Only wayland works unfortunately
    ln -s "/mnt/wslg/runtime-dir/wayland-0*" /run/user/1000/ &> /dev/null

    # Use wsl-open to open files from terminal
    alias open "wsl-open"
    alias xdg-open "wsl-open"
end

# param 1: command name
function command_exists
    if not command --query $argv[1]
        echo "you need $argv[1] to run this command, it isn't installed!"
        return 1
    end

    return 0
end

# param 1: command name
function require
    command_exists $argv[1]
    or return 1
end

# Change directory to the one received from lf via the named pipe
function lf_cd_handler --on-signal USR1
    set --local fifo /tmp/lf_cwd_"$fish_pid".fifo
    set --local dir (timeout 1s cat "$fifo" 2>/dev/null)

    if test $status -ne 0
        echo "lf: timed out waiting for directory on fifo"
        return
    end

    if test -n "$dir" -a -d "$dir"
        cd "$dir"
        commandline --function repaint
    end
end

# startup lf, but not before setting up a named pipe for parent shell cd commands
function lf --wraps="lf"
    rm -f /tmp/lf_cwd_"$fish_pid".fifo
    mkfifo /tmp/lf_cwd_"$fish_pid".fifo
    env LF_PARENT_PID="$fish_pid" lf
    rm -f /tmp/lf_cwd_"$fish_pid".fifo
end

function fish_greeting
    echo (set_color --bold efcf40)">"(set_color ef9540)"<"(set_color ea3838)">"(set_color normal) "welcome to fish, the friendly interactive shell"
    echo ""
end

# Run lazygit on the yadm repo
function lyd
    require yadm; or return 1
    require lazygit; or return 1

    yadm enter lazygit
end

# Open a fzf window and cd into selected directory or open a file in nvim
function f
    require fzf; or return 1

    set -l FIND_CMD fd --hidden
    if not command --query fd
        set FIND_CMD "find ."
    end

    set -l CD_CMD z
    if not command --query zoxide
        set CD_CMD cd
    end

    set -l RES ($FIND_CMD | fzf --ignore-case --preview 'if test -d {}; set --local ed (eza {}); if test -z "$ed" > /dev/null; echo "Folder is empty."; else; eza {}; end; else; bat {}; end')

    if test -d "$RES"
        $CD_CMD $RES
    else if test "$RES" != ""
        nvim $RES
    end
end

# Function to compile and run various types of source files
# Only works for relative links
# If extra arguments are passed, those will go to the compiler or interpreter
function run
    if not test -e $argv[1]
        echo "$argv[1] does not exist."
        return 1
    end

    set -l ext (path extension $argv[1])
    set -l OUT (path basename -E $argv[1])

    switch $ext
        case .c
            require gcc; or return 1

            gcc $argv[1] -o $OUT $argv[2..] && ./$OUT && rm -f $OUT
        case .cpp
            require g++; or return 1

            g++ $argv[1] -o $OUT $argv[2..] && ./$OUT && rm -f $OUT
        case .odin
            require odin; or return 1

            odin run $argv[1] -file $argv[2..] && rm -f $OUT
        case .lua
            require lua; or return 1

            lua $argv[1] $argv[2..]
        case .py
            require python; or return 1

            python $argv[1] $argv[2..]
        case .cr
            require crystal; or return 1

            crystal run $argv[1] $argv[2..]
        case .rs
            require rustc; or return 1

            rustc $argv[1] $argv[2..] && ./$OUT && rm -f $OUT
        case .dart
            require dart; or return 1

            # Allow assertions to work
            dart --enable-asserts $argv[1] $argv[2..]
        case .zn
            require zen; or return 1

            zen $argv[1] $argv[2..]
        case "*"
            echo "Please input a valid source file!" 1>&2
            echo "Available options: c, cpp, odin, lua, py, cr, rs, dart, zn" 1>&2
            return 1
    end
end

# Same as run but reruns when the file changes.
# Requires the inotifywait command to be available.
# Param 1: filename
function wrun
    if not command_exists inotifywait
        echo "you need inotify-tools to run this command, it isn't installed!" 
        return 1
    end

    if not run $argv[1]
        return 1
    end

    while true
        inotifywait -e modify $argv[1] &>/dev/null
        
        clear
        run $argv[1]
    end
end

# Function to make a directory and switch to it
# Simple but quite useful
function mkcd
    mkdir -p $argv[1]
    and cd $argv[1]
end

# Grab a cheatsheet of the provided topic
function cht
    curl -s "cht.sh/$argv[1]" | less -R
end

# get the ssh-agent variable
set --export SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

# zoxide initialization
if command --query zoxide
    zoxide init fish | source
end

# Aliases
if command --query eza
    function ls --wraps="eza"
        eza $argv
    end

    function tree --wraps="eza"
        eza -T $argv
    end
end

alias la "ls -a"
alias ll "ls -l"
alias cls "clear"

alias rm "rm -i" # Good idea to avoid accidentally annihilating files

if command --query fastfetch
    alias neofetch "fastfetch --config neofetch"
end

# env vars
if command --query helium-browser
    set --export BROWSER "helium-browser"
end

if command --query nvim
    set --export EDITOR "nvim"
else
    set --export EDITOR "vim"
end

set --export OPENER "xdg-open"

# On distros like Debian, Ubuntu, Pop etc which use apt, bat and fd have weird
# differing names to avoid conflicts. I just want my normal command names so
# I alias them here
if command --query apt
    alias bat "batcat"
    alias fd "fdfind"
end
