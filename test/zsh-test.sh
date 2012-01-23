#!/usr/bin/env roundup -fd

. helpers

describe "zsh"

it_should_work_with_progress_formatter() {
  assert_equal_output progress zsh
}

it_should_work_with_base_formatter() {
  assert_equal_output base zsh
}

it_should_work_with_documentation_formatter() {
  assert_equal_output documentation zsh
}

it_should_work_with_tap_formatter() {
  assert_equal_output tap zsh
}
