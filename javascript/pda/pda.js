'use strict';

class PDAConfiguration {
  constructor(state, stack) {
    this.state = state;
    this.stack = stack;
  }

  stuck() {
    return new PDAConfiguration(PDAConfiguration.STUCK, this. stack);
  }

  isStuck() {
    return this.state === PDAConfiguration.STUCK;
  }
}

PDAConfiguration.STUCK = {};

class PDARule {
  constructor({
    state,
    character,
    nextState,
    popCharacter,
    pushCharacters
  }) {
    this.state = state;
    this.character = character;
    this.nextState = nextState;
    this.popCharacter = popCharacter;
    this.pushCharacters = pushCharacters;
  }

  isAppliesTo(configuration, character) {
    return (
      this.state === configuration.state &&
      this.character === character &&
      this.popCharacter === configuration.stack.top()
    );
  }

  follow(configuration) {
    return new PDAConfiguration(this.nextState, this.nextStack(configuration));
  }

  nextStack(configuration) {
    configuration.stack.pop();

    this.pushCharacters
      .reverse()
      .map(character => configuration.stack.push(character));

    return configuration.stack;
  }
}

module.exports = {
  PDAConfiguration,
  PDARule
};
