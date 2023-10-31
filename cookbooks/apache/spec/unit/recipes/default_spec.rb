#
# Cookbook:: apache
# Spec:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'apache::default' do
  step_into :apache_vhost

  context 'When all attributes are default, on Ubuntu 20.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'ubuntu', '20.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs the apache2 package' do
      expect(chef_run).to install_package('apache2')
    end

    it 'starts the service' do
      expect(chef_run).to start_service('apache2')
    end

    it 'enables the service' do
      expect(chef_run).to enable_service('apache2')
    end

    it 'creates the index file' do
      expect(chef_run).to render_file('/srv/apache/users/html/index.html').with_content('<h1>Welcome users!</h1>')
    end

    it 'creates the index file' do
      expect(chef_run).to render_file('/srv/apache/admins/html/index.html').with_content('<h1>Welcome admins!</h1>')
    end

    it 'creates the conf directory' do
      expect(chef_run).to create_directory('/srv/apache/users/html')
    end

    it 'creates the conf directory' do
      expect(chef_run).to create_directory('/srv/apache/admins/html')
    end

    it 'creates the conf file' do
      expect(chef_run).to render_file('/etc/apache2/sites-enabled/users.conf')
    end

    it 'creates the conf file' do
      expect(chef_run).to render_file('/etc/apache2/sites-enabled/admins.conf')
    end
  end

  context 'When all attributes are default, on CentOS 7' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'centos', '7'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs the httpd package' do
      expect(chef_run).to install_package('httpd')
    end

    #    it 'creates the index file' do
    #      expect(chef_run).to render_file('/var/www/html/index.html').with_content('<h1>Welcome Home!</h1>')
    #    end

    it 'starts the service' do
      expect(chef_run).to start_service('httpd')
    end

    it 'enables the service' do
      expect(chef_run).to enable_service('httpd')
    end

    it 'creates the index file' do
      expect(chef_run).to render_file('/srv/apache/users/html/index.html').with_content('<h1>Welcome users!</h1>')
    end

    it 'creates the index file' do
      expect(chef_run).to render_file('/srv/apache/admins/html/index.html').with_content('<h1>Welcome admins!</h1>')
    end

    it 'creates the conf directory' do
      expect(chef_run).to create_directory('/srv/apache/users/html')
    end

    it 'creates the conf directory' do
      expect(chef_run).to create_directory('/srv/apache/admins/html')
    end

    it 'creates the conf file' do
      expect(chef_run).to render_file('/etc/httpd/conf.d/users.conf')
    end

    it 'creates the conf file' do
      expect(chef_run).to render_file('/etc/httpd/conf.d/admins.conf')
    end

  end

end
