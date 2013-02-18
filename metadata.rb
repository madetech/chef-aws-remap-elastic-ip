maintainer        "Made by Made"
maintainer_email  "chris@madebymade.co.uk"
license           "BSD"
description       "Installs and configures AWS elastic IP remapper"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.0"

recipe            "chef-elastic-ip-remap", "Installs and configures AWS elastic IP remapper"

depends           "git"

%w{ ubuntu fedora }.each do |os|
  supports os
end
