{% if grains['lsb_distrib_codename'] == 'trusty' %}                                                                                                                                                                 
extra_packages:
  pkg.installed:
    - refresh: True
    - pkgs:
      - linux-image-extra-{{ grains['kernelrelease'] }}
      - linux-image-extra-virtual
{% endif %}

{% if grains['os'] == 'Ubuntu' %}

docker-repo:
  pkgrepo.managed:
    - humanname: Official Docker Repository
    - name: deb [arch={{ grains['osarch'] }}] https://download.docker.com/linux/ubuntu {{ grains['oscodename'] }} stable
    - dist: {{ grains['oscodename'] }}
    - file: /etc/apt/sources.list.d/docker.list
    - gpgkey: https://download.docker.com/linux/ubuntu/gpg
    - keyid: 0EBFCD88
    - keyserver: keyserver.ubuntu.com
    - gpgcheck: 1
    - require_in:
      - pkg: docker-ce

{% endif %}

docker-ce:  
  pkg.installed:
    - force_yes: True

docker:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - pkg: docker-ce

# get-compose:
#   cmd.run:
#     - name: |
#         curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
#         chmod +x /usr/local/bin/docker-compose
#     - unless: docker-compose --version | grep -q 1.14.0

# get-compose-completion:
#   cmd.wait:
#     - name: |
#         curl -L https://raw.githubusercontent.com/docker/compose/1.14.0/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
#     - watch:
#       - cmd: get-compose

compose-pip:
  pkg.installed:
    - name: python-pip
  pip.installed:
    - name: pip
    - upgrade: True

compose:
  pip.installed:
    - name: docker-compose
