# Environment variables
set -x PATH "$PATH:$HOME/.local/bin"
set -x PATH "$PATH:$HOME/.cargo/bin"
set -x PATH "$PATH:$HOME/Odin/"
set -x PATH "$PATH:$HOME/ols/"
set -x PATH "$PATH:$HOME/zen/bin/rel/"
set -x PATH "$PATH:$HOME/.yarn/bin/"
set -x PATH "$PATH:$HOME/go/bin/"
set -x PATH "$PATH:$HOME/ncal/bin/"

# WSL specific stuff
if string match "*WSL*" (uname -r) > /dev/null
    # Some black magic voodoo to make wslg sort of work
    # Only wayland works unfortunately
    ln -s "/mnt/wslg/runtime-dir/wayland-0*" /run/user/1000/ &> /dev/null

    set -x DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0 #GWSL
    set -x PULSE_SERVER tcp:(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}') #GWSL
    set -x LIBGL_ALWAYS_INDIRECT 1

    # Use wsl-open to open files from terminal
    alias open "wsl-open"
    alias xdg-open "wsl-open"
end

# param 1: command name
function command_exists
    if ! command -v $argv[1] >/dev/null
        echo "you need $argv[1] to run this command, it isn't installed!"
        return 1
    end

    return 0
end

# starship initialization
if command_exists starship > /dev/null
    starship init fish | source
end

# zoxide initialization
if command_exists zoxide > /dev/null
    zoxide init fish | source
end


# Aliases
alias ls "eza"
alias la "ls -a"
alias ll "ls -l"
alias tree "ls -T"
alias cls "clear"
alias rm "rm -i" # Good idea to avoid accidentally annihilating files
alias cd "z"
alias icr "crystal i"
alias vim "nvim"

if test "$DESKTOP_SESSION" = "gnome"
    function trash
        if test "$argv[1]" = ""
            echo "What do you wanna trash?"
            return 1
        end

        if not test -e $argv[1]
            echo "$argv[1] does not exist."
            return 1
        end

        if not test -e $HOME/.local/share/Trash
            mkdir -p $HOME/.local/share/Trash/files
            mkdir -p $HOME/.local/share/Trash/info
            mkdir -p $HOME/.local/share/Trash/expunged
        end

        set -l TRASHINFO (echo $HOME/.local/share/Trash/info/"$argv[1]".trashinfo)

        set -l TRASHPATH (realpath $argv[1])
        set -l TRASHDATE (date +%Y-%m-%dT%H:%M:%S)

        echo "[Trash Info]" | tee $TRASHINFO > /dev/null
        echo "Path=$TRASHPATH" | tee -a $TRASHINFO > /dev/null
        echo "DeletionDate=$TRASHDATE" | tee -a $TRASHINFO > /dev/null

        mv $argv[1] $HOME/.local/share/Trash/files
    end
end

# On distros like Debian, Ubuntu, Pop etc which use apt, bat and fd have weird
# differing names to avoid conflicts. I just want my normal command names so
# I alias them here
if command_exists apt >/dev/null
    alias bat "batcat"
    alias fd "fdfind"
end

# Funniest greeting ever
function fish_greeting
    echo (set_color --bold efcf40)">"(set_color ef9540)"<"(set_color ea3838)">"(set_color normal) (random choice "well cum" "welcome") "to fish, the friendly interactive shell"
    echo ""
end

# Strip the (last) extension off a file and print the filename to stdout.
# param 1: filename
function strip_ext
    echo $argv[1] | sed 's/\.[^.]*$//'
end

# Strip the (last) extension off a file and print the extension to stdout.
# param 1: filename
function grab_ext
    echo $argv[1] | sed 's/.*\.//'
end

# Open a fzf window and cd into selected directory or open a file in nvim
function f
    if not command_exists fzf
        echo "you need fzf to run this command, it isn't installed!" 
        return 1
    end

    set -l FIND_CMD fd --hidden
    if not command_exists fd
        set FIND_CMD find
    end

    set -l RES ($FIND_CMD | fzf --preview 'if test -d {}; set --local ed (eza {}); if test -z "$ed" > /dev/null; echo "Folder is empty."; else; eza {}; end; else; bat {}; end')

    if test -d "$RES"
        cd $RES
    else if test "$RES" != ""
        nvim $RES
    end
end

# Function to compile and run various types of source files
# Only works for relative links
function run
    if not test -e $argv[1]
        echo "$argv[1] does not exist."
        return 1
    end

    set -l ext (grab_ext $argv[1])
    set -l OUT (strip_ext $argv[1])

    switch $ext
        case c
            if ! command_exists gcc
                return 1
            end

            gcc $argv[1] -o $OUT $argv[2..] && ./$OUT && rm -f $OUT
        case cpp
            if ! command_exists g++
                return 1
            end

            g++ $argv[1] -o $OUT && ./$OUT && rm -f $OUT
        case odin
            if ! command_exists odin
                return 1
            end

            odin run $argv[1] -file && rm -f $OUT
        case lua
            if ! command_exists lua
                return 1
            end

            lua $argv[1]
        case py
            if ! command_exists python
                return 1
            end

            python $argv[1]
        case cr
            if ! command_exists crystal
                return 1
            end

            crystal run $argv[1]
        case rs
            if ! command_exists rustc
                return 1
            end

            rustc $argv[1] && ./$OUT && rm -f $OUT
        case dart
            if ! command_exists dart
                return 1
            end

            # Allow assertions to work
            dart --enable-asserts $argv[1]
        case "*"
            echo "Please input a valid source file!" 1>&2
            echo "Available options: c, cpp, odin, lua, py, cr, rs, dart" 1>&2
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
    mkdir $argv[1]
    cd $argv[1]
end

# Function to run a sfml program
function sfmlr
    if not command_exists g++
        return 1
    end

	if string match -qr ".cpp\$" $argv[1]
		set OUT (echo $argv[1] | awk '{ print substr( $0, 1, length($0)-4 ) }')

		if string match -qr "^/" $argv[1] # if given argument is absolute path to file
			g++ -c $argv[1]
			g++ $OUT.o -o $OUT -lsfml-graphics -lsfml-window -lsfml-system
			/.$OUT
		else # if given argument is relative path to file
			g++ -c $argv[1] -o $OUT.o
			g++ $OUT.o -o $OUT -lsfml-graphics -lsfml-window -lsfml-system
			./$OUT
		end

		rm -f $OUT $OUT.o
	else
		echo "Please input a valid C++ source file!"
	end
end

# Use pandoc and weasyprint to convert Markdown to PDF
function topdf
    if not command_exists pandoc
        echo "you need pandoc to run this command, it isn't installed!" 
        return 1
    end

    if not command_exists weasyprint
        echo "you need weasyprint to run this command, it isn't installed!" 
        return 1
    end

    set -l source $argv[1]
    set -l output $argv[2]

    if not test -e $source
        echo "$source does not exist."
        return 1
    end

    pandoc $argv[1] --pdf-engine=weasyprint --css=$HOME/.pandoc/print.css -o $argv[2]
end

# Function to automatically recompile a LaTeX source file when
# it is modified. Note that it requires inotify-tools to be
# installed.
function texdf
    if ! command_exists pdflatex
        echo "you need pdflatex to run this command, it isn't installed!" 
        return 1
    end

    if ! command_exists xreader
        echo "you need xreader to run this command, it isn't installed!" 
        return 1
    end

    if ! command_exists inotifywait
        echo "you need inotify-tools to run this command, it isn't installed!" 
        return 1
    end

    set -l tex_file $argv[1]

    if not test -e $tex_file
        echo "$tex_file does not exist."
        return 1
    end

	set -l pdf_file (string replace -r "\\.tex\$" ".pdf" $tex_file)

	pdflatex $tex_file
	xreader $pdf_file &

    while true
        inotifywait -e modify $tex_file

        pdflatex $tex_file
    end
end

# bun stuff
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
