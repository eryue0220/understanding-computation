'use strict';

class TMConfiguration {
  constructor(state, tape) {
    this.state = state;
    this.tape = tape;
  }
}

class TMRule {
  constructor({
    state,
    character,
    nextState,
    writeCharacter,
    direction
  }) {
    this.state = state;
    this.character = character;
    this.nextState = nextState;
    this.writeCharacter = writeCharacter;
    this.direction = direction;
  }

  isApplyTo(configuration) {
    return this.state === configuration.state &&
      this.character === configuration.tape.middle;
  }

  follow(configuration) {
    return new TMConfiguration(this.nextState, this.nextTape(configuration));
  }

  nextTape(configuration) {
    const writtenTape = configuration.tape.write(this.writeCharacter);

    switch (this.direction) {
      case 'left':
        return writtenTape.moveHeadLeft();
      case 'right':
        return writtenTape.moveHeadRight();
    }
  }
}

module.exports = {
  TMRule,
  TMConfiguration
};
