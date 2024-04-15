# env variables
set -x GPG_TTY $(tty)
set -x EDITOR "vim"
set -x PAGER "less"
set -x PATH "$PATH:$HOME/.local/bin"
set -x PATH "$PATH:$HOME/.cargo/bin"
set -x PATH "$PATH:$HOME/Odin"
set -x PATH "$PATH:$HOME/zen/bin/rel/"
set -x PATH "$PATH:$HOME/.yarn/bin"
set -x PATH "$PATH:$HOME/go/bin"
set -x PATH "$PATH:$HOME/ncal/bin/"

set -x DISPLAY :0
set -x LIBGL_ALWAYS_INDIRECT 1

# starship initialization
starship init fish | source

# zoxide initialization
zoxide init fish | source

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
alias vide "neovide.exe --wsl"

function fish_greeting
    echo (set_color --bold efcf40)">"(set_color ef9540)"<"(set_color ea3838)">"(set_color normal) $(random choice "well cum" "welcome") "to fish, the friendly interactive shell"
    echo ""
    if command -v ncal >/dev/null
        ncal
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# functions
# function to compile and run a c or c++ source file
# only works for relative links
function crun
	if string match -qr ".c\$" $argv[1]
		set OUT $(echo $argv[1] | awk '{ print substr( $0, 1, length($0)-2 ) }')
		gcc $argv[1] -o $OUT && printf "Compilation complete, running...\n\n" && ./$OUT && rm -f $OUT
	else if string match -qr ".cpp\$" $argv[1]
		set OUT $(echo $argv[1] | awk '{ print substr( $0, 1, length($0)-4 ) }')
		g++ $argv[1] -o $OUT && printf "Compilation complete, running...\n\n" && ./$OUT && rm -f $OUT
	else
		echo "Please input a C or C++ source file!"
	end
end

# function to make a directory and switch to it
function mkcd
    mkdir $argv[1]
    cd $argv[1]
end

# function to run a sfml program
function sfmlr
	if string match -qr ".cpp\$" $argv[1]
		set OUT $(echo $argv[1] | awk '{ print substr( $0, 1, length($0)-4 ) }')

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
    if ! command -v pandoc >/dev/null
        echo "you need pandoc to run this command, it isn't installed!" 
        return 1
    end

    if ! command -v weasyprint >/dev/null
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
    if ! command -v pdflatex >/dev/null
        echo "you need pdflatex to run this command, it isn't installed!" 
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
