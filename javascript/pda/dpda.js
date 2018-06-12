'use strict';

const Stack = require('./Stack');
const { PDAConfiguration } = require('./pda');

class DPDARulebook {
  constructor(rules) {
    this.rules = rules;
  }

  nextConfiguration(configuration, character) {
    return this.ruleFor(configuration, character).follow(configuration);
  }

  ruleFor(configuration, character) {
    return this.rules.find(rule => rule.isAppliesTo(configuration, character));
  }

  isAppliesTo(configuration, character) {
    return this.ruleFor(configuration, character)
  }

  followFreeMove(configuration) {
    if (this.isAppliesTo(configuration, null)) {
      return this.followFreeMove(this.nextConfiguration(configuration, null));
    }

    return configuration;
  }
}

class DPDA {
  constructor({
    currentConfiguration,
    acceptStates,
    rulebook
  }) {
    this.rulebook = rulebook;
    this.currentConfiguration = this.rulebook.followFreeMove(currentConfiguration);
    this.acceptStates = acceptStates;
  }

  isStuck() {
    return this.currentConfiguration.isStuck();
  }

  isAccepting() {
    return this.acceptStates.includes(this.currentConfiguration.state);
  }

  nextConfiguration(character) {
    if (this.rulebook.isAppliesTo(this.currentConfiguration, character)) {
      return this.rulebook.nextConfiguration(this.currentConfiguration, character);
    }

    return this.currentConfiguration.stuck();
  }

  readCharacter(character) {
    this.currentConfiguration = this.nextConfiguration(character);
  }

  readString(string) {
    string.split('').forEach(character => this.readCharacter(character));
  }
}

class DPDADesign {
  constructor({
    startState,
    bottomCharacter,
    acceptStates,
    rulebook
  }) {
    this.startState = startState;
    this.bottomCharacter = bottomCharacter;
    this.acceptStates = acceptStates;
    this.rulebook = rulebook;
  }

  isAccepts(string) {
    const dpda = this.toDPDA();
    dpda.readString(string);

    return dpda.isAccepting();
  }

  toDPDA() {
    const startStack = new Stack([this.bottomCharacter]);
    const startConfiguration = new PDAConfiguration(this.startState, startStack);

    return new DPDA({
      currentConfiguration: startConfiguration,
      acceptStates: this.acceptStates,
      rulebook: this.rulebook
    });
  }
}

module.exports = {
  DPDA,
  DPDARulebook,
  DPDADesign
};
