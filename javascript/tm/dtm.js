'use strict';

class DTMRulebook {
  constructor(rules) {
    this.rules = rules;
  }

  isApplyTo(configuration) {
    return this.ruleFor(configuration) !== null;
  }

  nextConfiguration(configuration) {
    return this.ruleFor(configuration).follow(configuration);
  }

  ruleFor(configuration) {
    return this.rules.find(rule => rule.isApplyTo(configuration));
  }
}

class DTM {
  constructor({
    currentConfiguration,
    acceptStates,
    rulebook
  }) {
    this.currentConfiguration = currentConfiguration;
    this.acceptStates = acceptStates;
    this.rulebook = rulebook;
  }

  isAccepting() {
    return this.acceptStates.includes(currentConfiguration.state);
  }

  step() {
    this.currentConfiguration =
      rulebook.nextConfiguration(this.currentConfiguration);
  }

  stuck() {
    return !this.isAccepting() &&
      !this.rulebook.isApplyTo(this.currentConfiguration);
  }

  run() {
    while (this.isAccepting() || !this.stuck()) {
      this.step();
    }
  }
}

module.exports = {
  DTM,
  DTMRulebook,
}