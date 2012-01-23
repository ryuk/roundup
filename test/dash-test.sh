#!/usr/bin/env roundup -fd

. helpers

describe "dash"

it_should_work_with_progress_formatter() {
  assert_equal_output progress dash
}

it_should_work_with_base_formatter() {
  assert_equal_output base dash
}

it_should_work_with_documentation_formatter() {
  assert_equal_output documentation dash
}

it_should_work_with_tap_formatter() {
  assert_equal_output tap dash
}
