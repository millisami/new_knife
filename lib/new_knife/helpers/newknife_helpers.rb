module NewKnife
  module NewKnifeHelpers
  require 'ostruct'
  require 'find'
   
   # This was specific to where I worked.  And can probably be modified to suit your environment
   def self.make_tp_name(name)
     name = name.downcase.split.join(".")
   end

   def self.validate_name(name)
      clients = get_client_files
      name = make_tp_name(name)
      return true unless clients.grep("#{name}.pem").empty? == false or name.split(".").count != 2
   end

   def self.gen_knife(params)
       name = make_tp_name(params["name"])
       admin = params["admin"] 
       email = params["email"]
       cert = "#{NewKnife::CLIENT_DIR}/#{name}.pem"
       prefix="knife client create -s #{NewKnife::CHEF_SERVER} -f #{cert} -y -n #{name} "
       if admin
         command= prefix + "-a"
       else
         command = prefix
       end
       system("#{command}")
       send_email(name, email, cert)
   end

   def self.get_client_files
    @clients = []
    Dir.entries(NewKnife::CLIENT_DIR).each do |file|
     @clients << file unless file =~ /^\.\.?$/
    end
    return @clients.sort
   end

   def self.send_email(name, email, attachment)
     template = File.open(File.join(File.dirname(__FILE__), '..', "..", "..", 'views/email_template.rb'))
     email_vars = OpenStruct.new :name => name
     email_message = ERB.new(template.read).result(email_vars.send(:binding))
     mail = Mail.new do
      from 'your_email@yourdomain.com'
      to "#{email}"
      subject "Chef Knife access for #{name}"
      body email_message
      add_file :filename => "#{name}.pem", :content => File.read(attachment) 
     end
    mail.deliver!
   end

  end
end
