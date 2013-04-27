Description
===========

Installs ImageMagick and optionally Rmagick (RubyGem).

It can eather install the package distributed with the operating system or compile it from source.

Requirements
============

## Platform:

Tested on:

* Ubuntu (10.04)
* RHEL (6.1, 5.7)

Usage
=====

To install just ImageMagick,

```ruby
include_recipe "imagemagick"
```

In your own recipe/cookbook. To install the development libraries,

```ruby
include_recipe "imagemagick::devel"
```

To install the RubyGem rmagick,

```ruby
include_recipe "imagemagick::rmagick"
```

Which will install imagemagick, as well as the development libraries for imagemagick (so rmagick can be built).

Attributes
==========

* `node['imagemagick']['install_type']` defaults to `package`. Set to `source` to compile it from source
* `node['imagemagick']['version']` sets the version to install.
  When not set, it will fall back to the latest.
  Please note: The latest package is listed at http://www.imagemagick.org/download/ whereas the one you can specify by `version` are at http://www.imagemagick.org/download/legacy/
* `node['imagemagick']['checksum']` to validate downloaded package

License and Author
==================

Author:: Joshua Timberman (<joshua@opscode.com>)

Copyright:: 2009, Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
