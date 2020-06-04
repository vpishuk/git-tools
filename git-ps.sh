c_reset='\[\e[0m\]'
c_red='\[\033[0;31m\]'
c_yellow='\[\033[0;33m\]'
c_green='\[\033[0;32m\]'
c_blue='\[\033[0;34m\]'
c_red_light='\[\033[1;31m\]'
c_green_light='\[\033[1;32m\]'
c_white='\[\033[1;37m\]'
c_gray_light='\[\033[0;37m\]'

# Function to assemble the Git part of our prompt.
git_prompt()
{
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        return 0
    fi

    git_status="$(git status 2> /dev/null)"
    git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
    
    branch_pattern="^# On branch ([^${IFS}]*)"
    detached_branch_pattern="# Not currently on any branch"
    remote_pattern="# Your branch is (.*) of"
    diverge_pattern="# Your branch and (.*) have diverged"

    # color for branch
    c_branch="${c_green}"
    if [[ ${git_status}} =~ "Changed but not updated" ]]; then
        c_branch="${c_red_light}"
    fi

    # branch name
    if [[ ${git_status} =~ ${branch_pattern} ]]; then
        branch=${BASH_REMATCH[1]}
    elif [[ ${git_status} =~ ${detached_branch_pattern} ]]; then
        branch="${c_white}NO BRANCH"
    fi

    # compare to remote
    if [[ ${git_status} =~ ${remote_pattern} ]]; then
        if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
            remote="${c_yellow}↑"
        else
            remote="${c_yellow}↓"
        fi
    fi
    if [[ ${git_status} =~ ${diverge_pattern} ]]; then
        remote="${c_yellow}↕"
    fi

    echo " [${c_branch}${git_branch}${branch}${remote}${c_reset}]"
}
 
# Thy holy prompt.
if [ $UID -eq 0 ]; then
    fin="#"
else
    fin="\$"
fi
PROMPT_COMMAND='PS1="${c_yellow}\u${c_reset}:${c_gray_light}\w${c_reset}$(git_prompt)${fin} "'

alias lrebase='git stash && git pull --rebase && git stash pop'
alias gti=git

alias gc='git commit'
alias gs='git status'
alias ga='git add'
