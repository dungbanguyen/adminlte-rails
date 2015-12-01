# AdminLTE Rails gem

[AdminLTE](http://www.almsaeedstudio.com/) is a premium Bootstrap theme for backend.

The **AdminLTE Rails** gem integrates **AdminLTE** theme with the Rails asset pipeline.

## Installation

Add this line to your application's Gemfile:

    gem 'adminlte-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install adminlte-rails

## Usage

### Include adminlte-rails javascript assets

Add the following to your `app/assets/javascripts/application.js`:

	//= require admin-lte
	
### Include adminlte-rails stylesheet assets

Add the following to your `app/assets/stylesheets/application.css`:

  *= require admin-lte
     
### Note: 

Admin-lte depends upon bootstrap but does ship with it. So you need to include bootstrap and other libraries yourself. 

### If you want to use additional features, add those gem seperately:

  * iCheck
  * dataTables
     
## Version

2.3.2 (AdminLTE 2.3.2)

## Changelog

View [CHANGELOG](CHANGELOG.md)
    
## License

AdminLTE-Rails is released under the [MIT License](http://www.opensource.org/licenses/MIT).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/adminlte-rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
