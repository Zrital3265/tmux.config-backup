
if status is-interactive
    # Commands to run in interactive sessions can go here
alias frontend='cd ~/Documents/code/frontend'
alias backend='cd ~/Documents/code/backend'
alias fullstack='cd ~/Documents/code/full-stack'
end

# pnpm
set -gx PNPM_HOME "/home/zrital/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

set -x PATH /home/zrital/.local/bin /home/zrital/.bun/bin:/home/zrital/.bun/bin:/home/zrital/.bun/bin:/home/zrital/.local/share/pnpm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin
set -x PATH /home/zrital/.local/bin /home/zrital/.bun/bin:/home/zrital/.bun/bin:/home/zrital/.bun/bin:/home/zrital/.local/share/pnpm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin

function fish_prompt
    set -l last_status $status
    
    # Current directory (using default color)
    echo -n (prompt_pwd)
    set_color normal

    # Git status
    if test -d .git; or git rev-parse --git-dir >/dev/null 2>&1
        set -l branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
        set -l git_status (git status --porcelain 2>/dev/null)
        
        if test -n "$branch"
            # Branch display in magenta
            set_color normal
            echo -n " [$branch"]
            
            # Count untracked, modified, and staged files
            set -l untracked (git status --porcelain 2>/dev/null | grep -c "^??")
            set -l modified (git status --porcelain 2>/dev/null | grep -c "^.M")
            set -l staged (git status --porcelain 2>/dev/null | grep -c "^[MADRC]")
                        
            # Show untracked files in bright green
            if test $untracked -gt 0
                set_color green
                echo -n " [+$untracked]"
            end
            
            # Show modified files in red
            if test $modified -gt 0
                set_color red
                echo -n " [~$modified]"
            end
   
            # Show staged files in yellow
            if test $staged -gt 0
                set_color blue
                echo -n " [¤$staged]"
            end
            
        end
    end

    # Add the prompt symbol
    set_color normal
    echo -n " \$ "
end
