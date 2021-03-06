#
# Cookbook Name:: unicorn-ng
# Provider:: service
#
# Copyright 2012, Chris Aumann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

action :create do
  r = template "/etc/init.d/#{new_resource.service_name}" do
    owner new_resource.owner
    group new_resource.group
    mode  new_resource.mode

    cookbook new_resource.cookbook
    source   new_resource.source

    # default to paths relative to rails_root
    config         = new_resource.config         || "#{new_resource.rails_root}/config/unicorn.rb"
    pidfile        = new_resource.pidfile        || "#{new_resource.rails_root}/tmp/pids/unicorn.pid"
    bundle_gemfile = new_resource.bundle_gemfile || "#{new_resource.rails_root}/Gemfile"

    if new_resource.variables.empty?
      variables config:         config,
                bundle_gemfile: bundle_gemfile,
                pidfile:        pidfile,
                wrapper:        new_resource.wrapper,
                wrapper_opts:   new_resource.wrapper_opts,
                bundle:         new_resource.bundle,
                environment:    new_resource.environment,
                locale:         new_resource.locale,
                user:           new_resource.user,
                service_name:   new_resource.service_name,
                app_root:       new_resource.app_root,
                set_env:        new_resource.set_env,
                x_spree_client_token:   new_resource.x_spree_client_token,
                x_spree_client_token2:   new_resource.x_spree_client_token2,
                s3_bucket:      new_resource.s3_bucket,
                cloudfront_url:   new_resource.cloudfront_url,
                aws_access_key_id:  new_resource.aws_access_key_id,
                aws_secret_access_key:  new_resource.aws_secret_access_key,
                devise_secret_key:  new_resource.devise_secret_key,
                paperclip_hash_secret: new_resource.paperclip_hash_secret,
                asiapay_secure_hash_secret: new_resource.asiapay_secure_hash_secret,
                redis_password: new_resource.redis_password,
                adyen_notify_user: new_resource.adyen_notify_user,
                adyen_notify_passwd: new_resource.adyen_notify_passwd,
                elasticsearch_url: new_resource.elasticsearch_url,
                dropbox_token: new_resource.dropbox_token,
                dropbox_secret: new_resource.dropbox_secret,
                dropbox_app_key: new_resource.dropbox_app_key,
                dropbox_app_secret: new_resource.dropbox_app_secret,
                logentries_token: new_resource.logentries_token,
                smtp_username: new_resource.smtp_username,
                smtp_password: new_resource.smtp_password,
                smtp_address: new_resource.smtp_address,
                smtp_domain: new_resource.smtp_domain,
                mixpanel_token: new_resource.mixpanel_token,
                parse_application_id: new_resource.parse_application_id,
                parse_rest_api_key: new_resource.parse_rest_api_key,
                secret_key_base: new_resource.secret_key_base,
                memcached_url: new_resource.memcached_url,
                memcached_username: new_resource.memcached_username,
                memcached_password: new_resource.memcached_password,
                dev_db_name: new_resource.dev_db_name,
                dev_db_username: new_resource.dev_db_username,
                rds_db_name: new_resource.rds_db_name,
                rds_username: new_resource.rds_username,
                rds_password:  new_resource.rds_password,
                rds_hostname: new_resource.rds_hostname,
                rds_port: new_resource.rds_port
    else
      variables new_resource.variables
    end
  end

  new_resource.updated_by_last_action(true) if r.updated_by_last_action?

  service new_resource.service_name do
    supports restart: true, status: true, reload: true
    action [:enable, :start]
  end
end
