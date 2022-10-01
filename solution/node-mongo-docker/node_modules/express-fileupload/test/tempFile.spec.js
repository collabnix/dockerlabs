const fs = require('fs');
const md5 = require('md5');
const path = require('path');
const request = require('supertest');
const server = require('./server');
const clearUploadsDir =
  server.clearUploadsDir;
const fileDir =
  server.fileDir;
const uploadDir =
  server.uploadDir;
describe('File Upload Options Tests', function() {
  afterEach(function(done) {
    clearUploadsDir();
    done();
  });
  /**
   * Upload the file for testing and verify the expected filename.
   * @param {object} options The expressFileUpload options.
   * @param {string} actualFileNameToUpload The name of the file to upload.
   * @param {string} expectedFileNameOnFileSystem The name of the file after upload.
   * @param {function} done The mocha continuation function.
   */
  function executeFileUploadTestWalk(
    options,
    actualFileNameToUpload,
    expectedFileNameOnFileSystem,
    done
  ) {

    let filePath = path.join(fileDir, actualFileNameToUpload);
    let fileBuffer = fs.readFileSync(filePath);
    let fileHash = md5(fileBuffer);
    let fileStat = fs.statSync(filePath);
    let uploadedFilePath = path.join(uploadDir, expectedFileNameOnFileSystem);

    request(
      server.setup(options)
    )
      .post('/upload/single')
      .attach('testFile', filePath)
      .expect((res)=>{
        res.body.uploadDir = '';
        res.body.uploadPath = '';
      })
      .expect(200, {
        name: expectedFileNameOnFileSystem,
        md5: fileHash,
        size: fileStat.size,
        uploadDir: '',
        uploadPath: ''
      })
      .end(function(err) {
        if (err) {
          return done(err);
        }
        
        fs.stat(uploadedFilePath, done);
      });
  }
  describe('Testing [safeFileNames with useTempFiles] option to ensure:', function() {
    it('Does nothing to your filename when disabled.', function(done) {
      const fileUploadOptions = {
        safeFileNames: false,
        useTempFiles: true,
        tempFileDir: '/tmp/'
      };
      const actualFileName =
        'my$Invalid#fileName.png123';
      const expectedFileName =
        'my$Invalid#fileName.png123';
      executeFileUploadTestWalk(
        fileUploadOptions,
        actualFileName,
        expectedFileName,
        done
      );
    });
    it('Is disabled by default.', function(done) {
      const fileUploadOptions = {
        useTempFiles: true,
        tempFileDir: '/tmp/'
      };
      const actualFileName =
        'my$Invalid#fileName.png123';
      const expectedFileName =
        'my$Invalid#fileName.png123';
      executeFileUploadTestWalk(
        fileUploadOptions,
        actualFileName,
        expectedFileName,
        done
      );
    });

    it(
      'Strips away all non-alphanumeric characters (excluding hyphens/underscores) when enabled.', 
      function(done) {
        const fileUploadOptions = {
          safeFileNames: true,
          useTempFiles: true,
          tempFileDir: '/tmp/'
        };
        const actualFileName = 'my$Invalid#fileName.png123';
        const expectedFileName = 'myInvalidfileNamepng123';
        executeFileUploadTestWalk(
          fileUploadOptions,
          actualFileName,
          expectedFileName,
          done
        );
      });

    it(
      'Accepts a regex for stripping (decidedly) "invalid" characters from filename.', 
      function(done) {
        const fileUploadOptions = {
          safeFileNames: /[$#]/g,
          useTempFiles: true,
          tempFileDir: '/tmp/'
        };
        const actualFileName = 'my$Invalid#fileName.png123';
        const expectedFileName = 'myInvalidfileName.png123';
        executeFileUploadTestWalk(
          fileUploadOptions,
          actualFileName,
          expectedFileName,
          done
        );
      });
  });
});
