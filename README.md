# Pairer

## RGL

Pairer uses `rgl` (Ruby Graph Library).
Install using `gem install rgl`

## Files

`pairer.rb` is a script that takes up to two arguments being the filenames for a list of students and the `pair_log`.

`podX` is a line separated file with a list of students in podX.

`pair_log` is a yaml formated hash of pair and weights.

Common usage `./pairer.rb pod1` produces an output file in the format pairs_for_podX(Ticks) and updates the pair_log with the history of students adding the current days pairs.

The benefit of keeping a pair_log of all the pairings in every pod is that when pods cross polinate, the pairings for the pod should be generally more unique.