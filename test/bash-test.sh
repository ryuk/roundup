#!/usr/bin/env roundup -fd

. helpers

describe "bash"

it_should_work_with_progress_formatter() {
  assert_equal_output progress bash
}

it_should_work_with_base_formatter() {
  assert_equal_output base bash
}

it_should_work_with_documentation_formatter() {
  assert_equal_output documentation bash
}

it_should_work_with_tap_formatter() {
  assert_equal_output tap bash
}
