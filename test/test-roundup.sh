#! ../roundup -ft

. test-helper.sh

# progress formater
it_should_work_in_sh_with_progress_formatter() {
    test "$(sh ../roundup.sh -f p basic-test.sh )" = "$expected_output_1"
}

it_should_work_in_bash_with_progress_formatter() {
    test "$( bash ../roundup.sh -f p basic-test.sh )" = "$expected_output_1"
}

it_should_work_in_ksh_with_progress_formatter() {
    test "$( ksh ../roundup.sh -f p basic-test.sh )" = "$expected_output_1"
}

it_should_work_in_dash_with_progress_formatter() {
    test "$( dash ../roundup.sh -f p basic-test.sh )" = "$expected_output_1"
}

it_should_work_in_zsh_with_progress_formatter() {
    test "$( zsh ../roundup.sh -f p basic-test.sh )" = "$expected_output_1"
}

# base formatter
it_should_work_in_sh_with_base_formatter() {
    test "$(sh ../roundup.sh -f b basic-test.sh )" = "$expected_output_2"
}

it_should_work_in_bash_with_base_formatter() {
    test "$( bash ../roundup.sh -f b basic-test.sh )" = "$expected_output_2"
}

it_should_work_in_ksh_with_base_formatter() {
    test "$( ksh ../roundup.sh -f b basic-test.sh )" = "$expected_output_2"
}

it_should_work_in_dash_with_base_formatter() {
    test "$( dash ../roundup.sh -f b basic-test.sh )" = "$expected_output_2"
}

it_should_work_in_zsh_with_base_formatter() {
    test "$( zsh ../roundup.sh -f b basic-test.sh )" = "$expected_output_2"
}

# documentation
it_should_work_in_sh_with_documentation_formatter() {
    test "$( sh ../roundup.sh -f d basic-test.sh )" = "$expected_output_3"
}

it_should_work_in_bash_with_documentation_formatter() {
    test "$( bash ../roundup.sh -f d basic-test.sh )" = "$expected_output_3"
}

it_should_work_in_ksh_with_documentation_formatter() {
    test "$( ksh ../roundup.sh -f d basic-test.sh )" = "$expected_output_3"
}

it_should_work_in_dash_with_documentation_formatter() {
    test "$( dash ../roundup.sh -f d basic-test.sh )" = "$expected_output_3"
}

it_should_work_in_zsh_with_documentation_formatter() {
    test "$( zsh ../roundup.sh -f d basic-test.sh )" = "$expected_output_3"
}

# tap
it_should_work_in_sh_with_tap_formatter() {
    test "$( sh ../roundup.sh -f t basic-test.sh )" = "$expected_output_4"
}

it_should_work_in_bash_with_tap_formatter() {
    test "$( bash ../roundup.sh -f t basic-test.sh )" = "$expected_output_4"
}

it_should_work_in_ksh_with_tap_formatter() {
    test "$( ksh ../roundup.sh -f t basic-test.sh )" = "$expected_output_4"
}

it_should_work_in_dash_with_tap_formatter() {
    test "$( dash ../roundup.sh -f t basic-test.sh )" = "$expected_output_4"
}

it_should_work_in_zsh_with_tap_formatter() {
    test "$( zsh ../roundup.sh -f t basic-test.sh )" = "$expected_output_4"
}
