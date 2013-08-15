#
# Cookbook Name:: osconfig
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "osconfig::#{node['osconfig']['install_flavor']}"
