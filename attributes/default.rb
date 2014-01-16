# my.cnf default values
default['mysql']['server_charset']                  = 'utf8mb4'
default['mysql']['max_connections']                 = 128
default['mysql']['innodb_file_per_table']           = true
default['mysql']['innodb_buffer_pool_size']         = '256M'
default['mysql']['innodb_write_io_threads']         = 4
default['mysql']['innodb_read_io_threads']          = 4
default['mysql']['innodb_log_buffer_size']          = 16
default['mysql']['innodb_log_file_size']            = '64M'
default['mysql']['innodb_flush_log_at_trx_commit']  = 1

default['mysql']['server_id']  = 1
default['mysql']['log_bin']  = 'mysql-bin'
default['mysql']['binlog_format']  = 'ROW'
default['mysql']['bind_address']  = '0.0.0.0'
default['mysql']['grants_path']                 = "/etc/mysql_grants.sql"
default['mysql']['mysql_bin']               = "/usr/bin/mysql"

default['mysql']['server_root_password'] = ''

# version 5.6
default['mysql']['version'] = '5.6'
default['mysql']['install_rpms'] = [
  {
    :rpm_file => 'MySQL-server-5.6.13-1.el6.x86_64.rpm',
    :package_name => 'MySQL-server'
  },
  {
    :rpm_file => 'MySQL-client-5.6.13-1.el6.x86_64.rpm',
    :package_name => 'MySQL-client'
  },
  {
    :rpm_file => 'MySQL-shared-5.6.13-1.el6.x86_64.rpm',
    :package_name => 'MySQL-shared'
  },
  #{
  #  :rpm_file => 'MySQL-shared-compat-5.6.13-1.el6.x86_64.rpm',
  #  :package_name => 'MySQL-shared-compat'
  #},
  #{
  #  :rpm_file => 'MySQL-devel-5.6.13-1.el6.x86_64.rpm',
  #  :package_name => 'MySQL-devel'
  #},
  #{
  #  :rpm_file => 'MySQL-embedded-5.6.13-1.el6.x86_64.rpm',
  #  :package_name => 'MySQL-embedded'
  #}
]

# version 5.5
=begin
default['mysql']['version'] = '5.5'
default['mysql']['install_rpms'] = [
  {
    :rpm_file => 'MySQL-server-5.5.33-1.el6.x86_64.rpm',
    :package_name => 'MySQL-server'
  },
  {
    :rpm_file => 'MySQL-client-5.5.33-1.el6.x86_64.rpm',
    :package_name => 'MySQL-client'
  },
  {
    :rpm_file => 'MySQL-shared-5.5.33-1.el6.x86_64.rpm',
    :package_name => 'MySQL-shared'
  },
  #{
  #  :rpm_file => 'MySQL-shared-compat-5.5.33-1.el6.x86_64.rpm',
  #  :package_name => 'MySQL-shared-compat'
  #},
  #{
  #  :rpm_file => 'MySQL-devel-5.5.33-1.el6.x86_64.rpm',
  #  :package_name => 'MySQL-devel'
  #},
  #{
  #  :rpm_file => 'MySQL-embedded-5.5.33-1.el6.x86_64.rpm',
  #  :package_name => 'MySQL-embedded'
  #}
]
=end
