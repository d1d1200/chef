#
# Author:: Joshua Timberman <joshua@opscode.com>
# Cookbook Name:: couchdb
# Recipe:: default
#
# Copyright 2008-2009, Opscode, Inc
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

include_recipe 'erlang' if node['couch_db']['install_erlang']

case node['platform_family']
when 'rhel'
  group 'couchdb' do
    system true
  end

  user 'couchdb' do
    comment 'Couchdb Database Server'
    gid 'couchdb'
    shell '/bin/bash'
    home '/var/lib/couchdb'
    system true
  end

  include_recipe 'yum-epel'
end

package 'couchdb' do
  package_name value_for_platform(
    'openbsd' => { 'default' => 'apache-couchdb' },
    'gentoo' => { 'default' => 'dev-db/couchdb' },
    'default' => 'couchdb'
    )
end

template '/etc/couchdb/local.ini' do
  source 'local.ini.erb'
  owner 'couchdb'
  group 'couchdb'
  mode 0664
  variables(
    :config => node['couch_db']['config']
  )
  notifies :restart, 'service[couchdb]'
end

directory '/var/lib/couchdb' do
  owner 'couchdb'
  group 'couchdb'
  recursive true
  path value_for_platform(
    'openbsd' => { 'default' => '/var/couchdb' },
    'freebsd' => { 'default' => '/var/couchdb' },
    'gentoo' => { 'default' => '/var/couchdb' },
    'default' => '/var/lib/couchdb'
  )
end

service 'couchdb' do
  provider Chef::Provider::Service::Upstart if platform?("ubuntu") && node["platform_version"].to_f >= 13.10
  if platform_family?('rhel', 'fedora')
    start_command '/sbin/service couchdb start &> /dev/null'
    stop_command '/sbin/service couchdb stop &> /dev/null'
  end
  supports [:restart, :status]
  action [:enable, :start]
end
