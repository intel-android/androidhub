var Jasmine = require('jasmine');
var SpecReporter = require('jasmine-spec-reporter');
var noop = function() {};

// for image download tasks
Jasmine.DEFAULT_TIMEOUT_INTERVAL = 30000;

var jrunner = new Jasmine();
jrunner.configureDefaultReporter({print: noop});    // remove default reporter logs
jasmine.getEnv().addReporter(new SpecReporter());   // add jasmine-spec-reporter
jrunner.loadConfigFile();                           // load jasmine.json configuration
jrunner.execute();
