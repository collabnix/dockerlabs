'use strict';

const assert = require('assert');
const UploadTimer = require('../lib/uploadtimer');

describe('Test UploadTimer class', () => {

  it('It runs a callback function after specified timeout.', (done) => {
    const uploadTimer = new UploadTimer(1000, done);
    uploadTimer.set();
  });

  it('set method returns true if timeout specified.', () => {
    const uploadTimer = new UploadTimer(1000);
    assert.equal(uploadTimer.set(), true);
  });

  it('set method returns false if timeout has not specified.', () => {
    const uploadTimer = new UploadTimer();
    assert.equal(uploadTimer.set(), false);
  });

  it('set method returns false if zero timeout has specified.', () => {
    const uploadTimer = new UploadTimer(0);
    assert.equal(uploadTimer.set(), false);
  });

});
