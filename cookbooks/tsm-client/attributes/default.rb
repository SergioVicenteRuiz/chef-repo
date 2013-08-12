#
# Cookbook Name:: tsm-client
# Attributes:: default
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
case node['platform_family']
when "rhel", "fedora"
  default['tsm']['install_flavor'] = nil
  default['tsm']['extract_source'] = nil
  default['tsm']['dsm_opt_extract_path'] = nil
  default['tsm']['install_options'] = nil
when "freebsd"
  default['tsm']['install_flavor'] = nil
  default['tsm']['extract_source'] = nil
  default['tsm']['dsm_opt_extract_path'] = nil
  default['tsm']['install_options'] = nil
when "arch"
  default['tsm']['install_flavor'] = nil
  default['tsm']['extract_source'] = nil
  default['tsm']['dsm_opt_extract_path'] = nil
  default['tsm']['install_options'] = nil
when "debian"
  default['tsm']['install_flavor'] = nil
  default['tsm']['extract_source'] = nil
  default['tsm']['dsm_opt_extract_path'] = nil
  default['tsm']['install_options'] = nil
when "smartos"
  default['tsm']['install_flavor'] = nil
  default['tsm']['extract_source'] = nil
  default['tsm']['dsm_opt_extract_path'] = nil
  default['tsm']['install_options'] = nil
when "windows"
  default['tsm']['install_flavor'] = "windows"
  default['tsm']['extract_path'] = "#{Chef::Config[:file_cache_path]}/tsm_images/TSM_BA_Client"
  default['tsm']['install_dir'] = "C:/Tivoli/TSM/baclient"
  default['tsm']['service'] = "TSM_Scheduler"
  default['tsm']['password'] = "nodepassword"
  if kernel.machine =~ /x86_64/
    default['tsm']['extract_source'] = "http://yum.#{node['domain']}:8080/tsm/6.4.0.0-TIV-TSMBAC-WinX64.exe"
    default['tsm']['dsm_opt_extract_path'] = "#{Chef::Config[:file_cache_path]}/tsm_images/TSM_BA_Client/Program Files 64/Tivoli/TSM/config"
    default['tsm']['install_options'] = 'RebootYesNo="No" REBOOT="Suppress" ALLUSERS=1 INSTALLDIR="C:\Tivoli\TSM" ADDLOCAL="BackupArchiveGUI,BackupArchiveWeb,Api64Runtime" TRANSFORMS=1033.mst /qn /l*v "%temp%\install_tsm_log.txt"'
    default['tsm']['appid'] = '{F5C1AC15-CB26-44D5-80BD-986463F15B09}'
  else
    default['tsm']['extract_source'] = "http://yum.#{node['domain']}:8080/tsm/6.4.0.0-TIV-TSMBAC-WinX32.exe"
    default['tsm']['dsm_opt_extract_path'] = "#{Chef::Config[:file_cache_path]}/tsm_images/TSM_BA_Client/Program Files/Tivoli/TSM/config"
    default['tsm']['install_options'] = 'RebootYesNo="No" REBOOT="Suppress" ALLUSERS=1 INSTALLDIR="C:\Tivoli\TSM" ADDLOCAL="BackupArchiveGUI,BackupArchiveWeb,ApiRuntime" TRANSFORMS=1033.mst /qn /l*v "%temp%\install_tsm_log.txt"'
    default['tsm']['appid'] = '{C2C4809D-6809-43B6-A544-1DE0BA0E40B8}'
  end
else
  default['tsm']['install_flavor'] = nil
  default['tsm']['extract_source'] = nil
  default['tsm']['dsm_opt_extract_path'] = nil
  default['tsm']['install_options'] = nil
end








