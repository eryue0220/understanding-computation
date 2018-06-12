'use strict';

const Tape = require('./Tape');
const { TMRule, TMConfiguration } = require('./tm');
const tape = new Tape({ left: [], middle: '0', right: [], blank: '_'});
let rule = new TMRule({
  state: 1,
  character: '0', 
  nextState: 2,
  writeCharacter: '1',
  direction: 'right'
});
console.log(rule.isApplyTo(new TMConfiguration(1, tape)));
console.log(tape);
const next = rule.follow(new TMConfiguration(1, tape));
console.log(next);
