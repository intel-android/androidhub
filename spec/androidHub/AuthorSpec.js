var _      = require("lodash");
var fs     = require("fs");
var yaml   = require("js-yaml");
var request = require("request");

describe("Authors", function() {
  var glob = require("glob");
  var authors = glob.sync("data/authors/*.yaml");

  if (authors.length < 1) {
    throw "no authors found.";
  }

  if (_.contains('*', authors[0])) {
    throw "no files found in " + authors[0];
  }

  for (var i = 0; i < authors.length; i++) {
    test_author(authors[i]);
  }
});

function test_author(filename) {
  it("filename is a string", function () {
    expect(filename).toEqual(jasmine.any(String));
  });

  var fileInput = fs.readFileSync(filename, "utf8");

  describe(filename, function () {
    var data;

    beforeEach(function () {
      data = yaml.safeLoad(fileInput);
    });

    describe('yaml data', function () {
      it('yaml parses into an object', function() {
        // TODO parse into yaml and inspect object for required vars
        expect(data).toEqual(jasmine.any(Object));
      });

      describe("twitter key", function () {
        it('is required', function () {
          expect(data.twitter).toEqual(jasmine.any(String));
          expect(data.twitter).not.toBeEmptyString();
        });

        // according to https://support.twitter.com/articles/14609
        it('is not too long (15 characters)', function () {
          expect(data.twitter.length).toBeLessThan(16);
        });
      });
    });

  });
}
