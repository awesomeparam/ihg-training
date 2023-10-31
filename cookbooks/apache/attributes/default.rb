if platform?('ubuntu', 'redhat')
  default['apache']['package_name'] = 'apache2'
  default['apache']['service_name'] = 'apache2'
  default['apache']['conf_dir'] = '/etc/apache2/sites-enabled'
  default['apache']['site_name'] = '000-default'
  default['apache']['service_resource'] = 'service[apache2]'
else
  default['apache']['package_name'] = 'httpd'
  default['apache']['service_name'] = 'httpd'
  default['apache']['conf_dir'] = '/etc/httpd/conf.d'
  default['apache']['site_name'] = 'Welcome'
  default['apache']['service_resource'] = 'service[httpd]'
end

default['apache']['file_name'] = '/var/www/html/index.html'
