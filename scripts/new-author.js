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
    request  = require('request'),
    yaml     = require("js-yaml"),
    bioData  = {
      displayname: '',
      nickname   : '',
      website    : '',
      title      : '',
      company    : '',
      twitter    : '',
      github     : '',
      codepen    : ''
    };

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
    input = 'http://' + input;
  }

  var done = this.async();
  console.log('  fetching url...');
  request.head(input, function(err, res) {
    if (err) {
      done("You must return a valid URL.");
      return;
    }

    if (res.statusCode == 200) {
      done(true);
    } else {
      done("You must return a valid URL.");
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
    message : 'What is your handle? Must be unique to this site. *',
    name    : 'nickname',
    validate: required
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
    message : 'What is your *github* username? *',
    name    : 'github',
    validate: required
  },
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
  console.log(answers);

  var yamlString = yaml.safeDump(answers);
  var path = '../data/authors/' + answers.nickname + '.yaml';

  fs.writeFile(path, yamlString, function(err) {
    if (err) throw err;
    console.log('wrote ' + answers.nickname + '.yaml to ' + path);
  });
  //write to yaml file
});
