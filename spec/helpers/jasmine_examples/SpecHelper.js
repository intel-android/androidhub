var moment = require('moment');

beforeEach(function () {
  jasmine.addMatchers({
    // TODO add custom matchers here
    toBeValidDate: function() {
      return {
        compare: function(date) {
          var result = { pass: moment(new Date(date)).isValid() };
          if (!result.pass) {
            result.message = "Expected date "+date+" to be valid";
          } else {
            result.message = "Expected date "+date+" to NOT be valid";
          }

          return result;
        }
      };
    }
  });
});
