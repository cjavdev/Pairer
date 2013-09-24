# Pairer

## Edge Weights
The class starts out as a fully connected undirected weighted graph. Each node represents a student and each edge holds a value that will determine if they are paired or not. The data is persisted to a yaml file called `pair_log` that is loaded each day and run to create the pairs for the day.

pairs are stored like this:

```yaml
? - justalisteningman
  - giant-squid
: 50
```

If students are not in this list they will be given a default edge weight of 100. Everytime students are paired the weight is naturally halved. Pairing values can be adjusted according to how TA's feel students will pair together.


## RGL

Pairer uses `rgl` (Ruby Graph Library).
Install using `gem install rgl`

## Files

`pairer.rb` is a script that takes up to two arguments being the filenames for a list of students and the `pair_log`.

`podX` is a line separated file with a list of students in podX.

`pair_log` is a yaml formated hash of pair and weights.

Common usage `./pairer.rb pod1` produces an output file in the format pairs_for_podX(Ticks) and updates the pair_log with the history of students adding the current days pairs.

The benefit of keeping a pair_log of all the pairings in every pod is that when pods cross polinate, the pairings for the pod should be generally more unique.