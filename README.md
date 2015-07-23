# App Prototype

_Write a brief overview of the app here._

Primary developers:

* _Your name here_

## Development

### First-time setup

To install the required gems & prepare the database:

```
bin/setup
```

Run `rake db:sample_data` to load a small set of data for development. See
`db/sample_data.rb` for details.

### Running the Application Locally

```
foreman start -f Procfile.dev
open http://localhost:3000
```

### Running the Specs

To run all ruby and javascript specs:

```
rake
```

Again, with coverage for the ruby specs:

```
rake spec:coverage
```

### Using Guard

Guard is configured to run ruby and jasmine specs, and also listen for
livereload connections. Growl is used for notifications.

```
guard
```

### Assets

Assets live outside the standard sprockets-based asset pipeline. We’re using webpack to (almost) entirely replace the asset pipeline, though it works in a similar way to the asset pipeline in practice: we’re not creating fancy bundles, just normal static JavaScript and CSS.

Assets live in `./assets/targets`. Creating a folder there will create a named target that matches. This:

```
./assets/targets/public —> public.js, public.css
```

To add a new target, you can use the `asset_target` generator:

```
rails generate asset_target target-name
```

This would generate the following files:

```
./assets/targets
  /target-name
    - target.js        # Configuration file, sets up our target output
    - index.css        # Base CSS file, where your CSS originates from
    - index.js         # Base JS file, where your JS originates from
```

Asset tasks are run using npm. They’re listed in the `package.json` in the `scripts` block. The main scripts are:

```
npm run start
```

This will spin up the webpack development-server. In development we send all asset requests through this server by setting a custom `asset_host` in `development.rb`. The webpack development-server will attempt to proxy any requests it cannot fill back to the Rails apps, so any normal asset-pipeline requests should work.

```
npm run build
```

This will build a development version of the webpack assets into `./assets/build` so you can inspect them.

#### JavaScript

Dependencies are managed through [npm](http://npmjs.com). To add a dependency you’ll want to:

```
npm install --save my-new-dependency
```

This will add the dependency to the `package.json` (née `Gemfile`) in the root directory. If you do not include `--save` then your dependency will not be installed on deployment.

**Note**: We’re building assets on the fly for deployment and so any compilation process will need both the `devDependencies` and the `dependencies` hash in `package.json` to be installed. On Heroku this means [you’ll need to set a config variable](https://github.com/heroku/heroku-buildpack-nodejs#enable-or-disable-devdependencies-installation):

```
heroku config:set NPM_CONFIG_PRODUCTION=false
```

JavaScript is loaded using the CommonJS module pattern — the same as npm — which means each file is encapsulated (much like CoffeeScript). This also means *there is no shared scope*; each file must require dependencies to have access to them. This is done by calling `require("dependency-name")`.

CommonJS modules _should_ export a default object that gets returned as the value of a `require`. For example, if you want to use jQuery in one of your files you’ll need to explicitly require it like this (assuming you have it included in your `package.json`):

```js
var $ = require("jquery");
```

Local dependencies should follow the same pattern:

```js
// ./foo/index.js
var privateVariable = "foo";
function Foo() {
  console.log(privateVariable);
}
module.exports = Foo;

// ./index.js
var Foo = require("./foo"); // Will look for index.js automatically
var fooInstance = new Foo();
```

#### Debugging

We inject a special constant into the JavaScript environment at build time: `DEVELOPMENT`. This is a boolean that allows you to add *persistent* code you’d only like to run in development:

```js
if (DEVELOPMENT) {
  console.warn(obj.property);
}
```

^ This will `warn` in development, and *won’t even been compiled* into the production build.

### Environment Variables

Several common features and operational parameters can be set using
environment variables.

**Required**

* `SECRET_KEY_BASE` - Secret key base for verfying signed cookies. Should be
  30+ random characters and secret!

**Optional**

* `ASSETS_AWS_REGION`, `ASSETS_AWS_BUCKET`, `ASSETS_AWS_ACCESS_KEY_ID`,
  `ASSETS_AWS_SECRET_ACCESS_KEY` - S3 configuration for syncing Rails asset
  pipeline files when deploying/precompiling.
* `BASIC_AUTH_PASSWORD` - Enable basic auth with this password.
* `BASIC_AUTH_USER` - Set a basic auth username (not required, the password alone enables basic auth).
* `BUGSNAG_API_KEY` - API key for tracking errors with Bugsnag.
* `HOSTNAME` - Canonical hostname for this application. Other incoming
  requests will be redirected to this hostname.
* `SELENIUM` - enables the selenium driver for javascript-enabled tests. Allows developers to use `binding.pry` in any rspec example to pause and interact with the test.
* `UNICORN_WORKERS` - Number of unicorn workers to spawn (default: development
  1, otherwise 3).
* `UNICORN_BACKLOG` - Depth of unicorn backlog (default: 16).
* `ASSETS_DEVELOPMENT_HOST` — (default: "localhost")
* `ASSETS_DEVELOPMENT_PORT` — (default: "1234")
* `ASSETS_WEBPACK_PORT` — (default: "8080")
* `ASSETS_PROXY_URL` — (default: "http://localhost:3000")
* `DISABLE_ASSETS_NOTIFIER` – Disables notifications (through OSX’s Notification Center) about asset build (default: false)

## Deployment

### Assets

Our asset setup requires a node environment during deploy on Heroku, so we need to use [the heroku-buildpack-multi](https://github.com/ddollar/heroku-buildpack-multi) to allow us to have multiple buildpacks for a single app. The additional buildpacks are listed in `.buildpacks`:

```
heroku buildpacks:set https://github.com/ddollar/heroku-buildpack-multi.git
```

Assets are built on-deploy through webpack and then combined with any asset pipeline assets to form a _single_ rails-compatible manifest in `./public/assets` — which is why we're only "almost" avoiding the asset pipeline. This is done by hijacking `rake assets:precompile` in `./lib/tasks/assets.rake`.

This structure means you can actually combine normal asset pipeline assets with our webpack built ones if you want to. As long as there are no naming collisions everything should work just fine.

As mentioned above, you’ll likely need to set the `NPM_CONFIG_PRODUCTION` value to get the compilation working correctly on Heroku:

```
heroku config:set NPM_CONFIG_PRODUCTION=false
```
