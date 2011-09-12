class NewKnife::App
require 'pp'

  get '/new_knife' do
    @clients = NewKnife::NewKnifeHelpers.get_client_files
    erb :index, :locales => {:clients => @clients, :title => "Client Listing"}
  end

  get '/new_knife/new' do
    erb :new_client, :locals => {:title => "New Client"}
  end

  post '/new_knife/gen_knife' do
      if (!NewKnife::NewKnifeHelpers.validate_name(params["name"]) == true )
	halt "Name must be in FIRST LAST format,  and must not already exist on the system. Please try again"
      else
	NewKnife::NewKnifeHelpers.gen_knife(params)
      end
	redirect to('/new_knife')
  end

end
