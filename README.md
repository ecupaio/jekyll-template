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

## Development

Select the Use this Template button at the top of the page, label your new repo, then select 

Pull to local then locate your repo and run:

`cd <your-repo>`

Now install Jekyll using Bundle:

`bundle`

You should messages about packages being installed, ending with something like: "Bundle complete! 6 Gemfile dependencies, 33 gems now installed."

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

`ga`  
The Google Analytics ID for your site

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
Jekyll allows you to inject HTML into your content with premade html snippets. There are several includes that come with this template:

*base.html*  
Base is a helpful include from [Rico Sta. Cruz](https://ricostacruz.com/til/relative-paths-in-jekyll) that helps create relative paths that work in github pages as well as local development. It's used for the internal JS and CSS files sources for the index.html. use `{{ base }}` as a prefix to get to the root. Ex: `{{ base }}/css/style.css`

`layout`:
* `links` (default if not specified)
* `buttons`  

`tweet`: string

`url`: url (http://example.com)

*ga-event.html*  
GA Event is a include to simply enter Google Analytics click events. Below is an example include:
`{% include ga-event.html category='Social Share' label='Twitter' %}`

`category`: string
`label`: string

### SASS

Open `_sass/_custom.scss` and start adding your custom styles. At the top of the sheet there are several preset styles, mainly colors, for you to adjust. The brand colors are displayed at the top so you know what options you have. There are also preset breakpoints and padding for the three sections: header, main, and footer.

The base styles can be found in `_sass/_base.scss`.

#### PureCSS
[PureCSS](https://purecss.io/) is the default library for this template. Some helpful tools from PureCSS are [buttons](https://purecss.io/buttons/) and [grids](https://purecss.io/grids/). Gutters have been added between the grid columns for layout purposes and can be adjusted through the `$grid-gutters` variable on `_sass/_custom.scss`.

Responsive grids are configured with the breakpoints mixin so do not worry about

#### Mixins

**Breakpoints**  
Mixins for breakpoints can be used for quick mobile styling:
`@include bp-large`
`@include bp-medium`
`@include bp-small`

Each of the breakpoints max-widths can be adjusted through the `$size-` variables on `custom.scss`.

**Flexbox**  
Use `@include flexbox` for instant flexbox with all the browser prefixes.

**Box Shadow**  
Use `@include box-shadow`for an elegant shaddow on divs and the like.

**Headings**  
Use `@include headings` to apply styles for heading tags (eg `<h1>`).

**Transitions**  
Use `@include transition(all)` to add a `transition: all $transition_duration ease` property with browser prefixes. The `$transition_duration` variable can be modified at the top of `custom.scss`

For other transitions properties, just add them as comma separated parameters in the include: `@include transition(opacity,color)`.

**Transforms**  
Use `@include transform(VALUES)` to apply a transform with browser prefixes. For example, use `@include transform(translateX(100%))` to apply a translateX to your property.

### JS

Add javascript files to the `js` directory and grunt will output uglified files to the `js/min` directory.

### Images

Add images to the `images` directory and grunt will output the minified images to the `min_images` directory so you can have a backup of original images.
