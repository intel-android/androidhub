# Intel Android Hub



### Setup

- make sure [node.js](http://nodejs.org) and [roots](http://roots.cx) are installed
- clone this repo down and `cd` into the folder
- run `npm i` to kick off installation
- run `bower i` to install front end deps
- run `roots watch` to begin dev development

### App Overview / Folder Architecture
- `assets/`: You'll find the js and css in here, as well as images
- `data/`: The .yaml files found in this folder and turned into json objects and passed to jade templates. Keeps the markup dry, and puts most of the data into 1 place to maintain.
- `posts/`: Holds authors feed posts. Folder name must match `data/authors > .yaml` file name. Posts are rendered against the `_single.jade` layout and turned into static post pages.
- `views/`: Jade files and actual html for the site is in here. 


### Deploying

- If you just want to compile the production build, run `roots compile -e production` and it will build to public.
- To deploy your site with a single command, run `roots deploy -to XXX` with `XXX` being whichever [ship](https://github.com/carrot/ship#usage) deployer you want to use.

### Testing
`npm run test`