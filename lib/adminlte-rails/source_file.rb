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

    # Fetch fonts
    fetch_fonts(remote, tag)

    # Fetch stylesheets
    fetch_stylesheets(remote, tag)

    # Fetch images
    fetch_images(remote, tag)

  end

  desc 'convert css to use rails paths', 'make css use rails paths'

  def convert
    self.destination_root = 'vendor/assets'
    inside destination_root do
      #gsub_file 'stylesheets/bootstrap.scss', %r/url\(([^\)]*)\)/, 'image-url(\1)'
      gsub_file 'stylesheets/bootstrap.scss', %r/url\('(\.\.\/fonts\/)([^\)]*)'\)/, 'url(font-path(\'\2\'))'
      gsub_file 'stylesheets/font-awesome.scss', %r/url\('(\.\.\/fonts\/)([^\)]*)'\)/, 'url(font-path(\'\2\'))'
      gsub_file 'stylesheets/ionicons.scss', %r/url\("(\.\.\/fonts\/)([^\)]*)"\)/, 'url(font-path(\'\2\'))'
    end
  end

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
    js_path = "#{remote}/raw/#{tag}/js"
    get "#{js_path}/bootstrap.min.js", 'javascripts/bootstrap.min.js'
    get "#{js_path}/AdminLTE/app.js", 'javascripts/admin-lte.js'
  end

  def fetch_fonts(remote, tag)
    fonts_path = "#{remote}/raw/#{tag}/fonts"
    get "#{fonts_path}/FontAwesome.otf", 'fonts/FontAwesome.otf'
    get "#{fonts_path}/fontawesome-webfont.eot", 'fonts/fontawesome-webfont.eot'
    get "#{fonts_path}/fontawesome-webfont.svg", 'fonts/fontawesome-webfont.svg'
    get "#{fonts_path}/fontawesome-webfont.ttf", 'fonts/fontawesome-webfont.ttf'
    get "#{fonts_path}/fontawesome-webfont.woff", 'fonts/fontawesome-webfont.woff'
    get "#{fonts_path}/glyphicons-halflings-regular.eot", 'fonts/glyphicons-halflings-regular.eot'
    get "#{fonts_path}/glyphicons-halflings-regular.svg", 'fonts/glyphicons-halflings-regular.svg'
    get "#{fonts_path}/glyphicons-halflings-regular.ttf", 'fonts/glyphicons-halflings-regular.ttf'
    get "#{fonts_path}/glyphicons-halflings-regular.woff", 'fonts/glyphicons-halflings-regular.woff'
    get "#{fonts_path}/ionicons.eot", 'fonts/ionicons.eot'
    get "#{fonts_path}/ionicons.svg", 'fonts/ionicons.svg'
    get "#{fonts_path}/ionicons.ttf", 'fonts/ionicons.ttf'
    get "#{fonts_path}/ionicons.woff", 'fonts/ionicons.woff'
  end

  def fetch_images(remote, tag)
    images_path = "#{remote}/raw/#{tag}/img"
    get "#{images_path}/avatar.png", 'images/avatar.png'
    get "#{images_path}/avatar2.png", 'images/avatar2.png'
    get "#{images_path}/avatar3.png", 'images/avatar3.png'
  end

  def fetch_stylesheets(remote, tag)
    # Get Css files
    css_path = "#{remote}/raw/#{tag}/css"
    get "#{css_path}/bootstrap.css", 'stylesheets/bootstrap.scss'
    get "#{css_path}/AdminLTE.css", 'stylesheets/admin-lte.css'
    get "#{css_path}/ionicons.css", 'stylesheets/ionicons.scss'
    get "#{css_path}/font-awesome.css", 'stylesheets/font-awesome.scss'

    # Get DataTables assets
    get "#{css_path}/datatables/images/sort_asc.png", 'stylesheets/datatables/images/sort_asc.png'
    get "#{css_path}/datatables/images/sort_asc_disabled.png", 'stylesheets/datatables/images/sort_asc_disabled.png'
    get "#{css_path}/datatables/images/sort_both.png", 'stylesheets/datatables/images/sort_both.png'
    get "#{css_path}/datatables/images/sort_desc.png", 'stylesheets/datatables/images/sort_desc.png'
    get "#{css_path}/datatables/images/sort_desc_disabled.png", 'stylesheets/datatables/images/sort_desc_disabled.png'
    get "#{css_path}/datatables/dataTables.bootstrap.css", 'stylesheets/datatables/dataTables.bootstrap.css'

    # Get iCheck assets
    icheck_path = "#{css_path}/iCheck"
    get "#{icheck_path}/all.css", 'stylesheets/iCheck/all.scss'
    get "#{icheck_path}/flat/_all.css", 'stylesheets/iCheck/flat/_all.css'
    get "#{icheck_path}/flat/aero.css", 'stylesheets/iCheck/flat/aero.css'
    get "#{icheck_path}/flat/aero.png", 'stylesheets/iCheck/flat/aero.png'
    get "#{icheck_path}/flat/aero@2x.png", 'stylesheets/iCheck/flat/aero@2x.png'
    get "#{icheck_path}/flat/blue.css", 'stylesheets/iCheck/flat/blue.css'
    get "#{icheck_path}/flat/blue.png", 'stylesheets/iCheck/flat/blue.png'
    get "#{icheck_path}/flat/blue@2x.png", 'stylesheets/iCheck/flat/blue@2x.png'
    get "#{icheck_path}/flat/flat.css", 'stylesheets/iCheck/flat/flat.css'
    get "#{icheck_path}/flat/flat.png", 'stylesheets/iCheck/flat/flat.png'
    get "#{icheck_path}/flat/flat@2x.png", 'stylesheets/iCheck/flat/flat@2x.png'
    get "#{icheck_path}/flat/green.css", 'stylesheets/iCheck/flat/green.css'
    get "#{icheck_path}/flat/green.png", 'stylesheets/iCheck/flat/green.png'
    get "#{icheck_path}/flat/green@2x.png", 'stylesheets/iCheck/flat/green@2x.png'
    get "#{icheck_path}/flat/grey.css", 'stylesheets/iCheck/flat/grey.css'
    get "#{icheck_path}/flat/grey.png", 'stylesheets/iCheck/flat/grey.png'
    get "#{icheck_path}/flat/grey@2x.png", 'stylesheets/iCheck/flat/grey@2x.png'
    get "#{icheck_path}/flat/orange.css", 'stylesheets/iCheck/flat/orange.css'
    get "#{icheck_path}/flat/orange.png", 'stylesheets/iCheck/flat/orange.png'
    get "#{icheck_path}/flat/orange@2x.png", 'stylesheets/iCheck/flat/orange@2x.png'
    get "#{icheck_path}/flat/pink.css", 'stylesheets/iCheck/flat/pink.css'
    get "#{icheck_path}/flat/pink.png", 'stylesheets/iCheck/flat/pink.png'
    get "#{icheck_path}/flat/pink@2x.png", 'stylesheets/iCheck/flat/pink@2x.png'
    get "#{icheck_path}/flat/purple.css", 'stylesheets/iCheck/flat/purple.css'
    get "#{icheck_path}/flat/purple.png", 'stylesheets/iCheck/flat/purple.png'
    get "#{icheck_path}/flat/purple@2x.png", 'stylesheets/iCheck/flat/purple@2x.png'
    get "#{icheck_path}/flat/red.css", 'stylesheets/iCheck/flat/red.css'
    get "#{icheck_path}/flat/red.png", 'stylesheets/iCheck/flat/red.png'
    get "#{icheck_path}/flat/red@2x.png", 'stylesheets/iCheck/flat/red@2x.png'
    get "#{icheck_path}/flat/yellow.css", 'stylesheets/iCheck/flat/yellow.css'
    get "#{icheck_path}/flat/yellow.png", 'stylesheets/iCheck/flat/yellow.png'
    get "#{icheck_path}/flat/yellow@2x.png", 'stylesheets/iCheck/flat/yellow@2x.png'

  end
end