include:
  - {{ slspath }}.path
  - {{ slspath }}.user_uid
  - {{ slspath }}.repository
  - {{ slspath }}.packages
  - {{ slspath }}.sudo
{% if pillar['subtype'] != 'Docker' %}
  - {{ slspath }}.sysctl
  - {{ slspath }}.disable_ipv6
  - {{ slspath }}.selinux
{% endif %}
  - {{ slspath }}.ssh
  - {{ slspath }}.pip
  - {{ slspath }}.cert-tool
  - {{ slspath }}.dnsmasq
  - {{ slspath }}.user
  - {{ slspath }}.firewall
  - {{ slspath }}.umask
  - {{ slspath }}.timeout
  - {{ slspath }}.jinja
  - {{ slspath }}.corkscrew
  - {{ slspath }}.storage
{% if pillar['OS'].startswith('ubuntu') %}
  - {{ slspath }}.disable-unattended-upgrades
{% endif %}
  - {{ slspath }}.authconfig

/usr/bin/:
  file.recurse:
    - source: salt://{{ slspath }}/usr/bin/
    - template: jinja
    - include_empty: True
    - file_mode: 755
