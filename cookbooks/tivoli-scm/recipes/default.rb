#
# Cookbook Name:: tivoli-scm
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "tivoli-scm::#{node['tscm']['install_flavor']}"

