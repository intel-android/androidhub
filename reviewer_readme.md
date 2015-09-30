# Introduction

## Reviewing the Intel Android Hub
So you've been chosen to review article submissions from Github for this funky fresh blog. This guide will help you through the things you need to do, in order to accept the article with confidence.

--------

## Glossary

- *Pull Requst (PR)* content submissions from other Github users, most commonly Android Hub Contributors.
- *npm* is a javascript based package manager that installed the Android Hub's dependencies and libraries.
- *bower* is another javascript based package manager focused on client side (browser) based code.
- *Continuous Integration (CI)* is an automated process we've setup that looks at a github code update and runs pre-defined checks and tests. The results of the tests are linked into the Pull Request.
- *Semantic Versioning* is an industry standard versioning system that separates "breaking" changes, from "compatible" changes, from "bugfix" changes. This is typically express as 3 numbers separated by a ".". For example, "3.1.4" is the 3rd major version, 1st minor update to the 3rd version, and the 4th patch version to the 1st minor update.

--------

## Setup
1. We recommend downloading an use [GitHub Desktop](https://desktop.github.com/) for reviewers new to git.

1. Follow getting started instructions in the main project readme.md
    1. `git clone https://github.com/intel-android/androidhub.git` or click  'Clone in Desktop' button on the github repo https://github.com/intel-android/androidhub

    This downloads the site to your computer.

    2. Open up a terminal window at the project directory. Run `npm install && bower install`

    This installs project dependencies

    3. `roots watch`

    This will generate the site, host it, and open it in a browser.

    This process will stay open and watch for changes to the code and update the site int the browser for you. <ctrl>+C cancels this process.

2. Now you are running locally to be able to preview a pull request and determine if it should be merged into the site.

--------

## Goal

![process](https://drive.google.com/a/deloitte.com/uc?id=0BwL_X3dS1kN_bHFuOGl4MU5rN0U)
- View open pull requests
- Preview a submission
- Run tests
- Accept or Deny Pull Request
- Deploy to Integration site
- Deploy to Production site

--------

### View Open Pull Requests
![preview](https://drive.google.com/uc?id=0B6rG4e8CXFiGWmcwMHNhdUFOdk0)
Direct Link: https://github.com/intel-android/androidhub/pulls

This page will have a list of article submissions. I suggest playing around here and learning what's going on. For example, you can view old submissions, rejected submissions, etc. All the history is preserved and openly viewable for anyone. By clicking on a pull request (PR), you'll find yourself at the PR detail.

The PR detail will show you all the files changed by the author, with commentary, as well as whether or not the submission is passing the build test. Review the changed files within the Pull Request. Below are some guidelines to follow while reviewing pull requests.

#### Authors Can Change:

- `~/data/authors/<author>.yaml`
- anything in their posts folder inside `~/posts/<author>`

#### Authors Can Not Change:

- the following files are core to the site experience and should not be changed by content authors.
  - `assets` - front end css, js, and images
  - `scripts` - support scripts and helpers for the site
  - `spec` - testing suite for the site
  - `views` - templates for the site

If you are unsure about the code being merged, you can preview the site locally and click around to ensure everything still works.

--------

### Automated Testing

![failed tests](https://drive.google.com/uc?id=0BwL_X3dS1kN_NmpXbDFZMGdIOTg)

Travis CI will _automatically_ trigger jobs that verify that the author's content is sane enough and that the result of the merge will build into a "valid" site. Click on "Details" for more information. We recommend that this only be used as a guide line and not as a definitive solution. Automated test suites can always be better, and reviewers should look at the results of http://int-androidhub.intel.com before pushing that to production.

--------

### Denying Content

![pr comment](https://drive.google.com/uc?id=0BwL_X3dS1kN_cGJiaWRwb05Dbzg)

To deny a pull request, click the "Close Pull Request" Button. The author will be notified via email, but we encourage you to also send a message as to why their contribution is not going to be merged into the site.

--------

### Merging Content

![ready to merge](https://drive.google.com/uc?id=0BwL_X3dS1kN_eFVlVktXVXlhUG8)

Discuss the content with the author in the pull request. When you both agree that the content is ready, and Travis CI jobs are green, it is safe to merge. Click the button on the Pull Request page labeled "Merge pull request". This will merge the content into the `master` branch and tell Travis CI to automatically deploy the site to the private Integration envrionment.

--------

### View on Integration site

![integration site](https://drive.google.com/uc?id=0BwL_X3dS1kN_a2I1VU5tUHdMc2c)

https://int-androidhub.intel.com

The above url is the integration site. The username and password for it were given to you by project staff directly. This site is automatically deployed upon a successful merge to the master branch on the github repository.

--------

### Deploy to Production

![release](https://drive.google.com/uc?id=0BwL_X3dS1kN_aFRVeUNYQzMyRGs)

We use [Github Releases](https://github.com/blog/1547-release-your-software) to power production deployments. Please click "Create new Release" and fill out the form. Set a semantic version number for the release, a new post should be a "minor" version, and fixes to posts should be a "patch" version increment.

Upon submission, the git repo will be updated with a new tag. Travis CI will pick that up and deploy the result to the production site. The site is now updated on https://androidhub.intel.com
