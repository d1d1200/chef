#
# Cookbook Name:: system
# Attributes:: system
#
# Copyright 2012-2014, Chris Fordham
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

default['system']['timezone'] = 'UTC'
default['system']['short_hostname'] = node['hostname']
# default['system']['domain_name'] = 'localdomain'
default['system']['domain_name'] = ''
default['system']['static_hosts'] = {}
default['system']['upgrade_packages'] = true

default['system']['packages']['install'] = []
default['system']['packages']['install_compile_time'] = []

default['system']['packages']['uninstall'] = []
default['system']['packages']['uninstall_compile_time'] = []

default['system']['cron_service_name'] = 'cron'
