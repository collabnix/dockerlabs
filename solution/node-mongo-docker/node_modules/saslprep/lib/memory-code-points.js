'use strict';

const fs = require('fs');
const path = require('path');
const bitfield = require('sparse-bitfield');

/* eslint-disable-next-line security/detect-non-literal-fs-filename */
const memory = fs.readFileSync(path.resolve(__dirname, '../code-points.mem'));
let offset = 0;

/**
 * Loads each code points sequence from buffer.
 * @returns {bitfield}
 */
function read() {
  const size = memory.readUInt32BE(offset);
  offset += 4;

  const codepoints = memory.slice(offset, offset + size);
  offset += size;

  return bitfield({ buffer: codepoints });
}

const unassigned_code_points = read();
const commonly_mapped_to_nothing = read();
const non_ASCII_space_characters = read();
const prohibited_characters = read();
const bidirectional_r_al = read();
const bidirectional_l = read();

module.exports = {
  unassigned_code_points,
  commonly_mapped_to_nothing,
  non_ASCII_space_characters,
  prohibited_characters,
  bidirectional_r_al,
  bidirectional_l,
};
