'use strict';

const Tape = require('./Tape');

let tape = new Tape({
  left: [1, 0, 1],
  middle: 1,
  right: [],
  blank: '_'
});

console.log(tape);
console.log(tape.moveHeadLeft());
console.log(tape.write(0));
console.log(tape.moveHeadRight());
console.log(tape.moveHeadRight().write(0));
