require('jasmine-expect');

var _      = require("lodash");
var fs     = require("fs");
var jade   = require("jade");
var yaml   = require("js-yaml");
var request = require("request");
var path = require("path");
var glob = require("glob");
var root = path.resolve(process.cwd());
var imagemagick = require("imagemagick");
var mime = require("mime");
var filesizeParser = require('filesize-parser');

describe("Posts", function() {
  var posts = glob.sync("posts/*/*.jade");

  if (posts.length < 1) {
    throw "no posts found.";
  }

  if (_.contains('*', posts[0])) {
    throw "no files found in " + posts[0];
  }

  beforeAll(function() {
    // mkdir tmp
    try {
      fs.mkdirSync(root + '/tmp');
    } catch (e) {
      console.error(e);
    }
  });

  afterAll(function() {
    fs.rmdirSync(root + '/tmp');
  });

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
    var data;
    var author;

    beforeAll(function() {
      data = yaml.safeLoad(yamlInput);
    });

    describe("author", function() {
      // author comes from the path
      author = filename.split('/')[1];

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

      describe('local hero image', function () {
        var filename, image;

        beforeAll(function(done) {
          filename = root + '/posts/' + author + '/library/' + data.heroimage;

          imagemagick.identify(filename, function(err, features){
            if (err) done.fail(filename + ': ' +err);
            image = features;
            done();
          });
        });

        xit('maps to a real local file');

        xit('the file is an image type');

        it('has an image content-type', function() {
          expect(['JPEG', 'SVG', 'WEBP', 'PNG', 'GIF']).toContain(image.format);
        });

        it('has a height larger than 100px', function() {
          expect(image.height).toBeGreaterThan(99);
        });

        it('has a width larger than 640px', function() {
          expect(image.width).toBeGreaterThan(639);
        });

        it('is smaller than 5MB', function() {
          image.filesize = image.filesize.replace('KBB', 'KB');
          expect(filesizeParser(image.filesize)).toBeLessThan(5*1024*1024);
        });
      });
    });

    describe('jade', function () {
      var template//, html;
      beforeAll(function() {
        template = jade.compile(jadeInput, {filename: filename});
        // html = template(data);
      });

      it('parses into a function', function() {
        expect(template).toBeFunction();
      });

      xit('html is a string', function() {
        expect(html).toBeString();
      });

      xdescribe('resources', function () {
        var images = [];
        var videos = [];
        var author = filename.split('/')[1];
        var assets = glob.sync('posts/' + author + '/assets/*');

        beforeAll(function(done) {
          images = html.match(/<img[^>]+src=\"([^"]+)/ig);
          videos = html.match(/<video[^>]+src=\"([^"]+)/ig);
        });

        _.forEach(images, function(image) {
          it('is a local path', function() {
            expect(image).toStartWith('assets');
          });

          it('ends with a valid image type', function() {
            validExtensions = ['jpg', 'jpeg', 'png', 'svg'];
            expect(validExtensions).toContain(image.split('.')[-1]);
          });

          it('resolve to a valid resource', function(done) {
            var path = root + 'posts/' + author + image;
            fs.exists(path, function(exists) {
              if (exists) {
                done();
              } else {
                done.fail('404 file not found');
              }
            });
          });
        });

        _.forEach(videos, function(video) {
          it(video + 'is from an approved source', function() {
            var approvedDomains = ['youtube.com', 'vimeo.com', 'youtu.be'];
            var containsDomain = false;
            _.forEach(approvedDomains, function(domain) {
              if (video.indexOf(domain) > 0) {
                containsDomain = true;
                return false;
              }
            });

            expect(containsDomain).toBe(true);
          });
        });
      });
    });

  });
}
