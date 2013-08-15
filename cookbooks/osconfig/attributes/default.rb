# Cookbook Name:: osconfig
# Attributes:: default

case node['platform_family']
when "rhel", "fedora"
  default['osconfig']['install_flavor'] = nil
  default['osconfig']['hosts'] = "/etc/hosts"
when "freebsd"
  default['osconfig']['install_flavor'] = nil
  default['osconfig']['hosts'] = "/etc/hosts"
when "arch"
  default['osconfig']['install_flavor'] = nil
  default['osconfig']['hosts'] = "/etc/hosts"
when "debian"
  default['osconfig']['install_flavor'] = nil
  default['osconfig']['hosts'] = "/etc/hosts"
when "smartos"
  default['osconfig']['install_flavor'] = nil
  default['osconfig']['hosts'] = "/etc/hosts"
when "windows"
  default['osconfig']['install_flavor'] = "windows"
  default['osconfig']['hosts'] = "C:\\Windows\\System32\\Drivers\\etc\\hosts"
else
  default['osconfig']['install_flavor'] = nil
  default['osconfig']['hosts'] = "/etc/hosts"
end
