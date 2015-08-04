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

      describe("nickname field", function () {
        it('is required', function () {
          expect(data.nickname).toEqual(jasmine.any(String));
        });

        it('is not too long (20 characters)', function () {
          expect(data.nickname.length).toBeLessThan(20);
        });
      });

      describe("gravatar key", function () {
        it('is required', function () {
          expect(data.gravatar).toEqual(jasmine.any(String));
          expect(data.gravatar).not.toEqual('');
        });

        it('is not too long (200 characters)', function () {
          expect(data.gravatar.length).toBeLessThan(200);
        });

        it('is a valid url', function(done) {
          request(data.gravatar, function(err, res, body) {
            if (err) done(err);

            expect(res.statusCode).toEqual(200);
            done();
          });
        });
      });
    });

  });
}
