{% set jumpgate_agent_rpm_url = salt['environ.get']('JUMPGATE_AGENT_RPM_URL') %}

/cdp/bin/ccmv2/generate-config.sh:
  file.managed:
    - name: /cdp/bin/ccmv2/generate-config.sh
    - makedirs: True
    - source: salt://{{ slspath }}/cdp/bin/ccmv2/generate-config.sh
    - mode: 740

/etc/logrotate.d/ccmv2:
  file.managed:
    - name: /etc/logrotate.d/ccmv2
    - source: salt://{{ slspath }}/etc/logrotate.d/ccmv2
    - user: root
    - group: root
    - mode: 644

{% if jumpgate_agent_rpm_url %}
install_jumpgate_agent:
  pkg.installed:
    - sources:
      - jumpgate-agent: {{ jumpgate_agent_rpm_url }}
{% endif %}

jumpgate_group:
  group.present:
    - name: jumpgate

jumpgate_user:
  user.present:
    - name: jumpgate
    - system: True
    - gid: jumpgate
    - home: /etc/jumpgate/
    - shell: /sbin/nologin
