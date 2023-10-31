# Chef InSpec test for recipe apache::default

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

#unless os.windows?
#  # This is an example test, replace with your own test.
#  describe user('root'), :skip do
#    it { should exist }
#  end
#end

# This is an example test, replace it with your own test.
describe port(80) do
  it { should be_listening }
end

# This is an example test, replace it with your own test.
#describe command('curl http://localhost') do
#  its(:stdout) { should match(/Welcome Home!/) }
#end
# This is an example test, replace it with your own test.

#describe file('/var/www/html/index.html') do
#  it { should exist }
#end

describe file('/srv/apache/admins/html/index.html') do
  it { should exist }
end

describe file('/srv/apache/users/html/index.html') do
  it { should exist }
end

describe command('curl http://localhost') do
  its(:stdout) { should match(/Welcome users!/) }
end

describe command('curl http://localhost:8080') do
  its(:stdout) { should match(/Welcome admins!/) }
end

plugin_directory = '/opt/kitchen/ohai/cookbook_plugins/apache'

describe command("/opt/chef/bin/ohai -d #{plugin_directory} ohaicustomplugin") do
 its(:stdout) { should match(/operating_system/) }
 its(:stdout) { should match(/internal_hostname/) }
end
