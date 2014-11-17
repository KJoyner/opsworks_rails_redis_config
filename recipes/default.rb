#
# Cookbook Name:: opsworks_rails_redis
# Recipe:: default
#
# Copyright (C) 2014 kjoyner
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node['deploy'].each do |app_name, deploy_config|

	# skip configuration if redis node doesn't exist
	if (deploy_config['redis'].blank?)
		next
	end

	app_dir               = "#{deploy_config['deploy_to']}/current"
	app_shared_dir        = "#{deploy_config['deploy_to']}/shared"
	app_shared_config_dir = "#{app_shared_dir}/config"

	user  = deploy_config['user']
	group = deploy_config['group']

	# make sure the app shared config directory exists
	directory app_shared_config_dir do
		owner user
		group group
		mode 0770
		action :create
		recursive true
	end

	shared_redis_config_file = "#{app_shared_config_dir}/redis.yml"

	# use template 'redis.yml.erb' to generate 'config/redis.yml'
	template shared_redis_config_file do
		source 'redis.yml.erb'

		mode '0660'
		owner user
		group group

		# define variable “@redis” to be used in the ERB template
		variables(
				:redis => deploy_config['redis'] || {}
		)
	end

	# create a link to the redis.yml file
	link "#{app_dir}/config/redis.yml" do
		to shared_redis_config_file
		owner user
		group group
	end

end
