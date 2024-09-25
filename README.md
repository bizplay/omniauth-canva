# OmniAuth Canva OAuth2 Strategy

This Canva OAuth2 Strategy for OmniAuth can be used to get a token for the Canva API. It uses OAuth 2.0 with the Authorization Code flow with Proof Key for Code Exchange (PKCE) using SHA-256.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth'
gem 'omniauth-oauth2'
gem 'omniauth-canva', git: 'https://github.com/bizplay/omniauth-canva.git'
```

And then execute:

    $ bundle

Or install it yourself as:

```shell
$ git clone https://github.com/bizplay/omniauth-canva.git
$ cd omniauth-canva
$ gem build omniauth-canva.gemspec
$ gem install omniauth-canva-version.gem
```

## Usage
The base usage looks like this:
```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :canva, ENV['CANVA_CLIENT_ID'], ENV['CANVA_SECRET']
end
```

Here's an example where we request permissions to read a user's profile and folders and 
export their designs:
```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :canva, ENV['CANVA_CLIENT_ID'], ENV['CANVA_SECRET'], scope: 'design:content:read folder:read profile:read'
end
```

Remember to configure the right callback URI in Canva. The path to use is: `/auth/canva/callback`. Thus a full callback URL will be something like `https://example.com/auth/canva/callback`
