require 'thor'
require 'json'
require 'httpclient'
require 'byebug'
class SourceFile < Thor
  include Thor::Actions
  desc 'fetch source files', 'fetch source files from GitHub'

  def fetch
    filtered_tags = fetch_tags
    tag = select('Which tag do you want to fetch?', filtered_tags)
    self.destination_root = 'vendor/assets'
    remote = 'https://github.com/almasaeed2010/AdminLTE'
    get "#{remote}/raw/#{tag}/css/bootstrap.css", 'stylesheets/bootstrap.scss'
  end

  desc 'convert css to use rails paths', 'make css use rails paths'

  def convert
    self.destination_root = 'vendor/assets'
    inside destination_root do
      gsub_file 'stylesheets/bootstrap.scss', %r/url\(([^\)]*)\)/, 'image-url(\1)'
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
end