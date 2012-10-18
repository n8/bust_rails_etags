# Bust Rails Etags

Helps bust http caching on new deploys of a Rails app using the environment variable: 

ENV["ETAG_VERSION_ID"]

Rails has awesome http caching abilities. However, when you deploy a new version of your Rails app, there isn't a good way to have that http cache get busted. And so browsers end up carrying around an old version. 

One way of busting the cache is using: 

ENV["RAILS_CACHE_ID"] = release_version["name"]

But changing that environment variable on deploys also busts things like your action and fragment caches. That's a bit too destructive. 

So this gem creates a new environment variable you can use to bust only your http caches.              


## Installation

Add this line to your application's Gemfile:

    gem 'bust_rails_etags'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bust_rails_etags

## Usage

The goal of this gem is to provide an environment variable you can change that will bust all of your http caches for you app on deployments. 

The recommended way of doing that is to create an initializer file in your Rails app's config/initializers folder. You can call it bust_http_cache.rb

Your goal in that file is to set ENV["ETAG_VERSION_ID"] to something that will change on each Rails deployment. 

On Heroku I can use the release numbers. So in my bust_http_cache.rb I can do: 

```
require 'heroku-api'

heroku = Heroku::API.new(:api_key => "2304u34oisefiou34342k3mdsd")
release_version = heroku.get_releases('myappname').body.last

ENV["ETAG_VERSION_ID"] = release_version["name"]
```

Your process can be different depending on your deployment environment. What's important is that the deploy changes the value of ENV["ETAG_VERSION_ID"] across all nodes of your application, and that every node also has the same value of ENV["ETAG_VERSION_ID"]. So you probably wouldn't want to do something like this: 

```
ENV["ETAG_VERSION_ID"] = Time.now
```

Because that will cause different servers to have different values of ENV["ETAG_VERSION_ID"] if they were initialized at even slightly different times. 






## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
