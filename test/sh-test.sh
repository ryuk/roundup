#!/usr/bin/env roundup -fd

. helpers

describe "sh"

it_should_work_with_progress_formatter() {
  assert_equal_output progress sh
}

it_should_work_with_base_formatter() {
  assert_equal_output base sh
}

it_should_work_with_documentation_formatter() {
  assert_equal_output documentation sh
}

it_should_work_with_tap_formatter() {
  assert_equal_output tap sh
}
