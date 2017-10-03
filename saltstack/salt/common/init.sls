ubuntu:
  user.present:
    - shell: /bin/bash
    - password: ubuntu
    - hash_password: True

install_packages:
  pkg.installed:
    - pkgs:
      - ssh
      - tree
      {% if grains['os'] == 'Ubuntu' %}  
      - apt-transport-https
      - python-apt
      {% endif %}
      - python-pip
    - refresh: True
