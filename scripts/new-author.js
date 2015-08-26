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

console.log('NEW AUTHOR SETUP\n');
console.log('questions marked with * are required');

var required = function(input) {
  return input.length > 0;
};

var validUrl = function(input) {
  if (input.length < 1) {
    return "Required question. Please try again.";
  }

  if (input.indexOf('http://') === -1) {
    if (input.indexOf('www') === -1) {
      input = 'www.' + input;
    }
    input = 'http://' + input;
  }

  var done = this.async();
  console.log('         fetching ' + input + ' ...');
  request.head(input, function(err, res) {
    if (err) {
      done("You must return a valid URL.");
      return;
    }

    console.log('received HTTP status code ' + res.statusCode);

    if (res.statusCode == 200) {
      done(true);
    } else {
      done("You must return a valid URL.");
    }
  });
};

var checkIfNewAuthor = function(input) {
  var done = this.async();

  fs.exists(path.resolve(root + '/data/authors/' + input + '.yaml'), function(exists) {
    if (exists) {
      done("this username already exists. Pick another.");
    } else {
      done(true);
    }
  });
};

var questions = [
  {
    type    : 'input',
    message : 'What is your full name? *',
    name    : 'displayname',
    validate: required
  },
  {
    type    : 'input',
    message : 'What is your *github* username? *',
    name    : 'github',
    validate: required && checkIfNewAuthor
  },
  {
    type    : 'input',
    message : 'What is the name of the company you work for? *',
    name    : 'company',
    validate: required
  },
  {
    type    : 'input',
    message : 'What is your title at this company? *',
    name    : 'title',
    validate: required
  },
  {
    type    : 'input',
    message : 'What website would you like us to link to? *',
    name    : 'website',
    validate: validUrl
  },
  // SOCIAL MEDIA ACCOUNTS
  {
    type    : 'input',
    message : 'What is your *twitter* username? *',
    name    : 'twitter',
    validate: required
  },
  {
    type   : 'input',
    message: 'What is your *codepen* username?',
    name   : 'codepen'
  },
];

inquirer.prompt(questions, function( answers ) {
  var yamlString = yaml.safeDump(answers);
  var user = answers.github;
  var authorYamlPath = path.resolve(root + '/data/authors/' + user + '.yaml');


  //write to yaml file
  fs.writeFile(authorYamlPath, yamlString, function(err) {
    if (err) throw err;
    console.log('wrote ' + authorYamlPath);
    console.log('This will populate the authors page as well as pull your information into your posts.');
  });

  //create posts directory
  fs.mkdirSync(path.resolve(root + '/posts/' + user), 0755);

  //copy in the template.jade into the directory
  var template = fs.readFileSync(path.resolve(root + '/posts/template.jade'), 'utf8');
  var templatePath = path.resolve(root + '/posts/' + user);
  template = template.replace("\n_ignore:    true", '');
  fs.writeFile(templatePath + '/first_post.jade', template, function (err) {
    if (err) throw err;
    console.log('first_post.jade was created and placed in ' + templatePath);
    console.log();
    console.log('Next steps:');
    console.log('1. run: "npm run post" to create a new post');
    console.log('2. write your awesome content');
    console.log('3. submit a pull request to http://github.com/intelandroid/androidhub.');
    console.log();
    console.log('Thanks for contributing!');
  });
});
