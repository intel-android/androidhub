// # Personal Info
// displayname: <Your Name>
// nickname   : <Your Nickname>
// website    : 'http://aegaas.com'
// title      : 'Web Services Engineer'
// company    : 'Deloitte Digital'
//
// # Social Networks
// twitter    : 'aegaas'
// github     : 'aegaas'
// codepen    : 'aegaas'

var inquirer = require("inquirer"),
    fs       = require("fs"),
    path     = require("path"),
    request  = require('request'),
    yaml     = require("js-yaml");

var root = path.resolve(__dirname + '/../');

console.log('NEW POST SETUP\n');
console.log('questions marked with * are required');

var required = function(input) {
  return input.length > 0;
};

var checkIfAuthor = function(input) {
  var done = this.async();

  fs.exists(root + '/data/authors/' + input + '.yaml', function (exists) {
    if (!exists) {
      done('author .yaml file missing for ' + input + '. Please run "npm run new" to create.');
      process.exit();
      return;
    }

    done(true);
  });
};

var questions = [
  {
    type    : 'input',
    message : 'username? *',
    name    : 'user',
    validate: required && checkIfAuthor
  },
  {
    type    : 'input',
    message : 'Post Title? *',
    name    : 'title',
    validate: required
  }
];

inquirer.prompt(questions, function( answers ) {
  var yamlString = yaml.safeDump(answers);
  var user = answers.user;

  //create posts directory
  var postsDir = path.resolve(root + '/posts/' + user);
  if (!fs.existsSync(postsDir)) {
    console.log('creating ' + postsDir);
    fs.mkdirSync(postsDir, 0755);
  }

  //copy in the template.jade into the directory
  var template = fs.readFileSync(path.resolve(root + '/posts/template.jade'), 'utf8');
  var templatePath = path.resolve(root + '/posts/' + user);
  template = template.replace("\n_ignore:    true", '');
  template = template.replace("\ntitle:      'My First Post!'", "\ntitle:      '"+answers.title+"'");
  var filename = answers.title.split(" ").slice(0, 4).join("_") + '.jade';
  fs.writeFile(templatePath + '/' + filename, template, function (err) {
    if (err) throw err;
    console.log(filename + ' was created and placed in ' + templatePath);
    console.log();
    console.log('Next steps:');
    console.log('1. write your awesome content');
    console.log('2. modify the jade "frontmatter" of your post\'s metadata');
    console.log('3. test your post for validity with "npm test"');
    console.log('4. submit a pull request to http://github.com/intelandroid/androidhub');
    console.log();
    console.log('Thanks for contributing!');
  });
});
