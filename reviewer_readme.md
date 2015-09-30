# Introduction

## Reviewing the Intel Android Hub
So you've been chosen to review article submissions from Github for this funky fresh blog. This guide will help you through the things you need to do, in order to accept the article with confidence.

--------

## Glossary

- *Pull Requst (PR)* content submissions from other Github users, most commonly Android Hub Contributors.
- *npm* is a javascript based package manager that installed the Android Hub's dependencies and libraries.
- *bower* is another javascript based package manager focused on client side (browser) based code.
- *Continuous Integration (CI)* is an automated process we've setup that looks at a github code update and runs pre-defined checks and tests. The results of the tests are linked into the Pull Request.
- *[Semantic Versioning](http://semver.org/)* is an industry standard versioning system that separates "breaking" changes, from "compatible" changes, from "bugfix" changes. This is expressed as 3 numbers separated by a ".". For example, "3.1.4" is the 3rd major version, 1st minor update to the 3rd version, and the 4th patch version to the 1st minor update. We use it to version the site's releases so its clear that new content has been deployed to production.
(note: add integration and production to this list.  move to bottom and reference the relevant terms)
--------

## Setup
  1. Don't know where to start? Reference our helpful Setup Guide.

## Process Overview

![process](https://drive.google.com/uc?id=0BwL_X3dS1kN_QVNwYXRydVR6VGs)

--------

### Step 1: Review Open Pull Requests

Open the list of article submissions: https://github.com/intel-android/androidhub/pulls

All submissions history is preserved and openly viewable. Clicking on a pull request (PR) will open that PR's details.

The PR details show you the files changed by the author, the author's commentary, and the pass/fail result of the build test. Review the files changed and follow these simple guidelines:

##### Acceptable Changes:

- `~/data/authors/<author>.yaml`
- anything in their posts folder inside `~/posts/<author>`

Changes to these folders should be considered for approval.

##### Unacceptable Changes:

- `assets` - front end css, js, and images
- `scripts` - support scripts and helpers for the site
- `spec` - testing suite for the site
- `views` - templates for the site

Changes to these folders should be rejected immediately.

###### Tip: [Learn more about pull requests](https://help.github.com/articles/using-pull-requests/#reviewing-the-pull-request) from the masters.

--------

### Step 2: Preview submission
(note - add image of open in github app button)

If you are unsure about the code being merged, you can preview the site locally and click around to ensure everything still works.

--------

### Step 3: Review tests

![failed tests](https://drive.google.com/uc?id=0BwL_X3dS1kN_NmpXbDFZMGdIOTg)

The author's submission will automatically be tested by a product called Travis CI that will verify if the submission is valid. Submissions that fail these tests should be rejected (aka. closed). Just because a submission passes these tests does not mean you absolutely should accept (merge) it. Click on "Details" for more information. We recommend that automated tests be used only as a guideline and not as a definitive solution. Automated test suites can always be better, and reviewers should look at the results of http://int-androidhub.intel.com before releasing to production.

--------

### Step 4: Accept or Deny

##### Accept

![ready to merge](https://drive.google.com/uc?id=0BwL_X3dS1kN_eFVlVktXVXlhUG8)

If a submission's content looks good and the Travis CI tests are green, it is safe to merge. Click the button on the Pull Request page labeled "Merge pull request". This will merge the content into the `master` branch and tell Travis CI to automatically deploy the site to the private Integration environment.

##### Deny
![pr comment](https://drive.google.com/uc?id=0BwL_X3dS1kN_cGJiaWRwb05Dbzg)

To deny a submission, click the "Close Pull Request" Button. The author will be notified via email. We encourage you to also send a message as to why the submission is not going to be merged into the site at this time.

--------

### Step 5: Auto-Deploy to Integration

![integration site](https://drive.google.com/uc?id=0BwL_X3dS1kN_a2I1VU5tUHdMc2c)

https://int-androidhub.intel.com

The above url is the integration site. A successful merge to the master branch on github will automatically deploy the submission to the Integration environment. The username and password for it were given to you by project staff. 

--------

### Step 6: Release to Production

![release](https://drive.google.com/uc?id=0BwL_X3dS1kN_aFRVeUNYQzMyRGs)

We use [Github Releases](https://github.com/blog/1547-release-your-software) to power production deployments. Please click "Create new Release" and fill out the form. Set a semantic version number for the release, a new post should be a "minor" version, and fixes to posts should be a "patch" version increment.

Upon submission, the git repo will be updated with a new tag. Travis CI will pick that up and deploy the result to the production site. The site is now updated on https://androidhub.intel.com
