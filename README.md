# betaface
Betaface is the unofficial ruby Gem for the Betaface API. You can find all needed documentation about the official API at [Betaface docs](https://betafaceapi.com/wpa/index.php/documentation)

## Installation
To install using [Bundler][bundler] grab the latest stable version:

```ruby
gem 'betaface'
```

To manually install `betaface` via [Rubygems][rubygems] simply gem install:

```bash
gem install betaface
```


## Configuration

### Put your own credentials here
``` ruby
require 'betaface'
Betaface.key = "d45fd466-51e2-4701-8da8-04351c872236"
Betaface.secret = "171e8465-f548-401d-b63b-caf0dc28df5f"
```

### alternatively, you can preconfigure the client like so
``` ruby
require 'betaface'
api = Betaface::Api.new("d45fd466-51e2-4701-8da8-04351c872236","171e8465-f548-401d-b63b-caf0dc28df5f")
```

## Upload a picture

```ruby
api = Betaface::Api.new
api.upload_image("propoints,classifiers",{url:"http://img.wennermedia.com/480-width/1444256733_tom-cruise-zoom.jpg"})
```

## Get image info

```ruby
api = Betaface::Api.new
api.get_image_info("2bdcd1ad-47a6-45f8-ba74-86c765272422")
```

## Supported Ruby Versions

This library supports and is test for the following Ruby
implementations:

- Ruby 2.2.0
- Ruby 2.1.0
- Ruby 2.0.0
- Ruby 1.9.3
- [JRuby][jruby]
- [Rubinius][rubinius]

## More Information

There are more detailed examples in the included [examples][examples]

[bundler]: http://bundler.io
[rubygems]: http://rubygems.org
[examples]: https://github.com/jrm2194/betaface/tree/master/examples
[jruby]: http://www.jruby.org
[rubinius]: http://rubini.us

## License

(The MIT License.)
