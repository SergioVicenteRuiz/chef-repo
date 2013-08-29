#
# Cookbook Name:: tsm-client
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "java"
include_recipe "tsm-client::#{node['tsm']['install_flavor']}"

