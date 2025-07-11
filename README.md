# AdminLTE Rails gem

[![Join the chat at https://gitter.im/shine60vn/adminlte-rails](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/shine60vn/adminlte-rails?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

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

	//= require bootstrap.min
	//= require adminlte
	
### Include adminlte-rails stylesheet assets

Add the following to your `app/assets/stylesheets/application.css`:

	 *= require bootstrap
     *= require font-awesome
     *= require ionicons
     *= require adminlte
     
If you want to use additional features, add more these lines to your `app/assets/stylesheets/application.css`:

     *= require iCheck/all
     *= require datatables/dataTables.bootstrap
     
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
