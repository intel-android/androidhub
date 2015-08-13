# Contributing to the Intel Android Hub!
{Welcome Message}

##### Required Tools
> These tools need to be installed on your machine, hopefully they're already there. We also expect you to have a Github account, and have used CLI tools a bit

- [Node/NPM](https://nodejs.org/)
- [Roots](http://roots.cx/) `npm i -g roots`
- [Bower](http://bower.io/) `npm i -g bower`
- Git





## Setup
1. Fork
2. Clone your fork
3. Install project dependencies `npm i && bower i`

#### Overview
There's lot o stuff in the project folder, how about I point you to what's relevant for you? =)
```
this_project/
└─── data/
    └─── authors/
    		your_github_handle.yaml
    		someone_else.yaml
    		...
└─── posts/
    └─── your_github_handle/
    		your-post-file-name.jade
            ...
```





## Init
If this is your first time contributing to the hub, you'll need to create yourself by putting some data into some files. We've got a handy author kickoff script that does lots of the work for you, so let's start there.

##### Kick it off!
In your terminal, type `npm run new-author`

##### So what's gonna happen?
Enter your github handle into the cli prompt, this creates a .yaml entry for you in `data/authors/`, which will look like this. 

```yaml
# Personal Info
displayname:  ''
nickname:     ''
website:      ''
title:        ''

# Social Networks
twitter:      ''
github:       '{{github_handle}}'
codepen:      ''
```

It also creates a folder for you in `posts/{{your_handle}}/` which will hold onto your posts. We'll talk about that next.




## Write
If you're familiar with blog engines like [Ghost](https://ghost.org/) or [Jekyll](http://jekyllrb.com/), then you'll be right at home with the Intel Android Hub's blog architecture. What's awesome about this architecture though, you're not limited to just Markdown, you can write [Jade](http://jade-lang.com/), [Coffeescript](http://coffeescript.org/), [etc](http://jade-lang.com/reference/filters/)! We felt that most authors would prefer markdown, so that's the style we'll talk about here. 

##### Example Post:
```
---
title:      'My First Post!'
tags:       [android]
categories: [ideate, launch]
heroimage:  ''
excerpt:    'Short description of the article'
---

extends ../views/layouts/_single

block content
  :markdown
    Here's my first post. **How exciting!**
```




## Test







## Pull Request