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
    function neofetch --wraps="fastfetch"
        fastfetch --config neofetch $argv
    end
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

function fish_greeting
    echo (set_color --bold efcf40)">"(set_color ef9540)"<"(set_color ea3838)">"(set_color normal) "welcome to fish, the friendly interactive shell"
    echo ""
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
    env LF_PARENT_PID="$fish_pid" lf $argv
    rm -f /tmp/lf_cwd_"$fish_pid".fifo
end

# param 1: command name
function require
    if not command --query $argv[1]
        echo "you need $argv[1] to run this command, it isn't installed!"
        return 1
    end

    return 0
end

# Run lazygit on the yadm repo
function lyd
    require yadm; or return 1
    require lazygit; or return 1

    yadm enter lazygit
end

# Kill a hyprland/graphical session and shut down (via hyprshutdown if it is available)
function die
    if test "$argv[1]" != "now"
        read -p "set_color red; echo -n 'Shutdown? '; set_color --reset; echo -n '[y/N] '" -l QUERY
        if test "$QUERY" != 'y'
            return
        end
    end

    if command --query hyprshutdown
        hyprshutdown --post-cmd 'poweroff'
    else if command --query hyprctl
        hyprctl dispatch "hl.dsp.exit()"
        poweroff
    else if test -n "$XDG_CURRENT_DESKTOP" && command --query $XDG_CURRENT_DESKTOP
        kill -TERM $XDG_CURRENT_DESKTOP
        poweroff
    else
        poweroff
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
    require inotifywait; or return 1
    run $argv[1]; or return 1

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

# Create a temporary scratch workspace (directory) and open a shell in it
# Once you close the shell the entire directory will be deleted
function scr
    argparse 'h/help' 'r/record' -- $argv; or return
    if set -ql _flag_h
        echo "usage: scr [-h | --help] [-r | --record]"
        return 0
    end

    if set -ql _flag_record
        require asciinema; or return 1
    end

    set -l tdir "/tmp/scratch-$(random)"
    mkdir -p $tdir
    pushd $tdir
    echo "entering scratch workspace"
    if set -ql _flag_record
        asciinema record $HOME/"$(basename $tdir)"_recording.txt -c 'env SCRATCH_WORKSPACE=$tdir fish -C \
            \'functions -c fish_prompt __fish_prompt_orig; function fish_prompt; echo [(set_color red)scratch(set_color --reset)]; __fish_prompt_orig; end\''
    else
        env SCRATCH_WORKSPACE=$tdir fish -C \
            'functions -c fish_prompt __fish_prompt_orig; function fish_prompt; echo [(set_color red)scratch(set_color --reset)]; __fish_prompt_orig; end'
    end
    echo "exiting scratch workspace"
    popd
    rm -rf $tdir
end

# Copy the current scratch workspace to $HOME
# Only works when within a scratch workspace, of course
function scrsave
    if not test -n "$SCRATCH_WORKSPACE"
        echo "not in a scratch workspace!"
        return 1
    end

    set -l destname $argv[1]
    if test -z "$destname"
        set destname (basename "$SCRATCH_WORKSPACE")
    end

    cp -r "$SCRATCH_WORKSPACE" "$HOME/$destname"
    echo "scratch workspace saved as ~/$destname!"
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
