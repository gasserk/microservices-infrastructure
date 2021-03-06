# Overview

[![Join the chat at https://gitter.im/CiscoCloud/microservices-infrastructure](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/CiscoCloud/microservices-infrastructure?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Microservices infrastructure is a modern platform for rapidly deploying globally distributed services

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc/generate-toc again -->
**Table of Contents**

- [Overview](#overview)
    - [Features](#features)
        - [Architecture](#architecture)
        - [Control Nodes](#control-nodes)
        - [Resource Nodes](#resource-nodes)
    - [Getting Started](#getting-started)
        - [Software Requirements](#software-requirements)
        - [Deploying on multiple servers](#deploying-on-multiple-servers)
    - [Documentation](#documentation)
    - [Roadmap](#roadmap)
        - [Core Components and Features](#core-components-and-features)
        - [Mesos Frameworks](#mesos-frameworks)
        - [Security](#security)
        - [Operations](#operations)
        - [Platform Support](#platform-support)
    - [Development](#development)
    - [License](#license)

<!-- markdown-toc end -->

## Features

* [Mesos](http://mesos.apache.org) cluster manager for efficient resource isolation and sharing across distributed services
* [Marathon](https://mesosphere.github.io/marathon) for cluster management of long running containerized services
* [Consul](http://consul.io) for service discovery
* [Vault](http://vaultproject.io) for managing secrets
* [Docker](http://docker.io) container runtime
* Multi-datacenter support
* High availablity
* Security

### Architecture

The base platform contains control nodes that manage the cluster and any number of resource nodes. Containers automatically register themselves into DNS so that other services can locate them.

![Single-DC](docs/_static/single_dc.png)

Once WAN joining is configured, each cluster can locate services in other data centers via DNS or the [Consul API](http://www.consul.io/docs/agent/http.html).

![Mult-DC](docs/_static/multi_dc.png)

### Control Nodes

The control nodes manage a single datacenter.  Each control node runs Consul for service discovery, Mesos leaders for resource scheduling and Mesos frameworks like Marathon. 

In general, it's best to provision 3 or 5 control nodes to achieve higher availability of services. The Consul Ansible role will automatically bootstrap and join multiple Consul nodes. The Mesos Ansible role will provision highly-availabile Mesos and ZooKeeper environments when more than one node is provisioned.

![Control Node](docs/_static/control_node.png)

### Resource Nodes

Resource nodes launch containers and other Mesos-based workloads. 

![Resource Node](docs/_static/resource_node.png)

## Getting Started

All development is done on the `master` branch. Tested, stable versions are identified via git tags. 

```
    git clone https://github.com/CiscoCloud/microservices-infrastructure.git

```

To use a stable version, use `git tag` to list the stable versions:

```
git tag
0.1.0
0.2.0

git checkout 0.2.0
```

A Vagrantfile is provided that provisions everything on a single VM. To run (ensure that your sytem has 4GB or RAM free):

```
sudo pip install -r requirements.txt
./security-setup
vagrant up
```

Note:
* There is no support for Windows at this time, however support is planned.
* There is no support for the VMware Fusion Vagrant provider, so ensure that you set your provider to Virtualbox when running `vagrant up`: `vagrant up --provider=virtualbox`.


### Software Requirements

Requirements for running the project are listed in `requirements.txt`. Of note: Ansible 1.8 or later is required. All the software requirements are currently distributed as Python modules, and you can `pip install -r requirements.txt` to get them all at once.

### Deploying on multiple servers

If you already have running instances (Centos7 is the only Linux distribution supported at this time), do the following to deploy the software:

1. Install the software components: `pip install -r requirements.txt`.
2. Create an [Ansible inventory](http://docs.ansible.com/intro_inventory.html) file. You can use the the following files as examples, replacing the host names with your instances: 
	- [`inventory/1-datacenter`](inventory/1-datacenter)
	- [`inventory/2-datacenter`](inventory/2-datacenter) Multi-DC with WAN join. Ensure that DCs have network connectivity to each other, especially for ports 8300-8302. 
3. Set up security. Run: `./security-setup` 
4. Run `ansible-playbook -i <your_inventory_file> site.yml -e @security.yml`

The [Getting Started Guide](https://microservices-infrastructure.readthedocs.org/en/latest/getting_started/index.html) covers multi-server and OpenStack deployments.

## Documentation

All documentation is located at [https://microservices-infrastructure.readthedocs.org](https://microservices-infrastructure.readthedocs.org/en/latest). 

To build the documentation locally, run:

```
sudo pip install -r requirements.txt
cd docs
make html
```

## Roadmap


### Core Components and Features

- [x] Mesos
- [x] Consul
- [x] Multi-datacenter
- [x] High availablity
- [ ] Rapid immutable deployment (with Terraform + Packer)

### Mesos Frameworks

- [x] Marathon
- [ ] Kubernetes
- [ ] Kafka
- [ ] Riak
- [ ] Cassandra
- [ ] Elasticsearch
- [ ] HDFS
- [ ] Spark
- [ ] Storm
- [ ] Chronos

### Security

- [x] Manage Linux user accounts
- [x] Authentication and authorization for Consul
- [x] Authentication and authorization for Mesos
- [x] Authentication and authorization for Marathon
- [x] Application load balancer (based on HAProxy and consul-template)
- [x] Application dynamic firewalls (using consul template)

### Operations

- [ ] Logging
- [ ] Metrics
- [ ] In-service upgrade with rollback
- [ ] Autoscaling of Resource Nodes
- [ ] Self maintaining system (log rotation, etc)
- [ ] Self healing system (automatic failed instance replacement, etc)

### Platform Support

- [x] Vagrant (Mac OSX + VirtualBox)
- [ ] Vagrant (Windows + VirtualBox)
- [x] OpenStack
- [x] Cisco Cloud Services
- [X] Cisco MetaCloud
- [ ] Cisco Unified Computing System
- [ ] Amazon Web Services
- [ ] Microsoft Azure
- [ ] Google Compute Engine
- [ ] VMware vSphere
- [ ] Apache CloudStack

Please see [milestones](https://github.com/CiscoCloud/microservices-infrastructure/milestones) for more details on the roadmap.

## Development

If you're interested in contributing to the project, install the software listed in `requirements.txt` and follow the Getting Started instructions. To build the docs, enter the `docs` directory and run `make html`. The docs will be output to `_build/html`.

Good issues to start with are marked with the [low hanging fruit](https://github.com/CiscoCloud/microservices-infrastructure/issues?q=is%3Aopen+is%3Aissue+label%3A%22low+hanging+fruit%22) tag.

## License

Copyright © 2015 Cisco Systems, Inc.

Licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0) (the "License").

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
