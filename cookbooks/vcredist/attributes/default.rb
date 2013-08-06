#
# Cookbook Name:: vcredist
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

default['vcredist_x86']['extract_source'] = "http://yum.#{node['domain']}:8080/vcredist/vcredist_x86.exe"
default['vcredist_x86']['appid'] = '{F0C3E5D1-1ADE-321E-8167-68EF0DE699A5}'
default['vcredist_x86']['install_options'] = '/q /c:"msiexec /i vcredist.msi /qn /l*v"'

if kernel.machine =~ /x86_64/
  default['vcredist_x64']['extract_source'] = "http://yum.#{node['domain']}:8080/vcredist/vcredist_x64.exe"
  default['vcredist_x64']['appid'] = '{1D8E6291-B0D5-35EC-8441-6616F567A0F7}'
  default['vcredist_x64']['install_options'] = '/q /c:"msiexec /i vcredist.msi /qn /l*v"'
end


