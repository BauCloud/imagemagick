#
# Cookbook Name:: imagemagick
# Attributes:: default
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

default['imagemagick']['version'] = nil
default['imagemagick']['checksum'] = nil
default['imagemagick']['source'] = {}
default['imagemagick']['source']['url'] = 'http://www.imagemagick.org/download/'
default['imagemagick']['source']['version_path'] = 'legacy/'
