# git-tools

This repo includes a few pretty useful command-line utilities.
1. `git review [branch]` - Creates a PR in github
2. `git prune-all [branch]` - Removes all branches which were removed in remote repo
3. `git take-issue [issueId]` - Creates a feature branch, or checkout existing branch

To install all of this scripts, simply run `./install` script.


## git take-issue

This script is responsible to simplify workflow with feature branches
It creates a branch for an issue in the format `[owner]/[issueId]`
and pushes it to remote repo.
How does it work:
1. If there is a local or remote branch with the same issue id
   it suggests to switch to one of the branches or create a new solution
2. If the issue is a part of epic, then it will create a branch
   for epic (if it doesn't exist) and start an issue's branch from epic's branch

Useage:
```
   take_issue [issueId]
```

Installation:
Put this file to some place then and `chmod +x /path/to/script`
If yoo want to have a git alias for it, you can run the following command:
`set +H && git config --global alias.take-issue "!f(){ ~/path/to/script $1; }; f" && set -H`

## git review

This script is responsible to simplify review request workflow
It creates a PR by using data from git.

Useage:
```
   review [baseBranch]
```

Installation:
Put this file to some place then and `chmod +x /path/to/script`
If yoo want to have a git alias for it, you can run the following command:
`set +H && git config --global alias.review "!f(){ ~/path/to/script/review $1; }; f" && set -H`

## git prune-all

This script is responsible to clean up local repository.
If you work hard, your local repository will contain hundreds of branches
which does not exist in the remote repo.

Useage:
```
   prune-all
```

Installation:
Put this file to some place then and `chmod +x /path/to/script`
If yoo want to have a git alias for it, you can run the following command:
`set +H && git config --global alias.prune-all "!f(){ ~/path/to/script/prune-all $1; }; f" && set -H`
