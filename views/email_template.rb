Dear <%= name %>

If you are receiving this email, you have been entrusted to edit/change/delete values in our configuration management system

Attached are your knife credentials for CLI access to Chef.

NOTE - These directions only apply if you want to use knife on chef.
For those on Linux/Mac you can actually setup knife access via your workstation without having the need to
go through chef.  The steps are basically the same as below, just change directory structure to match your 
workstation. You can always install chef via rubygems on your workstation "gem install chef"

Please follow the directions below

1. scp <%= name %>.pem <%= name %>@chef.corp.com:~/
2. ssh to chef.corp.com
3. mkdir .chef/
4. mv <%= name %>.pem .chef/
5. cd .chef/
6. Use your favorite editor and open a new file called knife.rb  e.g. vi knife.rb
7. Fill in the following data and then save the file:
  log_level                :info
  log_location             STDOUT
  node_name                '<%= name %>'
  client_key               '/home/<%= name %>/.chef/<%= name %>.pem'
  chef_server_url          'http://chef.corp.com:4000'
  cache_type               'BasicFile'
  cache_options( :path => '/home/<%= name %>/.chef/checksums' )

At this point you should have the following:
/home/<%= name %>/.chef/knife.rb
/home/<%= name %>/.chef/<%= name %>.pem


8. Next cd /home/<%= name %>
9. vi .bash_profile
10. add the following line to .bash_profile
   export EDITOR=<your editor>  e.g. export EDITOR=vim

9. To test and make sure everything works use 'knife node list' (without quotes),
   you should see a list of servers that are currently in chef

Please Note that this only gets your access to the chef server and not the git repository where the cookbook
sourcecode is stored.  

Please save this email for future reference.

Sincerely,
The swedish chef
