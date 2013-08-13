#
# Cookbook Name:: isec
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

security_db_path = win_friendly_path("#{node['kernel']['os_info']['windows_directory']}/security/database")
security_db_file = win_friendly_path(File.join(security_db_path, "isec-template.sdb"))
security_template_path = win_friendly_path("#{node['kernel']['os_info']['windows_directory']}/security/templates")
security_template_file = win_friendly_path(File.join(security_template_path, "isec-template.inf"))
security_template_source = "isec-#{node['isec']['install_flavor']}-#{node['isec']['windows_ver']}.inf.erb"

if node['isec']['override'] == true
  include_recipe "isec::#{node['hostname']}"
else

# 1.1 Password Requirements
# 1.2 Logging
# 1.7 Identify and Authenticate Users
# 1.8 Protecting Resources -OSRs
# 2.0 Business Use Notice

  template security_template_file do
    source security_template_source
    notifies :run, 'execute[secedit]', :immediately
  end

  execute 'secedit' do
    command %Q(secedit.exe /configure /DB #{security_db_file} /CFG #{security_template_file} /overwrite /quiet)
    action :nothing
  end

  registry_key "HKLM\\SYSTEM\\CurrentControlSet\\services\\eventlog\\Application" do
    values [{
      :name => "RestrictGuestAccess",
      :type => :dword,
      :data => 0x1
      }]
  end

  registry_key "HKLM\\SYSTEM\\CurrentControlSet\\services\\eventlog\\Security" do
    values [{
      :name => "RestrictGuestAccess",
      :type => :dword,
      :data => 0x1
      }]
  end

  registry_key "HKLM\\SYSTEM\\CurrentControlSet\\services\\eventlog\\System" do
    values [{
      :name => "RestrictGuestAccess",
      :type => :dword,
      :data => 0x1
      }]
  end

  registry_key "HKLM\\SYSTEM\\CurrentControlSet\\services\\eventlog\\DNS Server" do
    values [{
      :name => "RestrictGuestAccess",
      :type => :dword,
      :data => 0x1
      }]
    only_if {registry_key_exists?("HKLM\\SYSTEM\\CurrentControlSet\\services\\eventlog\\DNS Server", :machine)}
  end

  registry_key "HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer" do
    values [{
      :name => "NoDriveTypeAutoRun",
      :type => :dword,
      :data => 0xFF
      }]
  end

  if {registry_key_exists?("HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\Eventlog\\Security", :machine)} do
    registry_key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\Eventlog\\Security" do
      values [{
        :name => "AutoBackupLogFiles",
        :type => :dword,
        :data => 0x1
        }
        {
        :name => "Retention",
        :type => :dword,
        :data => 0xFFFFFFFF
        }]
    end
  else
    registry_key "HKLM\\SYSTEM\\CurrentControlSet\\services\\eventlog\\Security" do
      values [{
        :name => "AutoBackupLogFiles",
        :type => :dword,
        :data => 0x1
        }
        {
        :name => "Retention",
        :type => :dword,
        :data => 0xFFFFFFFF
        }]
    end
  end

  if {registry_key_exists?("HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\Eventlog\\System", :machine)} do
    registry_key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\Eventlog\\System" do
      values [{
        :name => "AutoBackupLogFiles",
        :type => :dword,
        :data => 0x1
        }
        {
        :name => "Retention",
        :type => :dword,
        :data => 0x0
        }]
    end
  else
    registry_key "HKLM\\SYSTEM\\CurrentControlSet\\services\\eventlog\\System" do
      values [{
        :name => "AutoBackupLogFiles",
        :type => :dword,
        :data => 0x1
        }
        {
        :name => "Retention",
        :type => :dword,
        :data => 0x0
        }]
    end
  end

  if {registry_key_exists?("HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\Eventlog\\Application", :machine)} do
    registry_key "HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\Eventlog\\Application" do
      values [{
        :name => "AutoBackupLogFiles",
        :type => :dword,
        :data => 0x1
        }
        {
        :name => "Retention",
        :type => :dword,
        :data => 0x0
        }]
    end
  else
    registry_key "HKLM\\SYSTEM\\CurrentControlSet\\services\\eventlog\\Application" do
      values [{
        :name => "AutoBackupLogFiles",
        :type => :dword,
        :data => 0x1
        }
        {
        :name => "Retention",
        :type => :dword,
        :data => 0x0
        }]
    end
  end

# 1.5 Network Settings

  windows_feature "SimpleTCP" do
    action :remove
  end

  windows_feature "TFTP" do
    action :remove
  end

  windows_feature "TelnetServer" do
    action :remove
  end

  windows_feature "IIS-FTPServer" do
    action :remove
  end

  windows_feature "SNMP" do
    action :install
  end

  registry_key "HKLM\\SYSTEM\\CurrentControlSet\\services\\SNMP\\Parameters\\TrapConfiguration\\#{node['isec']['snmp_community']}" do
    values [{
      :name => "1",
      :type => :string,
      :data => "#{node['isec']['snmp_server']}"
      }]
    notifies :restart, "service[SNMP]", :immediately
  end

  service "SNMP" do
    action :nothing
  end

end
