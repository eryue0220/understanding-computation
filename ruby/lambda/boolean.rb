#!/usr/bin/env ruby

TRUE = -> x { -> y { x } }
FALSE = -> x { -> y { y } }
IF = -> b { b }
IS_ZERO = -> n { n[ -> x { FALSE }][TRUE] }
