#! ../roundup -ft

. test-helper.sh

roundup=../roundup.sh

fp="$progress_output"
it_should_work_in_sh_with_progress_formatter() {
    assertion "$fp" "$( sh $roundup -f progress basic-test.sh )"
}

it_should_work_in_bash_with_progress_formatter() {
    assertion "$fp" "$( bash $roundup -f p basic-test.sh )"
}

it_should_work_in_ksh_with_progress_formatter() {
    assertion "$fp" "$( ksh $roundup -f p basic-test.sh )"
}

it_should_work_in_dash_with_progress_formatter() {
    assertion "$fp" "$( dash $roundup -f p basic-test.sh )"
}

it_should_work_in_zsh_with_progress_formatter() {
    assertion "$fp" "$( zsh $roundup -f p basic-test.sh )"
}

fb="$base_output"
it_should_work_in_sh_with_base_formatter() {
    assertion "$fb" "$( sh $roundup -f base basic-test.sh )"
}

it_should_work_in_bash_with_base_formatter() {
    assertion "$fb" "$( bash $roundup -f b basic-test.sh )"
}

it_should_work_in_ksh_with_base_formatter() {
    assertion "$fb" "$( ksh $roundup -f b basic-test.sh )"
}

it_should_work_in_dash_with_base_formatter() {
    assertion "$fb" "$( dash $roundup -f b basic-test.sh )"
}

it_should_work_in_zsh_with_base_formatter() {
    assertion "$fb" "$( zsh $roundup -f b basic-test.sh )"
}

fd="$documentation_output"
it_should_work_in_sh_with_documentation_formatter() {
    assertion "$fd" "$( sh $roundup -f documention basic-test.sh )"
}

it_should_work_in_bash_with_documentation_formatter() {
    assertion "$fd" "$( bash $roundup -f d basic-test.sh )"
}

it_should_work_in_ksh_with_documentation_formatter() {
    assertion "$fd" "$( ksh $roundup -f d basic-test.sh )"
}

it_should_work_in_dash_with_documentation_formatter() {
    assertion "$fd" "$( dash $roundup -f d basic-test.sh )"
}

it_should_work_in_zsh_with_documentation_formatter() {
    assertion "$fd" "$( zsh $roundup -f d basic-test.sh )"
}

ft="$tap_output"
it_should_work_in_sh_with_tap_formatter() {
    assertion "$ft" "$( sh $roundup -f tap basic-test.sh )"
}

it_should_work_in_bash_with_tap_formatter() {
    assertion "$ft" "$( bash $roundup -f t basic-test.sh )"
}

it_should_work_in_ksh_with_tap_formatter() {
    assertion "$ft" "$( ksh $roundup -f t basic-test.sh )"
}

it_should_work_in_dash_with_tap_formatter() {
    assertion "$ft" "$( dash $roundup -f t basic-test.sh )"
}

it_should_work_in_zsh_with_tap_formatter() {
    assertion "$ft" "$( zsh $roundup -f t basic-test.sh )"
}
