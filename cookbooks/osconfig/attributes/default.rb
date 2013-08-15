# Cookbook Name:: osconfig
# Attributes:: default

case node['platform_family']
when "rhel", "fedora"
  default['osconfig']['install_flavor'] = nil
when "freebsd"
  default['osconfig']['install_flavor'] = nil
when "arch"
  default['osconfig']['install_flavor'] = nil
when "debian"
  default['osconfig']['install_flavor'] = nil
when "smartos"
  default['osconfig']['install_flavor'] = nil
when "windows"
  default['osconfig']['install_flavor'] = "windows"
else
  default['osconfig']['install_flavor'] = nil
end
