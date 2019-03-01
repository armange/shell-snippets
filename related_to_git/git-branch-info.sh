#!/bin/bash

find_any_branch() {
    branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
}

get_commits_behind() {
    if [ -n "$branch" ]; then
       echo -e '\u2193'`git rev-list --count origin/$branch --not $branch`
    else
       echo ""
    fi
}

get_commits_ahead() {
    if [ -n "$branch" ]; then
        echo -e '\u2191'`git rev-list --count $branch --not origin/$branch`
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

(get_branch_info)
