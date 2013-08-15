#
# Cookbook Name:: osconfig
# Recipe:: windows
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


template node['osconfig']['hosts'] do
    source "hosts.windows.erb"
end
