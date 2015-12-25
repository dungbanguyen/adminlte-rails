require 'thor'
require 'json'
require 'httpclient'
require 'byebug'
require 'fileutils'
class SourceFile < Thor
  include Thor::Actions

  desc 'clean up assets folders', ' delete fonts, stylesheets, javascripts, images'

  def cleanup
    FileUtils.rm_rf %w(vendor/assets/fonts vendor/assets/images vendor/assets/stylesheets vendor/assets/javascripts)
  end

  desc 'fetch source files', 'fetch source files from GitHub'

  def fetch
    filtered_tags = fetch_tags
    tag = select('Which tag do you want to fetch?', filtered_tags)
    self.destination_root = 'vendor/assets'
    remote = 'https://github.com/almasaeed2010/AdminLTE'

    # Fetch javascripts
    fetch_javascripts(remote, tag)

    # Fetch stylesheets
    fetch_stylesheets(remote, tag)

    # Fetch images
    fetch_images(remote, tag)

  end

  desc 'convert css to use rails paths', 'make css use rails paths'

  private
  def fetch_tags
    http = HTTPClient.new
    response = JSON.parse(http.get('https://api.github.com/repos/almasaeed2010/AdminLTE/tags').body)
    response.map { |tag| tag['name'] }.sort
  end

  def select(msg, elements)
    elements.each_with_index do |element, index|
      say(block_given? ? yield(element, index + 1) : ("#{index + 1}. #{element.to_s}"))
    end
    result = ask(msg).to_i
    elements[result - 1]
  end

  def fetch_javascripts(remote, tag)
    js_path = "#{remote}/raw/#{tag}/dist/js"
    
    get "#{js_path}/app.js", 'javascripts/admin-lte.js'
    plugins_path = "#{remote}/raw/#{tag}/plugins"
    get "#{plugins_path}/daterangepicker/daterangepicker.js", 'javascripts/daterangepicker.js'
    get "#{plugins_path}/timepicker/bootstrap-timepicker.js", 'javascripts/bootstrap-timepicker.js'
    get "#{plugins_path}/bootstrap-slider/bootstrap-slider.js", 'javascripts/bootstrap-slider.js'
  end

  def fetch_images(remote, tag)
    images_path = "#{remote}/raw/#{tag}/dist/img"
    get "#{images_path}/avatar.png", 'images/avatar.png'
    get "#{images_path}/avatar2.png", 'images/avatar2.png'
    get "#{images_path}/avatar3.png", 'images/avatar3.png'
  end

  def fetch_stylesheets(remote, tag)
    # Get Css files
    css_path = "#{remote}/raw/#{tag}/dist/css"

    get "#{css_path}/AdminLTE.css", 'stylesheets/admin-lte.css'
    get "#{css_path}/skins/skin-purple.css", 'stylesheets/skin-purple.css'
    get "#{css_path}/skins/skin-blue.css", 'stylesheets/skin-blue.css'
    
    # Get Plugins stylesheets
    plugins_path = "#{remote}/raw/#{tag}/plugins"    
    get "#{plugins_path}/bootstrap-slider/slider.css", 'stylesheets/bootstrap-slider.css'
    get "#{plugins_path}/daterangepicker/daterangepicker-bs3.css", 'stylesheets/daterangepicker.css'
    get "#{plugins_path}/timepicker/bootstrap-timepicker.css", 'stylesheets/bootstrap-timepicker.css'
  
    # Get DataTables assets
    # get "#{css_path}/datatables/images/sort_asc.png", 'stylesheets/datatables/images/sort_asc.png'
    # get "#{css_path}/datatables/images/sort_asc_disabled.png", 'stylesheets/datatables/images/sort_asc_disabled.png'
    # get "#{css_path}/datatables/images/sort_both.png", 'stylesheets/datatables/images/sort_both.png'
    # get "#{css_path}/datatables/images/sort_desc.png", 'stylesheets/datatables/images/sort_desc.png'
    # get "#{css_path}/datatables/images/sort_desc_disabled.png", 'stylesheets/datatables/images/sort_desc_disabled.png'
    # get "#{css_path}/datatables/dataTables.bootstrap.css", 'stylesheets/datatables/dataTables.bootstrap.css'
  end
end
