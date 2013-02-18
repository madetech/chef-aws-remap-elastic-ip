# Chef AWS Elastic IP remapper

Installs a Ruby script that remaps an elastic IP address to the EC2 instance on which it's run. Includes an upstart (for Ubuntu and friends) compatible config for launching the script at system start time.


### Usage

1. Overwrite the following configuration variables:

```ruby
    default[:aws_elastic_ip][:aws_access_key] = ""
    default[:aws_elastic_ip][:aws_secret_key] = ""
    default[:aws_elastic_ip][:ip_address] = "10.0.0.1"
    default[:aws_elastic_ip][:ec2_endpoint] = "ec2.eu-west-1.amazonaws.com"
```

2. Converge.


###License

Licensed under [New BSD License](http://opensource.org/licenses/BSD-3-Clause)