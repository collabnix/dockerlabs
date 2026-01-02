'use strict';

/**
 * Create an array of numbers.
 * @param {number} from
 * @param {number} to
 * @returns {number[]}
 */
function range(from, to) {
  // TODO: make this inlined.
  const list = new Array(to - from + 1);

  for (let i = 0; i < list.length; i += 1) {
    list[i] = from + i;
  }
  return list;
}

module.exports = {
  range,
};
