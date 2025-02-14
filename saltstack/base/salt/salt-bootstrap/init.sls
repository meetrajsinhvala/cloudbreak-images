install_saltbootstrap:
  archive.extracted:
    - name: /usr/sbin/
    - source: https://github.com/hortonworks/salt-bootstrap/releases/download/v0.13.6/salt-bootstrap_0.13.6_Linux_x86_64.tgz
    - source_hash: md5=1b28065f67f155a57b194e1e53d70bc8
    - archive_format: tar
    - enforce_toplevel: false
    - user: root
    - group: root
    - skip_verify: True
    - if_missing: /usr/sbin/salt-bootstrap

create_saltbootstrap_service_files:
  file.managed:
    - user: root
    - group: root
{% if grains['init'] in [ 'upstart', 'sysvinit'] %}
    - name: /etc/init.d/salt-bootstrap
    - source:
      - salt://{{ slspath }}/etc/init.d/salt-bootstrap.{{ grains['os_family'] | lower }}
      - salt://{{ slspath }}/etc/init.d/salt-bootstrap
    - mode: 755
{% elif grains['init'] == 'systemd' %}
    - name: /etc/systemd/system/salt-bootstrap.service
    - template: jinja
    - source: salt://{{ slspath }}/etc/systemd/system/salt-bootstrap.service
{% endif %}

salt-bootstrap:
  service.running:
    - enable: True
    - require:
      - install_saltbootstrap
      - create_saltbootstrap_service_files
