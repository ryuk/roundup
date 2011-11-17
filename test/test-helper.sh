assertion() {
    input="$1";shift
    expected="$1";shift
    test "$input" = "$expected"
}

fp="$(cat fixtures/basic_progress.output)"
fb="$(cat fixtures/basic_base.output)"
fd="$(cat fixtures/basic_documentation.output)"
ft="$(cat fixtures/basic_tap.output)"
