# COMPSCI 230 Computer Systems Principles
# Threads Lab

To start working on this lab you must be logged in to the Edlab and in your
`cs230` directory. From this directory run the command:

```
$ git clone https://github.com/umass-cs-230/230-lab-threads
```

In the folder you just downloaded, you will find afolder `src`, as well as a
`Makefile`. In the `src` folder you are given a header file `challenge.h` and
its associated C file `challenge.c`. All the work you need to do is in
`src/challenge.c`. You are also given a file `main.c`, which has the `main()`
function. This exists purely for your use for testing and debugging.

The program keeps track of how many times each of the four "directions" have
been incremented. The variables that keep track of the counts are `acc_up`,
`acc_down`, `acc_left`, and `acc_right`. The functions that increment the counts
are:

* `count_up`: This function increments `acc_up` `argp->N` times, and sleeps (the
 `do_work()` function) for `argp->T` microseconds each time `acc_up` is
 incremented.

* `count_split`: This function allows the threads to increment `acc_left` and
 `acc_right`, alternating the direction to be incremented across all threads.
 For each thread, the number of times `acc_left` is incremented plus the number
 of times `acc_right` is incremented is given by `argp->N`. It sleeps for
 `argp->T` microseconds each time `acc_left` or `acc_right` is incremented.

* `count_down`: This function increments `acc_down` until the total number of
 times `acc_down` is incremented by all threads reaches the given value `val`.
 It also sleeps for `argp->T` microseconds each time `acc_down` is incremented.

(Please see code for details if this description seems confusing.) 

The majority of `count_up`, `count_split`, and `count_down` have already been
implemented. Your task is to insert `lock();` and `unlock();` at the correct
places in the code so that all the threads can modify shared variables in the
manner described above, so that the changes made by all threads can be recorded
and race conditions avoided. You do not need to write any other code other than
inserting `lock();` and `unlock();` lines.

(Please refer to `challenge.c` for the definitions of `lock()` and `unlock()`.)

**Hints:**

1. The following variables get changed across all threads and should therefore
be protected by semaphores: `acc_up`, `acc_down`, `acc_left`, `acc_right`,
`dir`, `val`.

2. Threads shouldn't sleep while holding locks, because that would waste the
time of all the other threads waiting for the lock.

3. Locking and unlocking, like `malloc` and `free`, need to be balanced.
Every thread that locks eventually needs to unlock; every thread that unlocks
needs be have acquired a lock prior. Consider all possible paths through
conditionals and bear this in mind.

Run the provided Makefile compile your code. The Makefile will also generate a
`submission.zip` file, which is the file that you need to upload to Gradescope.
This lab will be graded by a Gradescope autograder.

