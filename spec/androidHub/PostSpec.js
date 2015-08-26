require('jasmine-expect');

var _      = require("lodash");
var fs     = require("fs");
var jade   = require("jade");
var yaml   = require("js-yaml");
var request = require("request");
var path = require("path");
var root = path.resolve(process.cwd());
var imagemagick = require("imagemagick");
var mime = require("mime");

describe("Posts", function() {
  var glob = require("glob");
  var posts = glob.sync("posts/*/*.jade");

  if (posts.length < 1) {
    throw "no posts found.";
  }

  if (_.contains('*', posts[0])) {
    throw "no files found in " + posts[0];
  }

  for (var i = 0; i < posts.length; i++) {
    test_post(posts[i]);
  }
});

function test_post(filename) {
  it("filename is a string", function() {
    expect(filename).toBeString();
  });

  var fileInput = fs.readFileSync(filename, "utf8");
  var post = filename.match(/\/.*\/(.*)$/)[1];

  it(post + " read the file in as a string", function() {
    expect(fileInput).toBeString();
  });

  describe(post + " is a jade file with yaml frontmatter", function() {
    var parts     = fileInput.split('---');
    var yamlInput = parts[1];
    var jadeInput = parts[2];
    var data,template;

    beforeEach(function() {
      data = yaml.safeLoad(yamlInput);
      template = jade.compile(jadeInput, {filename: filename});
    });

    describe("author", function() {
      // author comes from the path
      var author = filename.split('/')[1];

      it('is required', function() {
        expect(author).toBeString();
      });

      it('is not too long (20 characters)', function() {
        expect(author.length).toBeLessThan(20);
      });

      describe('has matching author.yaml', function() {
        var yamlPath = "data/authors/" + author + ".yaml";

        it("file exists", function (done) {
          fs.exists(yamlPath, function(exists) {
            if (!exists) {
              done(yamlPath + ' does not exist. Please create it.');
            } else {
              done();
            }
          });
        });

        it("yaml parses into object", function() {
          var authorYaml = yaml.safeLoad(fs.readFileSync(yamlPath, "utf8"));
          expect(authorYaml).toBeObject();
        });
      });
    });

    describe('yaml data', function() {
      it('yaml parses into object', function() {
        // TODO parse into yaml and inspect object for required vars
        expect(data).toBeObject();
      });

      describe("title field", function() {
        it('is required', function() {
          expect(data.title).toBeString();
        });

        it('is not too long (200 characters)', function() {
          expect(data.title.length).toBeLessThan(200);
        });
      });

      describe("categories key", function() {
        it('is an array of strings', function() {
          expect(data.categories).toBeArrayOfStrings();
        });

        it('at least 1 category', function() {
          expect(data.categories.length).toBeGreaterThan(0);
        });

        it('but not too many (3 max)', function() {
          expect(data.categories.length).toBeLessThan(4);
        });

        it('contains valid categories', function() {
          var validCategories = ['ideate', 'design', 'build', 'launch'];

          for (var i = 0; i < data.categories.length; i++) {
            expect(validCategories).toContain(data.categories[i]);
          }
        });
      });
    });

    describe("heroimage key", function() {
      it('is a url', function() {
        expect(data.heroimage).toBeString();
      });

      describe("remote image", function() {
        var response = null;
        var filename = null;
        var extension = null;

        var download = function(uri, filename, callback){
          request.head(uri, function(err, res, body){
            response = res;
            extension = mime.extension(res.headers['content-type']);

            request(uri).pipe(fs.createWriteStream(filename + '.' + extension)).on('close', callback);
          });
        };

        beforeAll(function(done) {
          jasmine.DEFAULT_TIMEOUT_INTERVAL = 30000;
          filename = root + '/tmp/' + Math.random().toString().split('.').pop();
          download(data.heroimage, filename, function () {
            done();
          });
        });

        afterAll(function(done) {
          fs.unlink(filename + '.' + extension, function (err) {
            if (err) throw err;
            done();
          });
        });

        it('resolves to 200', function() {
          expect(response.statusCode).toBe(200);
        });

        it('has an image content-type', function() {
          expect(['image/jpeg', 'image/png', 'image/svg']).toContain(response.headers['content-type']);
        });

        it('is smaller than 5MB', function() {
          expect(parseInt(response.headers['content-length'])).toBeLessThan(5*1024*1024);
        });

        describe('heroimage dimensions', function() {
          var image = null;
          beforeAll(function (done) {
            imagemagick.identify(filename + '.' + extension, function(err, features){
              if (err) throw err;
              image = features;
              done();
            });
          });

          it('has a height larger than 100px', function() {
            expect(image.height).toBeGreaterThan(99);
          });

          it('has a width larger than 640px', function() {
            expect(image.width).toBeGreaterThan(639);
          });
        });
      });
    });


    describe('jade', function () {
      it('parses into a function', function() {
        expect(template).toBeFunction();
      });

      xdescribe('external resources', function () {
        xit('are local resources', function () {

        });

        xit('are referencing the local author\'s assets dir');

        xit('resolve to a valid resource');
      });
    });

  });
}
