'use strict';

class Stack {
  constructor(contents) {
    this.contents = contents;
  }

  push(character) {
    this.contents.unshift(character);
    return this;
  }

  pop() {
    this.contents.shift();
    return this;
  }

  top() {
    return this.contents[0];
  }
}

module.exports = Stack;
