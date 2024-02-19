# env variables
set -x GPG_TTY $(tty)
set -x EDITOR "vim"
set -x PAGER "less"
set -x PATH "$PATH:/home/vexe41/.local/bin:/home/vexe41/.cargo/bin"
set -x PATH "$PATH:/home/vexe41/Odin:/home/vexe41/craftinginterpreters/"
set -x PATH "$PATH:/home/vexe41/zen/bin/rel/"

# starship initialization
starship init fish | source

# zoxide initialization
zoxide init fish | source

# aliases
alias ls "exa"
alias la "ls -a"
alias ll "ls -l"
alias tree "ls -T"
alias cls "clear"
alias rm "rm -i"
alias cd "z"
alias icr "crystal i"
alias vim "nvim"
alias vide "neovide.exe --multigrid --wsl"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
    echo "well cum"
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

# Function to automatically recompile a LaTeX source file when
# it is modified. Note that it requires inotify-tools to be
# installed.
function texdf
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
