# Basic Git Commands 2
alias gs="git status"                  # Show the working tree status
alias ga="git add"                    # Stage changes
alias gaa="git add --all"             # Stage all changes
alias gp="git push"                   # Push to remote
alias gpl="git pull"                  # Pull from remote
alias gco="git checkout"              # Checkout a branch or commit
alias gcb="git checkout -b"           # Create and switch to a new branch
alias gd="git diff"                   # Show changes
alias gds="git diff --staged"         # Show staged changes
alias gl="git log"                    # Log
alias gl1="git log --oneline"          # Compact log view

# Commit Commands

alias gc="git commit -m"                        # Commit with a message
alias gcm="git commit --amend"                  # Amend the last commit
alias gcn="git commit --amend --no-edit"        # Amend the last commit with no-edit

# Branch Management
alias gb="git branch"                 # List branches
alias gba="git branch -a"             # List all branches (local + remote)
alias gbd="git branch -d"             # Delete a branch
alias gbD="git branch -D"             # Force delete a branch

# Stash Commands
alias gst="git stash"                 # Stash changes
alias gstp="git stash pop"            # Apply the latest stash and remove it
alias gstl="git stash list"           # Show all stashes
alias gsta="git stash apply"          # Apply a specific stash
alias gstd="git stash drop"           # Delete a stash

# Remote Commands
alias gr="git remote -v"              # List remotes
alias gra="git remote add"            # Add a remote
alias gru="git remote update"         # Update remotes
alias grrm="git remote remove"        # Remove a remote

# Fetch and Rebase
alias gf="git fetch"                  # Fetch changes from remote
alias gfa="git fetch --all"           # Fetch all remotes
alias grb="git rebase"                # Rebase current branch
alias grbi="git rebase -i"            # Interactive rebase
alias grbc="git rebase --continue"    # Continue rebase
alias grba="git rebase --abort"       # Abort rebase

# Reset and Clean
alias grs="git reset"                 # Unstage changes
alias grsh="git reset --hard"         # Reset to HEAD and discard changes
alias grs1="git reset HEAD~1"         # Undo the last commit (keep changes)
alias grh="git reset HEAD"            # Unstage files
alias gcl="git clean -fd"             # Remove untracked files and directories

# Tagging
alias gt="git tag"                    # List tags
alias gtn="git tag -n"                # List tags with annotations
alias gta="git tag -a"                # Create an annotated tag
alias gtd="git tag -d"                # Delete a tag
alias gtp="git push origin --tags"    # Push all tags to remote

# Others
alias gsh="git show"                  # Show details of a commit or reference
alias gbl="git blame"                 # Show who changed what in a file
alias gfg="git grep"                  # Search through code
alias gcp="git cherry-pick"           # Apply changes from another commit
alias gsw="git switch"                # Switch branches
alias gswc="git switch -c"            # Create and switch to a branch
