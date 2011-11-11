#roundup - kills shell eating bugs and weeds
You probably want to check out the **[Official roundup Repository](http://github.com/bmizerany/roundup)**

roundup(1) is a unit testing tool for running roundup(5) test plans which are
written in any POSIX shell.  Each test in a plan is run in it's own isolated
sandbox.  A test can pass, be ignored, or fail.  Failed tests output their `set -x trace`.

This fork has many different output formatters:

    # documentation
    $ roundup -f documentation
    Test edge cases that cannot throw off roundup
      it hath not path before thy
      it hath path til after
      it is in tmp
    roundup(1) testing roundup(5)
      it displays the title
      it exists non zero
      it survives edge cases
    roundup(5)
      it fails
        + false
      it passes
      it runs after a test passes part 1
      it runs after a test passes part 2
      it runs after if a test fails part 1
        + touch foo.txt
        + test -f foo.txt
        + false
      it runs after if a test fails part 2
      it runs before
    =========================================================================================
    Tests:   13 | Passed:  11 | Failed:   2

    # base
    $ roundup -f base
    Test edge cases that cannot throw off roundup
      it hath not path before thy:                                                     [PASS]
      it hath path til after:                                                          [PASS]
      it is in tmp:                                                                    [PASS]
    roundup(1) testing roundup(5)
      it displays the title:                                                           [PASS]
      it exists non zero:                                                              [PASS]
      it survives edge cases:                                                          [PASS]
    roundup(5)
      it fails:                                                                        [FAIL]
        + false
      it passes:                                                                       [PASS]
      it runs after a test passes part 1:                                              [PASS]
      it runs after a test passes part 2:                                              [PASS]
      it runs after if a test fails part 1:                                            [FAIL]
        + touch foo.txt
        + test -f foo.txt
        + false
      it runs after if a test fails part 2:                                            [PASS]
      it runs before:                                                                  [PASS]
    =========================================================================================
    Tests:   13 | Passed:  11 | Failed:   2

    # progress
    $ roundup -f progress
    ......F...F..

    1) Failure
    it fails
        + false

    2) Failure
    it runs after if a test fails part 1
        + touch foo.txt
        + test -f foo.txt
        + false
    =========================================================================================
    Tests:   13 | Passed:  11 | Failed:   2

    # tap
    $ roundup -f tap
    ok 1 - it hath not path before thy
    ok 2 - it hath path til after
    ok 3 - it is in tmp
    ok 4 - it displays the title
    ok 5 - it exists non zero
    ok 6 - it survives edge cases
    not ok 7 - it fails
    ok 8 - it passes
    ok 9 - it runs after a test passes part 1
    ok 10 - it runs after a test passes part 2
    not ok 11 - it runs after if a test fails part 1
    ok 12 - it runs after if a test fails part 2
    ok 13 - it runs before
    =========================================================================================
    Tests:   13 | Passed:  11 | Failed:   2
