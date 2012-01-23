#!/usr/bin/env roundup -fd

. helpers

describe "ksh"

it_should_work_with_progress_formatter() {
  assert_equal_output progress ksh
}

it_should_work_with_base_formatter() {
  assert_equal_output base ksh
}

it_should_work_with_documentation_formatter() {
  assert_equal_output documentation ksh
}

it_should_work_with_tap_formatter() {
  assert_equal_output tap ksh
}
