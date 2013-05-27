# Docker PaaS Example
This is a little fun hacking on a rainy day to figure out how to built a
crude PaaS powered by docker.


## Running

This uses [puppet-librarian](https://github.com/rodjek/librarian-puppet)
to manage third party puppet modules used for provisioning so you should
install that first. Also make sure you have
[vagrant](http:///www.vagrantup.com) installed as well. 

- run `librariab-puppet install`
- run `vagrant up`

Boom! Profit!

