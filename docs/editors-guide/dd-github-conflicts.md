# GitHub conflicts

Sometimes a pull request will have a conflict with the base branch. These conflicts can be resolved by rebasing your branch. See more information about rebasing [here](https://git-scm.com/docs/git-rebase).

### Rebase instructions:
1. checkout branch that has conflicts
2. `git rebase master`
3. Make changes in file (open the mondo-edit.obo file in a text editor (like Sublime) and search for the conflicts. These are usually preceeded by <<<<<. Fix the conflicts, then save.) 
4. `git add -A`
5. `git rebase --continue`
6. `git push -f`

See additional documentation about what to do in case of a conflict here: [https://github.com/AgileVentures/MetPlus_PETS/wiki/Developing-a-feature-(or-bug,-chore)](https://github.com/AgileVentures/MetPlus_PETS/wiki/Developing-a-feature-(or-bug,-chore))
