. fixtures/expected_output.data

assertion() {
    input="$1";shift
    expected="$1";shift
    test "$input" = "$expected"
}
