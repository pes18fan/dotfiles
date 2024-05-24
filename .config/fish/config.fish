# env variables
set -x PATH "$PATH:$HOME/.local/bin"
set -x PATH "$PATH:$HOME/.cargo/bin"
set -x PATH "$PATH:$HOME/Odin/"
set -x PATH "$PATH:$HOME/ols/"
set -x PATH "$PATH:$HOME/zen/bin/rel/"
set -x PATH "$PATH:$HOME/.yarn/bin/"
set -x PATH "$PATH:$HOME/go/bin/"
set -x PATH "$PATH:$HOME/ncal/bin/"

if string match "*WSL*" (uname -r) > /dev/null
    # make wslg work (only wayland works unfortunately)
    ln -s /mnt/wslg/runtime-dir/wayland-0* /run/user/1000/ &> /dev/null

    set -x DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0 #GWSL
    set -x PULSE_SERVER tcp:(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}') #GWSL
    set -x LIBGL_ALWAYS_INDIRECT 1
end

# starship initialization
starship init fish | source

# zoxide initialization
zoxide init fish | source

# param 1: command name
function command_exists
    if ! command -v $argv[1] >/dev/null
        echo "you need $argv[1] to run this command, it isn't installed!"
        return 1
    end

    return 0
end

# aliases
alias ls "eza"
alias la "ls -a"
alias ll "ls -l"
alias tree "ls -T"
alias cls "clear"
alias rm "rm -i"
alias cd "z"
alias icr "crystal i"
alias vim "nvim"

alias open "wsl-open"
alias xdg-open "wsl-open"

if command_exists apt >/dev/null
    alias bat "batcat"
    alias fd "fdfind"
end

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

# Don't have a better name for this right now lol
function effzeeff
    if not command_exists fzf
        echo "you need fzf to run this command, it isn't installed!" 
        return 1
    end

    set -l FIND_CMD fd --hidden
    if not command_exists fd
        set FIND_CMD find
    end

    set -l RES ($FIND_CMD | fzf)

    if test -d "$RES"
        cd $RES
    else if test "$RES" != ""
        nvim $RES
    end
end

# function to compile and run C, C++ and some other range of files
# only works for relative links
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

            gcc $argv[1] -o $OUT && ./$OUT && rm -f $OUT
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

            dart --enable-asserts $argv[1]
        case "*"
            echo "Please input a valid source file!" 1>&2
            echo "Available options: c, cpp, odin, lua, py, cr, rs, dart"
            return 1
    end
end

# same as run but reruns when the file changes.
# requires the inotifywait command to be available.
# param 1: filename
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

# function to make a directory and switch to it
function mkcd
    mkdir $argv[1]
    cd $argv[1]
end

# function to run a sfml program
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

function topdf
    if ! command_exists pandoc
        echo "you need pandoc to run this command, it isn't installed!" 
        return 1
    end

    if ! command_exists weasyprint
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

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
