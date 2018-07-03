'use strict';

const { LCCall } = require('./LCCall');
const { LCFunction } = require('./LCFunction');
const { LCVariable } = require('./LCVariable');

const one = new LCFunction(
  'p',
  new LCFunction(
    'x', 
    new LCCall(
      new LCVariable('p'),
      new LCVariable('X')
    )
  )
)

console.log(one.toString())
