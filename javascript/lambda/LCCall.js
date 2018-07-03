'use strict';

class LCCall {
  constructor(left, right) {
    this.left = left;
    this.right = right;
  }

  replace(name, parameter) {
    return new LCCall(
      left.replace(name, parameter),
      right.replace(name, parameter)
    );
  }
}

module.exports = {
  LCCall
};
