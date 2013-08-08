#
# Cookbook Name:: tsm-client
# Recipe:: undo 
#
# Copyright 2012, Eric G. Wolfe
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Distributes dsm.opt file

install_dir = win_friendly_path(node['tsm']['install_dir'])
dsm_opt_file = win_friendly_path(File.join(node['tsm']['install_dir'], "dsm.opt"))

service node['tsm']['service'] do
  action :nothing
end

template dsm_opt_file do
  source "dsm.opt.erb"
  notifies :restart, 'service[#{node['tsm']['service']}]', :immediately
  notifies :run, 'execute[tsm_service_create]', :immediately
end

execute 'tsm_service_create' do
  command %Q(#{node['tsm']['install_dir']}/dsmcutil.exe install scheduler /name:"#{node['tsm']['service']}" /node:#{node['hostname']} /password:#{node['tsm']['password']} /validate:yes /clientdir:#{install_dir} /optfile:#{dsm_opt_file} /autostart:yes)
  not_if {Win32::Service.exists?(node['tsm']['service'])}
  notifies :start, "service[#{node['tsm']['service']}]", :immediately
end


