'use strict';

class Tape {
  constructor({ left, middle, right, blank }) {
    this.left = left;
    this.middle = middle;
    this.right = right;
    this.blank = blank;
  }

  write(character) {
    return new Tape({ ...this, middle: character });
  }

  moveHeadLeft() {
    const leftLast = this.left.slice(-1)

    return new Tape({
      left: this.left.slice(0, this.left.length -1),
      middle: leftLast[0] || this.blank,
      right: leftLast.concat(this.right.slice()),
      blank: this.blank
    });
  }

  moveHeadRight() {
    const right = this.right.slice();

    return new Tape({
      left: this.left.slice().concat([this.middle]),
      middle: right.shift() || this.blank,
      right,
      blank: this.blank
    });
  }
}

module.exports = Tape
