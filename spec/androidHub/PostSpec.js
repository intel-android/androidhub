var _      = require("lodash");
var fs     = require("fs");
var jade   = require("jade");
var yaml   = require("js-yaml");

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
  it("filename is a string", function () {
    expect(filename).toEqual(jasmine.any(String));
  });

  var fileInput = fs.readFileSync(filename, "utf8");
  var post = filename.split('/')[-1];

  it(post + " read the file in as a string", function() {
    expect(fileInput).toEqual(jasmine.any(String));
  });

  describe(post + " is a combination of yaml and jade", function () {
    var parts     = fileInput.split('---');
    var yamlInput = parts[1];
    var jadeInput = parts[2];
    var data,template;

    beforeEach(function () {
      data = yaml.safeLoad(yamlInput);
      template = jade.compile(jadeInput, {filename: filename});
    });

    describe('yaml data', function () {
      it('yaml parses into an object', function() {
        // TODO parse into yaml and inspect object for required vars
        expect(data).toEqual(jasmine.any(Object));
      });

      describe("title field", function () {
        it('is required', function () {
          expect(data.title).toEqual(jasmine.any(String));
        });

        it('is not too long (100 characters)', function () {
          expect(data.title.length).toBeLessThan(100);
        });
      });

      describe("author key", function () {
        it('is required', function () {
          expect(data.author).toEqual(jasmine.any(String));
        });

        it('is not too long (20 characters)', function () {
          expect(data.author.length).toBeLessThan(20);
        });
      });

      describe("date key", function () {
        it('is required', function () {
          expect(data.date).toEqual(jasmine.any(String));
        });

        // moment(date) throws a deprecation warning
        // see https://github.com/moment/moment/issues/1407 for more info
        it('date parses by moment.js to a valid date', function () {
          expect(data.date).toBeValidDate();
        });
      });
    });


    it('jade parses into a function', function() {
      expect(template).toEqual(jasmine.any(Function));
    });

  });
}
