Ohai.plugin :Ohaicustomplugin do
 provides 'ohaicustomplugin/modules'

 collect_data :default do
 ohaicustomplugin(Mash.new)
 cmd_output =`uname -a`
 system_details = cmd_output.split(/[ ]+/)
 ohaicustomplugin[:operating_system] = system_details[0]
 ohaicustomplugin[:internal_hostname] = system_details[1]
 ohaicustomplugin[:my_company] = "Chef"
 end
end
