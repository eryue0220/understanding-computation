'use strict';

const Stack = require('./Stack');
const { PDAConfiguration, PDARule } = require('./pda');
const { DPDA, DPDARulebook, DPDADesign } = require('./dpda');

const rulebook = new DPDARulebook([
  new PDARule({
    state: 1,
    character: '(',
    nextState: 2,
    popCharacter: '$',
    pushCharacters: ['b', '$']
  }),
  new PDARule({
    state: 2,
    character: '(',
    nextState: 2,
    popCharacter: 'b',
    pushCharacters: ['b', 'b']
  }),
  new PDARule({
    state: 2,
    character: ')',
    nextState: 2,
    popCharacter: 'b',
    pushCharacters: []
  }),
  new PDARule({
    state: 2,
    character: null,
    nextState: 1,
    popCharacter: '$',
    pushCharacters: ['$']
  })
]);

let dpdaDesign = new DPDADesign({
  startState: 1,
  bottomCharacter: '$',
  acceptStates: [1],
  rulebook
});

let dpda = new DPDA({
  currentConfiguration: new PDAConfiguration(1, new Stack([1])),
  acceptStates: [1],
  rulebook
});

dpda.readString('())');
console.log(dpda.isStuck());

console.log(dpdaDesign.isAccepts('())'));
