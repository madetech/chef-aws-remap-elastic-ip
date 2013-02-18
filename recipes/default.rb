# Copyright (c) 2013, Made By Made Ltd
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of the "Made By Made Ltd" nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL MADE BY MADE LTD BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

include_recipe "git"

install_dir = "/var/lib/aws/elastic_ip/"

directory install_dir do
  mode 0755
  owner "root"
  action :create
  recursive true
end

git install_dir do
  repository "git://github.com/madebymade/aws-remap-elastic-ip.git"
  revision "master"
  action :sync
  user "root"
  not_if {File.exists?("#{install_dir}/remap.rb")}
end

template "#{install_dir}/config.json" do
  source "config.json.erb"
  mode "0700"
end

execute "Update Rubygems" do
  command "gem install rubygems-update"
end

execute "Update Rubygems (2)" do
  command "/var/lib/gems/1.8/bin/update_rubygems"
end

execute "Install bundler for system Ruby" do
  command "gem install bundler"
end

execute "Bundle install dependencies" do
  command "bundle install"
  cwd install_dir
end

dest = "/etc/init/aws_remap_elastic_ip.conf"
execute "Install upstart" do
  command "mv #{install_dir}/upstart.conf #{dest}"
  not_if {File.exists?(dest)}
end

execute "Set upstart permissions" do
  command "chmod 0644 #{dest}"
end
