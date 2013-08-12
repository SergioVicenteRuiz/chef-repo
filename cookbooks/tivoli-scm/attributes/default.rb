#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: tivoli-scm
# Attribute:: default
#
# Copyright:: Copyright (c) 2011 Opscode, Inc.
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
  default['tscm']['install_flavor'] = nil
  default['tscm']['source'] = nil
  default['tscm']['jvm'] = nil
when "freebsd"
  default['tscm']['install_flavor'] = nil
  default['tscm']['source'] = nil
  default['tscm']['jvm'] = nil
when "arch"
  default['tscm']['install_flavor'] = nil
  default['tscm']['source'] = nil
  default['tscm']['jvm'] = nil
when "debian"
  default['tscm']['install_flavor'] = nil
  default['tscm']['source'] = nil
  default['tscm']['jvm'] = nil
when "smartos"
  default['tscm']['install_flavor'] = nil
  default['tscm']['source'] = nil
  default['tscm']['jvm'] = nil
when "windows"
  default['tscm']['install_flavor'] = "windows"
  case platform_version.to_f
  when 5.2 # Windows Server 2003
    if kernel.machine =~ /x86_64/
      default['tscm']['source'] = "http://yum.#{node['domain']}:8080/scm/scmclient_J5_fp51_winamd64.exe"
      default['tscm']['jvm'] = "http://yum.#{node['domain']}:8080/scm/scmclient_J5_fp51_install.jar"
    else
      default['tscm']['source'] = "http://yum.#{node['domain']}:8080/scm/scmclient_win32.exe"
      default['tscm']['jvm'] = "http://yum.#{node['domain']}:8080/scm/scmclient_install.jar"
    end
  when 6.0 # Windows Server 2008
    if kernel.machine =~ /x86_64/
      default['tscm']['source'] = "http://yum.#{node['domain']}:8080/scm/scmclient_J5_fp55_winamd64.exe"
      default['tscm']['jvm'] = "http://yum.#{node['domain']}:8080/scm/scmclient_J5_fp55_install.jar"
    else
      default['tscm']['source'] = "http://yum.#{node['domain']}:8080/scm/scmclient_J5_fp55_win32.exe"
      default['tscm']['jvm'] = "http://yum.#{node['domain']}:8080/scm/scmclient_J5_fp55_install.jar"
    end
  when 6.1 # Windows Server 2008 R2
    if kernel.machine =~ /x86_64/
      default['tscm']['source'] = "http://yum.#{node['domain']}:8080/scm/scmclient_J5_fp55_winamd64.exe"
      default['tscm']['jvm'] = "http://yum.#{node['domain']}:8080/scm/scmclient_J5_fp55_install.jar"
    else
      default['tscm']['source'] = "http://yum.#{node['domain']}:8080/scm/scmclient_J5_fp55_win32.exe"
      default['tscm']['jvm'] = "http://yum.#{node['domain']}:8080/scm/scmclient_J5_fp55_install.jar"
    end
  when 6.2 # Windows Server 2012
    default['tscm']['source'] = nil
    default['tscm']['jvm'] = nil
  end
  default['tscm']['install_dir'] = "C:/Program Files/IBM/SCM"
else
  default['tscm']['install_flavor'] = nil
  default['tscm']['source'] = nil
  default['tscm']['jvm'] = nil
end

