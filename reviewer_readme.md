# Introduction

## Reviewing the Intel Android Hub

You've been chosen to review article submissions from Github for Intel's Android Hub. This guide will help you through the things you need to do, in order to approve the article with confidence.

--------

## Process Overview

![process](https://drive.google.com/uc?id=0BwL_X3dS1kN_QVNwYXRydVR6VGs)

--------

### Step 1: Review Open Pull Requests

Open the list of article submissions: https://github.com/intel-android/androidhub/pulls

![pull requests](https://drive.google.com/uc?id=0BwL_X3dS1kN_Q3hRRFVGS2VMWWc)

All submissions history is preserved and openly viewable. Clicking on a pull request (PR) will open that PR's details. Also appearing next to the title of the pull request is either a green checkmark or a red X indicating whether tests have passed.

The PR details show you the files changed by the author, the author's commentary, and the pass/fail result of the build test. Review the files changed by clicking on "Files Changed" tab and follow these simple guidelines:

![changed files tab](https://drive.google.com/uc?id=0BwL_X3dS1kN_dVhKZWhNaDFUbmc)

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

NOTE: this step is only required if the author changes files that you do not feel entirely comfortable accepting without trying it locally first.

###### Setup

1. We recommend downloading an using [GitHub Desktop](https://desktop.github.com/) for reviewers new to git.

2. Follow getting started instructions (also referenced in this project's [readme.md](readme.md))

    1. Click  'Clone in Desktop' button on the github repo https://github.com/intel-android/androidhub. This downloads the site to your computer.

    2. Now we need to run some command line tools that install dependencies. Open up a Terminal window by using GitHub's menu: "Repository" > "Open in Terminal".

    3. We need to make sure that nodejs is installed on the system. Type in `node -v`, press <return> and look at the output. If nodejs is installed, it will report a version number. The version should be higher than v0.10.32. If its not, please download it at [nodejs.org](https://nodejs.org/en/). Run the command after installation to verify that node is now installed.

    4. There are several nodejs dependencies we need installed before the site will compile. Type in the following commands.

        - [Roots](http://roots.cx/) `npm i roots -g`
        - [Bower](http://bower.io/) `npm i bower -g`

    5. Type in `npm install && bower install` into the terminal window and press <return>

    This installs project dependencies for the rest of the project

    6. To generate the site, type in `roots watch` into the Terminal window, and press <return>

    This will generate the site, host it, and open it in a browser.

    This process will stay open and watch for changes to the code and update the site int the browser for you. <ctrl>+C cancels this process.

###### Preview the submission

1. Click "open this in GitHub Desktop" on the pull request page.
2. Open a Terminal Window by using the menu: Repository > Open in Terminal.
3. type in and run the following command: `roots watch`. This will build the site and open the site in a web browser.
4. Find and Preview the new article and double check author's details.

![open in github](https://drive.google.com/uc?id=0BwL_X3dS1kN_a2FUYUFKdHNZSGc)


--------

### Step 3: Review tests

![failed tests](https://drive.google.com/uc?id=0BwL_X3dS1kN_NmpXbDFZMGdIOTg)

The author's submission will automatically be tested by a product called Travis CI that will verify if the submission is valid. Submissions that fail these tests should be rejected (aka. closed). Just because a submission passes these tests does not mean you absolutely should accept (merge) it. Click on "Details" for more information. We recommend that automated tests be used only as a guideline and not as a definitive solution. Automated test suites can always be better, and reviewers should look at the results of http://int-androidhub.intel.com before releasing to production.

--------

### Step 4: Approve or Deny

##### Approving content to be sent to integration environment

![ready to merge](https://drive.google.com/uc?id=0BwL_X3dS1kN_eFVlVktXVXlhUG8)

If a submission's content looks good and the Travis CI tests are green, it is safe to merge. Click the button on the Pull Request page labeled "Merge pull request". This will merge the content into the `master` branch and tell Travis CI to automatically deploy the site to the private Integration environment. Use the integration site to review content one last time before they're pushed live for the general public to see. Please see **Step 5: Auto-Deploy to Integration** for your next steps.

##### Deny pull request to be worked on more by author
![pr comment](https://drive.google.com/uc?id=0BwL_X3dS1kN_cGJiaWRwb05Dbzg)

To deny a submission, click the "Close Pull Request" Button. The author will be notified via email. We encourage you to also send a message as to why the submission is not going to be merged into the site at this time.

--------

### Step 5: Auto-Deploy to Integration

![integration site](https://drive.google.com/uc?id=0BwL_X3dS1kN_a2I1VU5tUHdMc2c)

https://int-androidhub.intel.com

The purpose of this environment is for reviewers like you to look at the merged content in a staging environment before releasing to production. A successful merge of a pull request to the master branch will automatically deploy the submission to the integration environment. The username and password credentials were given to you separately by project staff. This site is not available to the general public. Review the content here before Releasing to Production. When you feel the content added is ready to be public, please see **Step 6: Release to Production**.

--------

### Step 6: Release to Production

We use [Github Releases](https://github.com/blog/1547-release-your-software) to power production deployments.

1. Click "Releases" in the repository page
2. Click "Create new Release"
3. Fill out the form. Set a semantic version number for the release, a new post should be a "minor" version higher, and fixes to posts should be a "patch" version higher. We'll use new feature or layout changes to denote "major" versions.

Upon submission, the git repo will be updated with a new tag. Travis CI will pick that up and deploy the result to the production site. When complete, the site will be updated on https://androidhub.intel.com

![release](https://drive.google.com/uc?id=0BwL_X3dS1kN_aFRVeUNYQzMyRGs)

--------

## Glossary

#### Development Terminology

- **Integration Environment** lives at https://int-androidhub.intel.com. After a pull request is merged into github repository, it will be deployed here. Look over the site before releasing to production.
- **Production Environment** lives at https://androidhub.intel.com
- **Continuous Integration (CI)** is an automated process we've setup that looks at a github code update and runs pre-defined checks and tests. The results of the tests are linked into the Pull Request.
- **[Semantic Versioning](http://semver.org/)** is an industry standard versioning system that separates "breaking" changes, from "compatible" changes, from "bugfix" changes. This is expressed as 3 numbers separated by a ".". For example, "3.1.4" is the 3rd major version, 1st minor update to the 3rd version, and the 4th patch version to the 1st minor update. We use it to version the site's releases so its clear that new content has been deployed to production.

#### Git Terminology

for more information, please see GitHub's excellent [glossary](https://help.github.com/articles/github-glossary/).

- **Pull Request (PR)** content submissions from other Github users, most commonly Android Hub Contributors.
- **master branch** is the main source of code that is both merged into to deploy the site and branched from by authors so they can add content via a Pull Request.
- **fork** is the process by which community authors can copy the repository to their own GitHub account, make changes, and then submit pull requests to our main github repository.
