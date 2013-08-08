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

dsm_opt_file = win_friendly_path(File.join(node['tsm']['install_dir'], "dsm.opt"))

template dsm_opt_file do
  source "dsm.opt.erb"
  notifies :restart, 'service[node['tsm']['service']]', :immediately
end
