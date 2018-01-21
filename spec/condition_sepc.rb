#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require "test/unit"
require_relative "spec_helper"

Machine.new(
  If.new(
    Variable.new(:x),
    Assign.new(:y, Number.new(1)),
    Assign.new(:y, Number.new(2))
  ),
  { x: Boolean.new(false) }
).run