# W3C Validators Gem README
[![Build Status](https://travis-ci.org/w3c-validators/w3c_validators.svg?branch=master)](https://travis-ci.org/w3c-validators/w3c_validators)

W3C Validators is a Ruby wrapper for the World Wide Web Consortium's online 
validation services.

It supports the nu validator, the feed validator and the CSS validator.

### Installation

```bash
  gem install w3c_validators
```

### Usage

There are three main validator classes available, the `W3CValidators::NuValidator`
(used for HTML), the `W3CValidators::FeedValidator` and the `W3CValidators::CSSValidator`.

**Warning**: The `W3CValidators::MarkupValidator` also exist but is not anymore the preferred
way to check HTML document. Indeed, it is working fine for non-HTML5 documents,
but it is broken when you test an HTML5 document due to W3C redirection. `W3CValidators::NuValidator`
should be used instead for standard cases.

Each validator has offers three different validation methods.

* `validate_text` methods take a string
* `validate_file` methods take a path to a file or an IO object
* `validate_uri` methods take a published URL

In addition, the `W3CValidators::MarkupValidator` has a `validate_uri_quickly` method, which 
performs a HEAD request against the markup validation service. The Results 
of this call give an error count but no error details.

#### Using a local validator

Each of the three validators allows you to specify a custom path to the 
validator.  You can set your own validator like this:

```ruby
  validator = NuValidator.new(:validator_uri => 'http://localhost/check')
```

#### Using a proxy server

You can use a proxy server by passing in its information in the contructor.

```ruby
  validator = NuValidator.new(:proxy_host => 'proxy.example.com',
                              :proxy_port => 80,
                              :proxy_user => 'optional',
                              :proxy_pass => 'optional')
```

### Examples

#### Example #1: Nu validator, local file

```ruby
  require 'w3c_validators'
  
  include W3CValidators

  @validator = NuValidator.new
  
  file = File.dirname(__FILE__) + '/fixtures/valid_html5.html'
  results = @validator.validate_file(fp)

  if results.errors.length > 0
    results.errors.each do |err|
      puts err.to_s
    end
  else
    puts 'Valid!'
  end
```


#### Example #2: Feed validator, remote file

```ruby
  require 'w3c_validators'
  
  include W3CValidators

  @validator = FeedValidator.new

  results = @validator.validate_uri('http://example.com/feed.xml')

  if results.errors.length > 0
    results.errors.each do |err|
      puts err.to_s
    end
  else
    puts 'Valid!'
  end
```

#### Example #3: CSS validator, text fragment

```ruby
  require 'w3c_validators'
  
  include W3CValidators

  @validator = CSSValidator.new

  results = @validator.validate_text('body { margin: 0px; }')

  if results.errors.length > 0
    results.errors.each do |err|
      puts err.to_s
    end
  else
    puts 'Valid!'
  end
```

#### Example #4: Markup validator, local file

```ruby
  require 'w3c_validators'
  
  include W3CValidators

  @validator = MarkupValidator.new
  
  # override the DOCTYPE
  @validator.set_doctype!(:html32)
  
  # turn on debugging messages
  @validator.set_debug!(true)

  file = File.dirname(__FILE__) + '/fixtures/markup.html'
  results = @validator.validate_file(fp)

  if results.errors.length > 0
    results.errors.each do |err|
      puts err.to_s
    end
  else
    puts 'Valid!'
  end
  
  puts 'Debugging messages'
  
  results.debug_messages.each do |key, value|
    puts "#{key}: #{value}"
  end
```

### Examples with Ruby Frameworks

```
# you can easily incorporate this in your ruby based frameworks:

# Gemfile
group :test do
    gem 'w3c_validators'
end

# And in your relevant test file:

require 'w3c_validators'

class FoosControllerTest < ActionDispatch::IntegrationTest
  setup do  
    @validator = W3CValidators::NuValidator.new
  end
  
  test "index" do
    get foos_url
    assert_equal 0, @validator.validate_text(response.body).errors.length
  end
end

# granted it's not perfect, but hopefully that will at least get you going
# you might want to customise things so that it delivers a particular output in case an error shows up.
```

### Tests

Run unit tests using <tt>rake test</tt>.  Note that there is a one second delay 
between each call to the W3C's validators per their request.


### Credits and code

Source is available on [GitHub](https://github.com/w3c-validators/w3c_validators)

Written by Alex Dunae ([dunae.ca](http://dunae.ca/), e-mail 'code' at the same domain), 2007.

Thanks to [Ryan King](http://theryanking.com/) for creating the 0.9.2 update.

Thanks to [Ryan King](http://theryanking.com/), [Jonathan Julian](http://jonathanjulian.org/) and Sylvain LaFleur for creating the 0.9.3 update.

Thanks to [James Rosen](http://github.com/jamesarosen) and [Roman Shterenzon](http://github.com/romanbsd) for creating the 1.0.1 update.
