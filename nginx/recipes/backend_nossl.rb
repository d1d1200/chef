#
# Cookbook Name:: nginx
# Recipe:: backend/conf
#
# Author:: Sasanadi Ruka <d1d1200@gmail.com>
#
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

# run the nginx::default recipe to install nginx
include_recipe "nginx"


template "#{node[:nginx][:dir]}/sites-available/#{node[:nginx][:backend_nossl][:beno_bename]}" do
  source 'backend_nossl.erb'
  owner  'root'
  mode   '0644'
  notifies :reload, 'service[nginx]'
end

#enable your sites configuration using a definition from the nginx cookbook
nginx_site "#{node[:nginx][:backend_nossl][:beno_bename]}" do
  enable true
end