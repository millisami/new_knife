module NewKnife
  require 'erb'
  require 'sinatra/base'
  
  require File.join(File.dirname(__FILE__), 'new_knife', 'app')

  CLIENT_DIR=File.join(File.dirname(__FILE__), '..', 'clients')
  CHEF_SERVER="http://chef.corp.com:4000"
  
end

