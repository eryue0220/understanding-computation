'use strict';

class LCFunction {
  constructor(parameter, body) {
    this.parameter = parameter;
    this.body = body;
  }

  replace(name, replacement) {
    if (this.parameter === name) return this;
    return new LCFunction(parameter, body.replace(name, replacement));
  }
}

module.exports = {
  LCFunction
};
