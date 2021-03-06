include_recipe "nginx::source"

conf_name = "#{node[:application][:name]}.conf"

# main site config which goes to the sites-available/ dir
template "#{node[:nginx][:dir]}/sites-available/#{conf_name}" do
  source "nginx.site.conf.erb"
  notifies :reload, resources(:service => "nginx")
end

# include file which included in main site config 
# (in order to use same configuration for multiple servers: http and https for example)
template "#{node[:nginx][:dir]}/sites-available/conf.d/#{node[:application][:name]}.include.conf" do
  source "nginx.site.include.conf.erb"
  notifies :reload, resources(:service => "nginx")
end

nginx_site conf_name

if node[:application][:http_auth]
  package "apache2-utils"
  
  htpasswd "#{node[:nginx][:dir]}/htpasswd" do
    user      node[:application][:http_auth][:user]
    password  node[:application][:http_auth][:password]
  end
end
