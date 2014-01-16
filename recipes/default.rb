#
# Cookbook Name:: mysql56
# Recipe:: default
#


version = node['mysql']['version']
my_cnf_path = (version.to_s == '5.6')? '/usr/my.cnf' : '/etc/my.cnf'


bash 'remove_installed_mysql' do
  only_if 'yum list installed | grep mysql*'
  user 'root'

  code <<-EOL
    yum remove -y mysql*
  EOL
end

node['mysql']['install_rpms'].each do |rpm|
  cookbook_file "/tmp/#{rpm[:rpm_file]}" do
    source "#{version}/#{rpm[:rpm_file]}"
  end

  package "#{rpm[:package_name]}" do
    action :install
    provider Chef::Provider::Package::Rpm
    source "/tmp/#{rpm[:rpm_file]}"
  end
end

template "#{my_cnf_path}" do
  user 'root'
  group 'root'
  mode '0644'
  source 'my.cnf.erb'

  variables ({
    :server_charset                  => node['mysql']['server_charset'],
    :max_connections                 => node['mysql']['max_connections'],
    :innodb_file_per_table           => node['mysql']['innodb_file_per_table'],
    :innodb_buffer_pool_size         => node['mysql']['innodb_buffer_pool_size'],
    :innodb_write_io_threads         => node['mysql']['innodb_write_io_threads'],
    :innodb_read_io_threads          => node['mysql']['innodb_read_io_threads'],
    :innodb_log_buffer_size          => node['mysql']['innodb_log_buffer_size'],
    :innodb_log_file_size            => node['mysql']['innodb_log_file_size'],
    :innodb_flush_log_at_trx_commit  => node['mysql']['innodb_flush_log_at_trx_commit']
  })
end

service 'mysql' do
  action [ :enable, :start ]
end

# version 5.6 over
if version.to_f >= 5.6
  package 'expect' do
    only_if 'ls /root/.mysql_secret'
    :install
  end

  cookbook_file '/tmp/password_set' do
    only_if 'ls /root/.mysql_secret'
  	source "#{version}/password_set"
  end

  execute 'password_set' do
    only_if 'ls /root/.mysql_secret'
  	user 'root'
  	command 'chmod +x /tmp/password_set && /tmp/password_set && rm -f /tmp/password_set'
  end

  package 'expect' do
    :remove
  end
end

grants_path = node['mysql']['grants_path']
begin
  t = resources("template[#{grants_path}]")
rescue
  Chef::Log.info("Could not find previously defined grants.sql resource")
  t = template grants_path do
    source "grants.sql.erb"
    owner "root"
    group "root"
    mode "0600"
    action :create
  end
end

execute "mysql-install-privileges" do
  command %Q["#{node['mysql']['mysql_bin']}" -u root < "#{grants_path}"]
  action :nothing
  subscribes :run, resources("template[#{grants_path}]"), :immediately
end
