'use strict';

class LCVariable {
  constructor(name) {
    this.name = name;
  }

  replace(name, replacement) {
    if (this.name === name) return replacement;
    return this;
  }
}

module.exports = {
  LCVariable
};

const expression = new LCVariable('x');
