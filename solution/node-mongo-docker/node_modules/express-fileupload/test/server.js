'use strict';

const fs = require('fs');
const path = require('path');
const rimraf = require('rimraf');

const fileDir = path.join(__dirname, 'files');
const tempDir = path.join(__dirname, 'temp');
const uploadDir = path.join(__dirname, 'uploads');

const clearDir = (dir) => {
  try {
    if (fs.existsSync(dir)) rimraf.sync(dir);
    fs.mkdirSync(dir, { recursive: true });
  } catch (err) {
    // 
  }
};

const clearUploadsDir = () => clearDir(uploadDir);
const clearTempDir = () => clearDir(tempDir);

const getUploadedFileData = (file) => ({
  md5: file.md5,
  name: file.name,
  size: file.size,
  uploadPath: path.join(uploadDir, file.name),
  uploadDir: uploadDir
});

const setup = (fileUploadOptions) => {
  const express = require('express');
  const expressFileupload = require('../lib/index');

  const app = express();

  app.use(expressFileupload(fileUploadOptions || {}));

  app.all('/upload/single', (req, res) => {
    if (!req.files) {
      return res.status(400).send('No files were uploaded.');
    }

    const testFile = req.files.testFile;
    const fileData = getUploadedFileData(testFile);

    testFile.mv(fileData.uploadPath, (err) => {
      if (err) {
        console.log('ERR', err); // eslint-disable-line
        return res.status(500).send(err);
      }
      res.json(fileData);
    });
  });

  app.all('/upload/single/promise', (req, res) => {
    if (!req.files) {
      return res.status(400).send('No files were uploaded.');
    }

    const testFile = req.files.testFile;
    const fileData = getUploadedFileData(testFile);

    testFile
      .mv(fileData.uploadPath)
      .then(() => {
        res.json(fileData);
      })
      .catch(err => {
        res.status(500).send(err);
      });
  });

  app.all('/upload/single/withfields', (req, res) => {
    if (!req.files) {
      return res.status(400).send('No files were uploaded.');
    }

    if (!req.body) {
      return res.status(400).send('No request body found');
    }
    
    const fields = ['firstName', 'lastName', 'email'];
    for (let i = 0; i < fields.length; i += 1) {
      if (!req.body[fields[i]] || !req.body[fields[i]].trim()) {
        return res.status(400).send(`Invalid field: ${fields[i]}`);
      }
    }

    const testFile = req.files.testFile;
    const fileData = getUploadedFileData(testFile);
    fields.forEach((field) => { fileData[field] = req.body[field]; });

    testFile.mv(fileData.uploadPath, (err) => {
      if (err) {
        return res.status(500).send(err);
      }
      res.json(fileData);
    });
  });

  app.all('/upload/single/truncated', (req, res) => {
    if (!req.files) {
      return res.status(400).send('No files were uploaded.');
    }

    // status 400 to differentiate from ending the request in the on limit
    return req.files.testFile.truncated
      ? res.status(400).send(`File too big`)
      : res.status(200).send('Upload succeed');
  });

  app.all('/upload/multiple', function(req, res) {
    if (!req.files) {
      return res.status(400).send('No files were uploaded.');
    }

    const fileNames = ['testFile1', 'testFile2', 'testFile3'];
    
    const testFiles = fileNames.map(file => req.files[file]);
    for (let i = 0; i < testFiles.length; i += 1) {
      if (!testFiles[i]) {
        return res.status(400).send(`${fileNames[i]} was not uploaded!`);
      }
    }
    
    const filesData = testFiles.map(file => getUploadedFileData(file));

    testFiles[0].mv(filesData[0].uploadPath, (err) => {
      if (err) {
        return res.status(500).send(err);
      }

      testFiles[1].mv(filesData[1].uploadPath, (err) => {
        if (err) {
          return res.status(500).send(err);
        }

        testFiles[2].mv(filesData[2].uploadPath, (err) => {
          if (err) {
            return res.status(500).send(err);
          }

          res.json(filesData);
        });
      });
    });
  });

  app.all('/upload/array', function(req, res) {
    if (!req.files) {
      return res.status(400).send('No files were uploaded.');
    }

    const testFiles = req.files.testFiles;

    if (!testFiles) {
      return res.status(400).send('No files were uploaded');
    }

    if (!Array.isArray(testFiles)) {
      return res.status(400).send('Files were not uploaded as an array');
    }

    if (!testFiles.length) {
      return res.status(400).send('Files array is empty');
    }

    const filesData = testFiles.map(file => getUploadedFileData(file));

    let uploadCount = 0;
    for (let i = 0; i < testFiles.length; i += 1) {

      testFiles[i].mv(filesData[i].uploadPath, (err) => {
        if (err) {
          return res.status(500).send(err);
        }

        uploadCount += 1;
        if (uploadCount === testFiles.length) {
          res.json(filesData);
        }
      });
    }
  });

  app.all('/fields/user', function(req, res) {
    if (!req.body) {
      return res.status(400).send('No request body found');
    }

    const fields = ['firstName', 'lastName', 'email'];
    for (let i = 0; i < fields.length; i += 1) {
      if (!req.body[fields[i]] || !req.body[fields[i]].trim()) {
        return res.status(400).send(`Invalid field: ${fields[i]}`);
      }
    }

    res.json({
      firstName: req.body.firstName,
      lastName: req.body.lastName,
      email: req.body.email
    });
  });

  app.all('/fields/nested', function(req, res) {
    if (!req.body) {
      return res.status(400).send('No request body found');
    }

    if (!req.body.name || !req.body.name.trim()) {
      return res.status(400).send('Invalid name');
    }

    if (!req.body.hobbies || !req.body.hobbies.length == 2) {
      return res.status(400).send('Invalid hobbies');
    }

    res.json({
      name: req.body.name,
      hobbies: req.body.hobbies
    });
  });

  app.all('/fields/flattened', function(req, res) {
    if (!req.body) {
      return res.status(400).send('No request body found');
    }

    if (!req.body.name || !req.body.name.trim()) {
      return res.status(400).send('Invalid name');
    }

    if (!req.body['hobbies[0]'] || !req.body['hobbies[0]'].trim()) {
      return res.status(400).send('Invalid hobbies[0]');
    }

    if (!req.body['hobbies[1]'] || !req.body['hobbies[1]'].trim()) {
      return res.status(400).send('Invalid hobbies[1]');
    }

    res.json({
      name: req.body.name,
      'hobbies[0]': req.body['hobbies[0]'],
      'hobbies[1]': req.body['hobbies[1]']
    });
  });

  app.all('/fields/array', function(req, res) {
    if (!req.body) {
      return res.status(400).send('No request body found');
    }

    if (!req.body.testField) {
      return res.status(400).send('Invalid field');
    }

    if (!Array.isArray(req.body.testField)) {
      return res.status(400).send('Field is not an array');
    }

    res.json(req.body.testField);
  });

  return app;
};

module.exports = {
  setup,
  fileDir,
  tempDir,
  uploadDir,
  clearTempDir,
  clearUploadsDir
};
