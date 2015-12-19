#
# Cookbook Name:: factorialapp
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

app_path = "/opt/devops-project"
if not ::File.exists?(app_path)
	app_path = "/vagrant"
end

package "python-pip"

execute "install-python-module"do
	command "pip install -r #{app_path}/requirements.txt"
end

if app_path != "/vagrant"
	cookbook_file "/etc/init/factorialapi.conf" do
		source "factorialapi.conf"
	end
	service "factorialapi" do
		provider Chef::Provider::Service::Upstart
		action [ :enable, :start ]
	end
end
