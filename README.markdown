# roundup - kills shell eating bugs and weeds
You probably want to check out the **[Official roundup Repository](http://github.com/bmizerany/roundup)**

`roundup(1)` is a unit testing tool for running `roundup(5)` test plans which are
written in any POSIX shell.  Each test in a plan is run in it's own isolated
sandbox.  A test can pass, be ignored, or fail.  Failed tests output their `set -x trace`.

## This fork has many different output formatters:

        $ roundup -f documention
        basic tests
          it passes
          it fails
            + false
          it runs before
          it runs after a test passes part 1
          it runs after a test passes part 2
          it runs after if a test fails part 1
            + touch foo.txt
            + test -f foo.txt
            + false
          it runs after if a test fails part 2
          xit ignores this
        ======================================================
        Tests:    8 | Passed:   5 | Pending:   1 | Failed:   2
---
        $ roundup -f base
        basic tests
          it passes                                      [PASS]
          it fails                                       [FAIL]
            + false
          it runs before                                 [PASS]
          it runs after a test passes part 1             [PASS]
          it runs after a test passes part 2             [PASS]
          it runs after if a test fails part 1           [FAIL]
            + touch foo.txt
            + test -f foo.txt
            + false
          it runs after if a test fails part 2           [PASS]
          xit ignores this                               [PEND]
        =======================================================
        Tests:    8 | Passed:   5 | Pending:   1 | Failed:   2
---
        $ roundup -f progress
        .F...F.*

        0) Pending
            xit_ignores_this

        0) Failure
        it_fails
            + false

        1) Failure
        it_runs_after_if_a_test_fails_part_1
            + touch foo.txt
            + test -f foo.txt
            + false
        =======================================================
        Tests:    8 | Passed:   5 | Pending:   1 | Failed:   2
---
        $ roundup -f tap
        ok 1 - it passes
        not ok 2 - it fails
        ok 3 - it runs before
        ok 4 - it runs after a test passes part 1
        ok 5 - it runs after a test passes part 2
        not ok 6 - it runs after if a test fails part 1
        ok 7 - it runs after if a test fails part 2
        =======================================================
        Tests:    8 | Passed:   5 | Pending:   1 | Failed:   2
