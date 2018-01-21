#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require "test/unit"
require_relative "spect_helper"

Machine.new(
  Sequence.new(
    Assign.new(:x, Add.new(Number.new(1), Number.new(2))),
    Assign.new(:y, Add.new(Variable.new(:x), Number.new(2)))
  ),
  {}
).run