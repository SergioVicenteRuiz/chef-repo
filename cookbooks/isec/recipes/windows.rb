#
# Cookbook Name:: isec
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

security_db_path = win_friendly_path("%SystemRoot%/security/database")
security_db_file = win_friendly_path(File.join(security_db_path, "isec-template.sdb"))
security_template_path = win_friendly_path("%SystemRoot%/security/templates")
security_template_file = win_friendly_path(File.join(security_template_path, "isec-template.inf"))

if node.default['isec']['override'] = false
  security_template_source = "isec-#{node['isec']['install_flavor']}#{node['isec']['windows_ver']}.inf.erb"
else
  security_template_source = "isec-#{node['hostname']}.inf.erb"
end

template security_template_file do
  source security_template_source
  notifies :run, 'execute[secedit]', :immediately
end

execute 'secedit' do
  command %Q(secedit.exe /configure /DB #{security_db_file} /CFG #{security_template_file} /override /quiet)
  action :nothing
end
