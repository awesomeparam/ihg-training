# To learn more about Custom Resources, see https://docs.chef.io/custom_resources/

property :site_name, String, name_attribute: true
property :site_port, Integer, default:80

unified_mode true

default_action :create

action :create do
  directory "/srv/apache/#{new_resource.site_name}/html" do
    recursive true
    mode '0755'
  end
  #directory "/etc/apache2/sitesenabled/html" do
  #  owner 'root'
  #  group 'root'
  #  recursive true
  #  mode '0755'
  #end
  template "#{node['apache']['conf_dir']}/#{new_resource.site_name}.conf" do
    source 'conf.erb'
    mode '0644'
    variables(document_root: "/srv/apache/#{new_resource.site_name}/html", port: new_resource.site_port)
    #notifies :restart, 'service '#{node['apache']['service_name']}
    #notifies :restart, "service[#{node['apache']['service_name']}]"
  end
  file "/srv/apache/#{new_resource.site_name}/html/index.html" do
    content "<h1>Welcome #{new_resource.site_name}!</h1>"
  end
end

action :remove do
  directory "/srv/apache/#{new_resource.site_name}" do
    action :delete
    recursive true
  end

  file "#{node['apache']['conf_dir']}/#{new_resource.site_name}.conf" do
    action :delete
  end
end
