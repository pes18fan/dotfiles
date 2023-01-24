# env variables
set -x EDITOR "vim"
set -x PAGER "less"
set -x PATH "$PATH:/home/vezei/.local/bin"

# starship initialization
starship init fish | source

# zoxide initialization
zoxide init fish | source

# aliases
alias ls "exa"
alias la "ls -a"
alias ll "ls -l"
alias lal "ls -la"
alias tree "ls -T"
alias cls "clear"
alias rm "rm -i"
alias cd "z"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
    echo "well cum"
end

# functions
# function to compile and run a c or c++ source file
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
		g++ -c $argv[1]
		g++ $OUT.o -o $OUT -lsfml-graphics -lsfml-window -lsfml-system
		./$OUT
		rm -f $OUT $OUT.o
	else
		echo "Please input a C++ source file!"
	end
end

thefuck --alias | source
