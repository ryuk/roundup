assertion() {
    expected="$1"; shift
    input="$1"; shift
    test "$expected" = "$input"
}

fp="$(cat fixtures/basic_progress.output)"
fb="$(cat fixtures/basic_base.output)"
fd="$(cat fixtures/basic_documentation.output)"
ft="$(cat fixtures/basic_tap.output)"
