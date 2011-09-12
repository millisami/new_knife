require File.join(File.dirname(__FILE__), 'version')
require File.join(File.dirname(__FILE__), 'helpers')
require 'mail'
module NewKnife
  class App < Sinatra::Base
    #helpers NewKnife::SinatraBaseHelpers
    helpers NewKnife::NewKnifeHelpers
    
    configure do
      set :app_file, __FILE__
      set :root, File.expand_path(File.join(File.dirname(__FILE__), "..", ".."))
      set :server, %w[thin mongrel webrick]
      set :logging, true
      set :raise_errors, true
      set :show_exceptions, true
      set :run, true
    end

      load File.join(File.dirname(__FILE__), 'routes/new_knife.rb')

  end #App
end # Module NewKnife
