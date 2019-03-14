#!/bin/bash

find_any_branch() {
    branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
}

get_commits_behind() {
    if [ -n "$branch" ]; then
       echo -e '\u2193'`git rev-list --count origin/$branch --not HEAD`
    else
       echo ""
    fi
}

get_commits_ahead() {
    if [ -n "$branch" ]; then
        echo -e '\u2191'`git rev-list --count HEAD --not origin/$branch`
    else
        echo ""
    fi
}

get_branch_info() {
    find_any_branch
    if [ -n "$branch" ]; then
        verify=`git rev-parse --quiet --verify origin/$branch`
        if [ -n "$verify" ]; then
            behind=get_commits_behind
            ahead=get_commits_ahead
            echo '('$branch `$behind` `$ahead`')'
        else
            echo -e '('$branch '\u003f)'
        fi
    else
        echo ""
    fi
}


#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[33m\]$(get_branch_info)\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi


(get_branch_info)
