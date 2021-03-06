define :backend_nossl, :template => "backend_nossl.erb", :enable => true do
  include_recipe "nginx::service"

  template "#{node[:nginx][:dir]}/sites-available/#{node[:nginx][:backend_nossl][:beno_bename]}" do
    Chef::Log.debug("Generating Nginx site template for backend_nossl")
    source params[:template]
    owner "root"
    group "root"
    mode 0644
    if params[:cookbook]
      cookbook params[:cookbook]
    end
    variables(
      :application => application,
      :application_name => node[:nginx][:backend_nossl][:beno_bename],
      :params => params
    )
    if File.exists?("#{node[:nginx][:dir]}/sites-enabled/#{node[:nginx][:backend_nossl][:beno_bename]}")
      notifies :reload, "service[nginx]", :delayed
    end
  end

  file "#{node[:nginx][:dir]}/sites-enabled/#{node[:nginx][:backend_nossl][:beno_bename]}" do
    action :delete
    only_if do
      File.exists?("#{node[:nginx][:dir]}/sites-enabled/#{node[:nginx][:backend_nossl][:beno_bename]}")
    end
  end

  if params[:enable]
    execute "nxensite #{node[:nginx][:backend_nossl][:beno_bename]}" do
      command "/usr/sbin/nxensite #{node[:nginx][:backend_nossl][:beno_bename]}"
      notifies :reload, "service[nginx]"
      not_if do File.symlink?("#{node[:nginx][:dir]}/sites-enabled/#{node[:nginx][:backend_nossl][:beno_bename]}") end
    end
  else
    execute "nxdissite #{node[:nginx][:backend_nossl][:beno_bename]}" do
      command "/usr/sbin/nxdissite #{node[:nginx][:backend_nossl][:beno_bename]}"
      notifies :reload, "service[nginx]"
      only_if do File.symlink?("#{node[:nginx][:dir]}/sites-enabled/#{node[:nginx][:backend_nossl][:beno_bename]}") end
    end
  end
end
