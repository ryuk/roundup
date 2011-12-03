#!/bin/sh
# [r5]: roundup.5.html
# [r1t]: roundup-1-test.sh.html
# [r5t]: roundup-5-test.sh.html
#
# _(c) 2010 Blake Mizerany - MIT License_
#
# Spray **roundup** on your shells to eliminate weeds and bugs.  If your shells
# survive **roundup**'s deathly toxic properties, they are considered
# roundup-ready.
#
# **roundup** reads shell scripts to form test plans.  Each
# test plan is sourced into a sandbox where each test is executed.
#
# See [roundup-1-test.sh.html][r1t] or [roundup-5-test.sh.html][r5t] for example
# test plans.
#
# __Install__
#
#     git clone http://github.com/bmizerany/roundup.git
#     cd roundup
#     make
#     sudo make install
#     # Alternatively, copy `roundup` wherever you like.
#
# __NOTE__:  Because test plans are sourced into roundup, roundup prefixes its
# variable and function names with `roundup_` to avoid name collisions.  See
# "Sandbox Test Runs" below for more insight.

# Usage and Prerequisites
# -----------------------

# Exit if any following command exits with a non-zero status.
set -e

# The current version is set during `make version`.  Do not modify this line in
# anyway unless you know what you're doing.
ROUNDUP_VERSION="0.0.6"
export ROUNDUP_VERSION
export formatter=documention

# Usage is defined in a specific comment syntax. It is `grep`ed out of this file
# when needed (i.e. The Tomayko Method).  See
# [shocco](http://rtomayko.heroku.com/shocco) for more detail.
#/ Usage: roundup [options] [plan]
#/     -v, --version                    Show version
#/     -h, --help                       You're looking at it.
#/     -f, --format FORMATTER           Choose a formatter
#/                                          [b]ase
#/                                          [p]rogress
#/                                          [t]ap
#/                                          [d]ocumentation (default)

roundup_usage() {
    grep '^#/' <"$0" | cut -c4-
}


while getopts ":hvf:c-" flag; do
    case $flag in
        h)
            roundup_usage
            exit 0
            ;;
        v)
            echo "roundup version $ROUNDUP_VERSION"
            exit 0
            ;;
        f)
            case "$OPTARG" in
                progress | p)
                    formatter=progress
                    ;;
                documention | d)
                    formatter=documention
                    ;;
                tap | t)
                    formatter=tap
                    ;;
                base | b)
                    formatter=base
                    ;;
                *)
                    echo "invalid argument: $OPTARG" >&2
                    exit 1
            esac
            ;;
        c)
            color=always
            ;;

        \?)
            echo "invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done

shift $(( OPTIND - 1 ))

# __Colors for output__

# Use colors if we are writing to a tty device.
if [ -t 1 ] || [ "$color" = always ]; then
    ylw=$(printf "\033[33m")
    red=$(printf "\033[31m")
    grn=$(printf "\033[32m")
    mag=$(printf "\033[35m")
    clr=$(printf "\033[m")
    cols=$(tput cols)
fi

: ${cols:=60}
: ${color:="auto"}

# Consider all scripts with names matching `*-test.sh` the plans to run unless
# otherwise specified as arguments.
if [ "$#" -gt "0" ]; then
    roundup_plans="$@"
else
    roundup_plans="$(find *-test.sh)"
fi

# Create a temporary storage place for test output to be retrieved for display
# after failing tests.
roundup_tmp="/tmp/roundup/.roundup.$$"
mkdir -p $roundup_tmp

exit_hook() {
    set +e

    if [ -n "${ZSH_VERSION}" ]; then
        if [ $exit_trap -eq 1 ]; then
            rm -rf "$roundup_tmp"
        fi
    else
        rm -rf "$roundup_tmp"
    fi
}

export exit_trap=0
trap exit_hook EXIT INT

# __Tracing failures__
roundup_trace() {
    # Delete the first two lines that represent roundups execution of the
    # test function.  They are useless to the user.
    sed '1d'                                   |
    # Trim the two left most `+` signs.  They represent the depth at which
    # roundup executed the function.  They also, are useless and confusing.
    sed 's/^++//'                              |
    # Need for zsh.
    # remove the name of the function
    sed 's/it_[^>]*>//'                        |
    # Indent the output by 4 spaces to align under the test name in the
    # summary.
    sed 's/^/    /'                            |
    # Highlight the last line to bring notice to where the error occurred.
    sed "\$s/\(.*\)/$mag\1$clr/"
}

# __Other helpers__

# Track the test stats while outputting a real-time report.  This takes input on
# **stdin**.  Each input line must come in the format of:
#
#     # The plan description to be displayed
#     d <plan description>
#
#     # A passing test
#     p <test name>
#
#     # A failed test
#     f <test name>
roundup_summarize() {
    set -e

    ntests=0
    pending=0
    passed=0
    failed=0
    stack_trace=""
    pendings_name=""

    while read return_code name; do
        human_name=$(echo $name | sed -e 's/_/ /g')
        case $formatter in
            base)
                case $return_code in
                    x)
                        pending=$((pending + 1))
                        ntests=$((ntests + 1))
                        width=$((cols - 9))
                        printf "  %-*s " "$width" "$human_name"
                        printf "${ylw}[PEND]${clr}\n"
                        ;;

                    p)
                        passed=$((passed + 1))
                        ntests=$((ntests + 1))
                        width=$((cols - 9))
                        printf "  %-*s " "$width" "$human_name"
                        printf "${grn}[PASS]${clr}\n"
                        ;;
                    f)
                        failed=$((failed + 1))
                        ntests=$((ntests + 1))
                        width=$((cols - 9))
                        printf "  %-*s " "$width" "$human_name"
                        printf "${red}[FAIL]${clr}\n"
                        roundup_trace < "$roundup_tmp/$name"
                        ;;
                    d)
                        printf "%s\n" "$human_name"
                        ;;
                esac
                ;;
            progress)
                case $return_code in
                    x)
                        pending=$((pending+ 1))
                        ntests=$((ntests + 1))
                        printf "${ylw}*${clr}"
                        pendings_name="$pendings_name $name"
                        ;;
                    p)
                        passed=$((passed + 1))
                        ntests=$((ntests + 1))
                        printf "${grn}.${clr}"
                        ;;
                    f)
                        failed=$((failed + 1))
                        ntests=$((ntests + 1))
                        printf "${red}F${clr}"
                        stack_trace="$stack_trace $name"
                        ;;
                esac
                ;;
            documention)
                case $return_code in
                    x)
                        pending=$((pending + 1))
                        ntests=$((ntests + 1))
                        echo "  ${ylw}${human_name}${clr}"
                        ;;
                    p)
                        passed=$((passed + 1))
                        ntests=$((ntests + 1))
                        echo "  ${grn}${human_name}${clr}"
                        ;;
                    f)
                        failed=$((failed + 1))
                        ntests=$((ntests + 1))
                        echo "  ${red}${human_name}${clr}"
                        roundup_trace < "$roundup_tmp/$name"
                        ;;
                    d)
                        printf "%s\n" "$human_name"
                        ;;
                esac
                ;;
            tap)
                case $return_code in
                    x)
                        ntests=$((ntests + 1))
                        pending=$((pending + 1))
                        ;;
                    p)
                        passed=$((passed + 1))
                        ntests=$((ntests + 1))
                        echo "ok $ntests - $human_name"
                        ;;
                    f)
                        failed=$((failed + 1))
                        ntests=$((ntests + 1))
                        echo "not ok $ntests - $human_name"
                        ;;
                esac
        esac
    done

    if [ "$formatter" = "progress" ]; then
        echo

        if [ $pending -ne 0 ]; then
            j=0
            for name in $(echo $pendings_name); do
                echo ""
                echo "${ylw}${j}) Pending${clr}"
                echo "    ${name}"
                j=$((j + 1))
            done
        fi

        if [ $failed -ne 0 ]; then
            i=0
            for name in $(echo $stack_trace); do
                echo ""
                echo "${red}${i}) Failure${clr}"
                echo "$name"
                roundup_trace < "$roundup_tmp/$name"
                i=$((i + 1))
            done
        fi
    fi
    # __Test Summary__
    #
    # Display the summary now that all tests are finished.
    for _j in $(seq "$cols"); do
        printf "="
    done
    printf "\nTests:  %3d | Passed: %3d | Pending: %3d | Failed: %3d\n" $ntests $passed $pending $failed

    # Exit with an error if any tests failed
    exit_trap=1
    if [ $failed -gt 0 ]; then
        exit 2
    else
        exit 0
    fi
}

# Sandbox Test Runs
# -----------------

# The above checks guarantee we have at least one test.  We can now move through
# each specified test plan, determine its test plan, and administer each test
# listed in a isolated sandbox.
for roundup_p in $(echo $roundup_plans); do
    # Create a sandbox, source the test plan, run the tests, then leave
    # without a trace.
    (
        # Consider the description to be the `basename` of the plan minus the
        # tailing -test.sh.
        roundup_desc=$(basename "$roundup_p" -test.sh)

        # Define functions for
        # [roundup(5)][r5]

        # A custom description is recommended, but optional.  Use `describe` to
        # set the description to something more meaningful.
        # TODO: reimplement this.
        describe() {
            roundup_desc="$*"
        }

        # Provide default `before` and `after` functions that run only `:`, a
        # no-op. They may or may not be redefined by the test plan.
        before() { :; }
        after() { :; }

        if [ ! -f $roundup_p ]; then
            echo "$roundup_p not found!" >&2
            continue
        fi

        # Seek test methods and aggregate their names, forming a test plan.
        # This is done before populating the sandbox with tests to avoid odd
        # conflicts.

        roundup_plan=$(sed -n 's/\(^[x]*it_[a-zA-Z0-9_]*\).*$/\1/p' $roundup_p)

        # We have the test plan and are in our sandbox with [roundup(5)][r5]
        # defined.  Now we source the plan to bring its tests into scope.
        . ./$roundup_p

        # Output the description signal
        printf "d %s" "$roundup_desc" | tr "\n" " "
        printf "\n"

        for roundup_test_name in $(echo $roundup_plan); do
            set +e
            echo $roundup_test_name | grep "^xit_" > /dev/null

            if [ $? -eq 1 ]; then
                # Any number of things are possible in `before`, `after`, and the
                # test.  Drop into an subshell to contain operations that may throw
                # off roundup; such as `cd`.
                (
                    # If `before` wasn't redefined, then this is `:`.
                    before

                    # Momentarily turn off auto-fail to give us access to the tests
                    # exit status in `$?` for capturing.
                    set +e
                    (
                        # Set `-xe` before the test in the subshell.  We want the
                        # test to fail fast to allow for more accurate output of
                        # where things went wrong but not in _our_ process because a
                        # failed test should not immediately fail roundup.  Each
                        # tests trace output is saved in temporary storage.
                        set -xe
                        $roundup_test_name
                    ) >"$roundup_tmp/$roundup_test_name" 2>&1

                    # We need to capture the exit status before returning the `set
                    # -e` mode.  Returning with `set -e` before we capture the exit
                    # status will result in `$?` being set with `set`'s status
                    # instead.
                    roundup_result=$?

                    # It's safe to return to normal operation.
                    set -e


                    # If `after` wasn't redefined, then this runs `:`.
                    after

                    # This is the final step of a test.  Print its pass/fail signal
                    # and name.
                    if [ "$roundup_result" -ne 0 ]; then
                        printf "f"
                    else
                        printf "p"
                    fi

                    printf " $roundup_test_name\n"
                )
            else
                printf "x $roundup_test_name\n"
            fi
        done
    )
done |

# All signals are piped to this for summary.
roundup_summarize
