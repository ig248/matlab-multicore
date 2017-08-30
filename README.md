# matlab-multicore
Parallel computing without the Parallel Computing Toolbox

This is basically a "fork" of https://uk.mathworks.com/matlabcentral/fileexchange/13775-multicore-parallel-processing-on-multiple-cores, with some convenience functions added for my own convenience.

All credit goes to [Markus Buehren](https://uk.mathworks.com/matlabcentral/profile/authors/545430-markus-buehren)

## Changes
- added `spawnmulticoreslaveinstances` and `killmulticoreslaveinstances` functions to automate instance launching
- made code usable as a package (simply copy files to `path\+multicore\`)

## Basic usage
The simplest usage example is:

```MATLAB
multicore.spawnmulticoreslaveinstances;
results = multicore.startmulticoremaster(@functionHandle, parameterCell);
multicore.killmulticoreslaveinstances;
```

This will
- determine the number of available (physical) cores on the local machine
- start slave instances such that the total number of workers (including master) matches the number of cores
- perform the calculations
- remove all temp files
- shut down all slaves

## Advanced usage
```MATLAB
multicoreDir = multicore.spawnmulticoreslaveinstances(n_slaves, multicoreDir, settings)
```
allows to pass the same `settings` to each of `n_slaves`, using `multicoreDir` for the job pool.

Additional machines can be pointed at the same `multicoreDir`.

```MATLAB
multicore.killmulticoreslaveinstances(multicoreDir);
```
will shut down all slaves working on the job pool in `multicoreDir`
