# Pairer

## RGL

Pairer uses `rgl` (Ruby Graph Library).
Install using `gem install rgl`

## Files

`pairer.rb` is a script that takes up to two arguments being the filenames for a list of students and the `pair_log`.

`podX` is a line separated file with a list of students in podX.

`pair_log` is a yaml formated hash of pair and weights.

Common usage: `./pairer.rb pod1`.