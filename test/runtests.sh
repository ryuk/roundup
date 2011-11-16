#!/bin/bash

source fixtures/expected_output.data

typeset -i ntests passed failed

cols=$(tput cols)
red=$(printf "\033[31m")
grn=$(printf "\033[32m")
clr=$(printf "\033[m")

# progress formater
it_should_work_in_sh_with_progress_formatter() {
    out="$( sh ../roundup.sh -f p roundup-5-test.sh )"
    test "$out" = "$expected_output_1"
}

it_should_work_in_bash_with_progress_formatter() {
    out="$( bash ../roundup.sh -f p roundup-5-test.sh )"
    test "$out" = "$expected_output_1"
}

it_should_work_in_ksh_with_progress_formatter() {
    out="$( ksh ../roundup.sh -f p roundup-5-test.sh )"
    test "$out" = "$expected_output_1"
}

it_should_work_in_dash_with_progress_formatter() {
    out="$( dash ../roundup.sh -f p roundup-5-test.sh )"
    test "$out" = "$expected_output_1"
}

it_should_work_in_zsh_with_progress_formatter() {
    out="$( zsh ../roundup.sh -f p roundup-5-test.sh )"
    test "$out" = "$expected_output_1"
}

# base formatter
it_should_work_in_sh_with_base_formatter() {
    out="$( sh ../roundup.sh -f b roundup-5-test.sh )"
    test "$out" = "$expected_output_2"
}

it_should_work_in_bash_with_base_formatter() {
    out="$( bash ../roundup.sh -f b roundup-5-test.sh )"
    test "$out" = "$expected_output_2"
}

it_should_work_in_ksh_with_base_formatter() {
    out="$( ksh ../roundup.sh -f b roundup-5-test.sh )"
    test "$out" = "$expected_output_2"
}

it_should_work_in_dash_with_base_formatter() {
    out="$( dash ../roundup.sh -f b roundup-5-test.sh )"
    test "$out" = "$expected_output_2"
}

it_should_work_in_zsh_with_base_formatter() {
    out="$( zsh ../roundup.sh -f b roundup-5-test.sh )"
    test "$out" = "$expected_output_2"
}

# documentation
it_should_work_in_sh_with_documentation_formatter() {
    out="$( sh ../roundup.sh -f d roundup-5-test.sh )"
    test "$out" = "$expected_output_3"
}

it_should_work_in_bash_with_documentation_formatter() {
    out="$( bash ../roundup.sh -f d roundup-5-test.sh )"
    test "$out" = "$expected_output_3"
}

it_should_work_in_ksh_with_documentation_formatter() {
    out="$( ksh ../roundup.sh -f d roundup-5-test.sh )"
    test "$out" = "$expected_output_3"
}

it_should_work_in_dash_with_documentation_formatter() {
    out="$( dash ../roundup.sh -f d roundup-5-test.sh )"
    test "$out" = "$expected_output_3"
}

it_should_work_in_zsh_with_documentation_formatter() {
    out="$( zsh ../roundup.sh -f d roundup-5-test.sh )"
    test "$out" = "$expected_output_3"
}

# tap
it_should_work_in_sh_with_tap_formatter() {
    out="$( sh ../roundup.sh -f t roundup-5-test.sh )"
    test "$out" = "$expected_output_4"
}

it_should_work_in_bash_with_tap_formatter() {
    out="$( bash ../roundup.sh -f t roundup-5-test.sh )"
    test "$out" = "$expected_output_4"
}

it_should_work_in_ksh_with_tap_formatter() {
    out="$( ksh ../roundup.sh -f t roundup-5-test.sh )"
    test "$out" = "$expected_output_4"
}

it_should_work_in_dash_with_tap_formatter() {
    out="$( dash ../roundup.sh -f t roundup-5-test.sh )"
    test "$out" = "$expected_output_4"
}

it_should_work_in_zsh_with_tap_formatter() {
    out="$( zsh ../roundup.sh -f t roundup-5-test.sh )"
    test "$out" = "$expected_output_4"
}
for test_name in $(declare -f | sed -n 's/\(^it_[a-zA-Z0-9_]*\).*$/\1/p'); do
    let "ntests = ntests + 1"
    human_test_name=$(echo $test_name | sed -e 's/_/ /g')
    $test_name 2> /dev/null

    if [ $? -eq 0 ]; then
        let "passed = passed + 1"
        echo "${grn}${human_test_name}${clr}"
    else
        let "failed = failed + 1"
        echo "${red}${human_test_name}${clr}"
    fi
done

for _j in $(seq "$cols"); do
    printf "="
done
printf "\nTests:  %3d | Passed: %3d | Failed: %3d\n" $ntests $passed $failed

if [ $failed -gt 0 ]; then
    exit 2
fi
