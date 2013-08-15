#
# Cookbook Name:: osconfig
# Recipe:: windows
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


template "C:/Windows/System32/Drivers/etc/hosts" do
    source "hosts.windows.erb"
end
