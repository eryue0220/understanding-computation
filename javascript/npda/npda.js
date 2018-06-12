'use strict';

class NPDARulebook {
  constructor(rules) {
    this.rules = rules;
  }

  nextConfiguration(configurations, character) {
    return Array.from(new Set(
      configurations.map(config => this.followRulesFor(config, character))
    ));
  }

  followRulesFor(configuration, character) {
    return this.ruleFor(configuration, character)
      .map(rule => rule.follow(configuration));
  }

  followFreeMove(configurations) {
    const moreConfigurations = this.nextConfiguration(configurations, null);

    if (moreConfigurations.length < configurations.length) return configurations;

    return this.followFreeMove(moreConfigurations.concat(configurations));
  }

  ruleFor(configuration, character) {
    const filter = this.rules.filter(rule =>
      rule.isAppliesTo(configuration, character)
    );

    if (filter.length > 0) return filter;
    return this.rules;
  }
}

class NPDA {
  constructor({
    currentConfigurations,
    acceptStates,
    rulebook
  }) {
    this.currentConfiguration = currentConfigurations;
    this.acceptStates = acceptStates;
    this.rulebook = rulebook;
  }

  isAccepting() {
    return this.currentConfigurations.some(configuration =>
      this.acceptStates.includes(configuration.state)
    );
  }

  readCharacter(character) {
    
  }
}
