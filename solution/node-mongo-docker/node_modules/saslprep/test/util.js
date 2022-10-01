'use strict';

const { setFlagsFromString } = require('v8');
const { range } = require('../lib/util');

// 984 by default.
setFlagsFromString('--stack_size=500');

test('should work', () => {
  const list = range(1, 3);
  expect(list).toEqual([1, 2, 3]);
});

test('should work for large ranges', () => {
  expect(() => range(1, 1e6)).not.toThrow();
});
