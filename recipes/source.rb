#
# Cookbook Name:: imagemagick
# Recipe:: default
#
# Copyright 2013, BauCloud.com (Tobias L. Maier <tobias.maier@baucloud.com>)
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

include_recipe 'build-essential::default'


case node['platform_family']
when 'rhel'
  # ToDo: What packages are necessary for this platform?
when 'debian'
  %w(
    libpng12-dev
    libglib2.0-dev
    libfontconfig1-dev
    zlib1g-dev
    libtiff4-dev
    libexif-dev
    libfreetype6-dev
  ).each do |pkg|
    package pkg
  end
end

basename = node['imagemagick']['version'].nil? ? "ImageMagick" : "ImageMagick-#{node['imagemagick']['version']}"
src_filename = "#{basename}.tar.bz2"
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"
src_extractpath = "#{Chef::Config['file_cache_path']}/#{basename}"

directory src_extractpath do
  action :create
end

execute "install-imagemagick" do
  cwd src_extractpath
  command "make install"
  creates "/usr/bin/convert"
  action :nothing
end

execute "make-imagemagick" do
  cwd src_extractpath
  command "make"
  action :nothing
  notifies :run, "execute[install-imagemagick]", :immediately
end

execute "configure-imagemagick" do
  cwd src_extractpath
  command "./configure --prefix=/usr"
  action :nothing
  notifies :run, "execute[make-imagemagick]", :immediately
end

execute "imagemagick-extract-source" do
  command "tar -xjf #{src_filepath} --strip-components 1 -C #{src_extractpath}"
  creates "#{src_extractpath}/COPYING"
  only_if do File.exist?(src_filepath) end
  action :run
  notifies :run, "execute[configure-imagemagick]", :immediately
  not_if "convert --version | grep #{node['imagemagick']['version']}"
end

remote_file src_filepath do
  path = node['imagemagick']['version'] ? node['imagemagick']['source']['version_path'] : ''
  source File.join(node['imagemagick']['source']['url'], path, src_filename)
  mode 0644
  checksum node['imagemagick']['checksum']
  notifies :run, "execute[imagemagick-extract-source]", :immediately
  not_if { ::File.exists?(src_filepath) }
  not_if "convert --version | grep #{node['imagemagick']['version']}"
end
