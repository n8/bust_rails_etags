# Bust Rails Etags

Helps bust http caching on new deploys of a Rails app using the environment variable: 

```ruby
ENV["ETAG_VERSION_ID"]
````

You can see more explanation and history of the problem and this solution at my blog: 

[Rails Caching: A problem with etags and a solution](http://ninjasandrobots.com/rails-caching-a-problem-with-etags-and-a-solution)

Or here's a summary: 

Rails has awesome http caching abilities. However, when you deploy a new version of your Rails app, there isn't a good way to have that http cache get busted. And so browsers end up carrying around an old version. 

One way of busting the cache is using: 

```ruby
ENV["RAILS_CACHE_ID"] = release_version["name"]
```

But changing that environment variable on deploys also busts things like your action and fragment caches. That's a bit too destructive. 

So this gem creates a new environment variable you can use to bust only your http caches.              


## Installation

Add this line to your application's Gemfile:

```bash
$ gem 'bust_rails_etags'
```

And then execute:

```bash
$ bundle
````

Or install it yourself as:

```bash
$ gem install bust_rails_etags
`````

## Usage

The goal of this gem is to provide an environment variable you can change that will bust all of your http caches for you app on deployments. 

The recommended way of doing that is to create an initializer file in your Rails app's `config/initializers` folder. You can call it `bust_http_cache.rb`

Your goal in that file is to set `ENV["ETAG_VERSION_ID"]` to something that will change on each Rails deployment. 

On [Heroku](https://www.heroku.com) I can use the release numbers.

For security reasons, I create an environment variable called `API_KEY` for my heroku app via config.
It's also possible to add it with foreman via `.env` file.

```bash
$ heroku config:add API_KEY=2304u34oisefiou34342k3mdsd
```

So in my `bust_http_cache.rb` I can do: 

```ruby
require 'heroku-api'

heroku = Heroku::API.new(api_key: ENV['API_KEY'])
release_version = heroku.get_releases(ENV['APP_NAME']).body.last

ENV["ETAG_VERSION_ID"] = release_version["name"]
```

Your process can be different depending on your deployment environment. What's important is that the deploy changes the value of `ENV["ETAG_VERSION_ID"]` across all nodes of your application, and that every node also has the same value of `ENV["ETAG_VERSION_ID"]`. So you probably wouldn't want to do something like this: 

```ruby
ENV["ETAG_VERSION_ID"] = Time.now
```

Because that will cause different servers to have different values of `ENV["ETAG_VERSION_ID"]` if they were initialized at even slightly different times. 






## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
