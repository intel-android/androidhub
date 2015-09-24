## Reviewing the Intel Android Hub
So you've been chosen to review article submissions from Github for this funky fresh blog. I'll guide you through the things you need to do, in order to accept the article with confidence.

## Setup
1. Follow getting started instructions in the main project readme.md to get the basic project running
2. Follow the rest of these instructions to determine if you'll accept or decline the article submission

&nbsp;

## Goal
- View open pull requests/submissions
- Preview a submission
- Run tests
- Accept/Deny

#### View Open Pull Requests
![preview](https://drive.google.com/uc?id=0B6rG4e8CXFiGWmcwMHNhdUFOdk0)
Direct Link: https://github.com/intel-android/androidhub/pulls

This page will have a list of article submissions. I suggest playing around here and learning what's going on. For example, you can view old submissions, rejected submissions, etc. All the history is preserved and openly viewable for anyone. By clicking on a pull request (PR), you'll find yourself at the PR detail.

The PR detail will show you all the files changed by the author, with commentary, as well as whether or not the submission is passing the build test. Review the changed files within the Pull Request. Only the author's own folder should be changed. Nothing in ~/assets, ~/scripts/, ~/spec, ~/views should change either. Reject the Pull Request right away if the author attempted to change anything outside their own folder in ~/posts or their author.yaml file in ~/data/authors.

### Automated Testing

Travis CI will automatically trigger jobs that verify that the author's content is sane enough and that the result of the merge will build into a "valid" site. We recommend that this only be used as a guide line and not as a definitive solution. Automated test suites can always be better, and reviewers should look at the results of http://int-androidhub.intel.com before pushing that to production.

### Denying Content

To deny a pull request, click the "Close Pull Request" Button. The author will be notified via email, but we encourage you to also send a message as to why their contribution is not going to be merged into the site.

### Merging Content

Discuss the content with the author in the pull request. When you both agree that the content is ready, and Travis CI jobs are green, it is safe to merge.

### View on Integration site

https://int-androidhub.intel.com

The above url is the integration site. The username and password for it were given to you by project staff directly. This site is automatically deployed upon a successful merge to the master branch on the github repository.

### Deploy to Production

https://androidhub.intel.com

We use [Github Releases]:(https://github.com/blog/1547-release-your-software) to power production deployments. Please click "Create new Release" and fill out the form. Set a semantic version number for the release, a new post should be a "minor" version, and fixes to posts should be a "patch" version increment. Upon submission, the git repo will be updated with a new tag. Travis CI will pick that up and deploy the result to the production site. Enjoy!
