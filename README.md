# Jekyll Template

## Setup and initial installation

If this is your first time using the Jekyll Template, you may need to install some dependencies.

### Ruby

macOS users will have ruby already, but it is recommended to upgrade to a newer version using Homebrew:

* Install [Homebew](https://brew.sh/)
* `brew install ruby`

### Bundle

Bundle is a tool for managing ruby dependencies. It is installed using a ruby package called `gem`, which you should already have from installing ruby:

`gem install bundle`

### NodeJS and NPM
NodeJS and NPM are necesarry for running the grunt tasks. Follow [this guide](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) to get them installed. 


## Development

Select the Use this Template button at the top of the page, label your new repo, then select 

Pull to local then locate your repo and run:

`cd <your-repo>`

Now install Jekyll using Bundle:

`bundle`

You should messages about packages being installed, ending with something like: "Bundle complete! 6 Gemfile dependencies, 33 gems now installed."

If you have NodeJS and NPM installed, install all dependencies: 

`npm i`

Now you should be able to start your local jekyll server:

`grunt`

Go to `localhost:4000` to see it in action and `localhost:4000/admin` to access the admin panel

### Configuration of your site

Once you have the template copied to your repo, you can add the meta data through the config.yml:

Open `_config.yml` file and edit the following fields to be included in your metadata:

`title`
The title of your site

`description`
The short description of your site for SEO and social share.

`meta_img`
The image card for social share. This will need to be an absolute path to the production domain.

`url`
The domain of your site.

`gtm`
The Google Tag Manager ID for your site

#### Collections

[Collections](https://jekyllrb.com/docs/collections/) are custom content types. There is a commented out collections in the `_config.yml` that can can uncomment to create your own collections. These are useful if you want to display unique sets of content like person bios or events.

### HTML/Homepage

Jekyll Admin supports full fledged websites that use layouts to display content on pages. The jekyll_spt is initially set up for a single page microsite that you can modify.

Open `_layouts/index.html` to edit the structure of the homepage.

Below is a list of what each variable displays and how to edit them:
`{{ site.title }}` comes from the `title` object in `_config.yml`

`{{ page.title }}` comes from the `index.md` title

`{{ content }}` comes from the body of `index.md`

`index` is the default layout for all pages created through jekyll.

#### Includes
Jekyll allows you to inject HTML into your content with pre-made html snippets. There are several includes that come with this template:

*ga-event.html*  
GA Event is a include to simply enter Google Analytics click events. Below is an example include:
`{% include ga-event.html category='Social Share' action='Click' label='Twitter' %}`

`category`: string
`click`: string
`label`: string

*head.html*
The head element that is on every page. You can add additional scripts and fonts here. Most of the config variables feed into here.

### SCSS

All files in `scss` get prefixed for broswer compatibility and minified into the `css` directory. 

The base styles can be found in `_sass/_base.scss`.

Settings for colors, fonts, transition duration, and more can be found in `_vars.scss`.

Locally loaded fonts can be imported via the `_fonts.scss` sheet. 

All underscored scss sheets are includes in style.scss

#### PureCSS
[PureCSS](https://purecss.io/) is the default library for this template. Some helpful tools from PureCSS are [buttons](https://purecss.io/buttons/) and [grids](https://purecss.io/grids/). Styles for the grids can be found in `scss/_pure-grid.scss`.

Responsive grids are configured with the breakpoints set in `_vars.scss`. 

#### Mixins

**Breakpoints**  
Mixins for breakpoints can be used for quick mobile styling:
`@include bp-x-large`
`@include bp-large`
`@include bp-medium`
`@include bp-small`

Each of the breakpoints max-widths can be adjusted through the `$size-` variables on `_vars.scss`.

**Box Shadow**  
Use `@include box-shadow`for a preset box shadow. You can also customize it: `@include box-shadow(0px 5px 10px #333)`

**Headings**  
Use `@include headings` to apply styles for heading tags (eg `<h1>`).

**Transitions**  
Use `@include transition(all)` to add a `transition: all $transition_duration ease` property with browser prefixes. The `$transition_duration` variable can be modified at the top of `_vars_.scss`

For other transitions properties, just add them as comma separated parameters in the include: `@include transition(opacity,color)`.

#### Loading CSS per page or layout

To reduce CSS load times you can add single CSS sheets per page or layout. Add `css:` front matter with the sheet name (no path or extension) to your page or layout to load it. For example, `css: home` would load the CSS for `scss/home.scss` to the home page. For each sheet you add, you need to add the following to the top of the custom sheet: 
```
@import "vars.scss";
@import "mixins.scss";
```
After that, you can use the mixins and vars from the respective sheets as you please. 

### JS

jQuery is loaded before the body tag for all pages using the default template. 

Add javascript files to the `js` directory and grunt will output uglified files to the `js/min` directory.

When you want to add js to a specific page or layout just add `scripts:` to the front matter of the page or layout and add each filename, not path or extension, as a list item beneath. Example:
```
scripts:
- site_functions
```
This will load `<script src="/min/js/site_functions.min.js"></script>` before the body tag ends and below the jQuery script.

### Images

Add images to the `img` directory and grunt will output the overwrite images to the same directory.

### Layouts

`default.html` will add the basic HTML structure and the `head.html` include necessary for all pages and layouts. Add `layout: default` to either your page or custom layout. 

`compress.html` is the HTML compressor. Jekyll doesn't have a HTML compressor so this is applied to the `default.html` layout so it will compress all HTML. It doesn't need to be added to any pages or custom layouts since it's applied to default and everything will inherit it. 
