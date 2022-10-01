'use strict';

const bitfield = require('sparse-bitfield');
const codePoints = require('./lib/code-points');

const unassigned_code_points = bitfield();
const commonly_mapped_to_nothing = bitfield();
const non_ascii_space_characters = bitfield();
const prohibited_characters = bitfield();
const bidirectional_r_al = bitfield();
const bidirectional_l = bitfield();

/**
 * Iterare over code points and
 * convert it into an buffer.
 * @param {bitfield} bits
 * @param {Array} src
 * @returns {Buffer}
 */
function traverse(bits, src) {
  for (const code of src.keys()) {
    bits.set(code, true);
  }

  const buffer = bits.toBuffer();
  return Buffer.concat([createSize(buffer), buffer]);
}

/**
 * @param {Buffer} buffer
 * @returns {Buffer}
 */
function createSize(buffer) {
  const buf = Buffer.alloc(4);
  buf.writeUInt32BE(buffer.length);

  return buf;
}

const memory = [];

memory.push(
  traverse(unassigned_code_points, codePoints.unassigned_code_points),
  traverse(commonly_mapped_to_nothing, codePoints.commonly_mapped_to_nothing),
  traverse(non_ascii_space_characters, codePoints.non_ASCII_space_characters),
  traverse(prohibited_characters, codePoints.prohibited_characters),
  traverse(bidirectional_r_al, codePoints.bidirectional_r_al),
  traverse(bidirectional_l, codePoints.bidirectional_l)
);

process.stdout.write(Buffer.concat(memory));
