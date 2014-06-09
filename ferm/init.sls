#!jinja|yaml

{% from "ferm/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('ferm:lookup')) %}

ferm:
  pkg:
    - installed
    - pkgs:
{% for p in datamap.pkgs %}
      - {{ p }}
{% endfor %}
  service:
    - {{ datamap.ensure|default('running') }}
    - name: {{ datamap.service.name|default('ferm') }}
    - enable: {{ datamap.service.enable|default(True) }}
    {# TODO: Currently it's not possible to set custom status checks. Therefor, (re)start if file has changed only #}
    - sig: {{ datamap.service.sig|default('init') }}
    - require:
      - pkg: ferm

fermconf_dir:
  file:
    - directory
    - name: {{ datamap.config.fermconfdir.path|default('/etc/ferm/conf.d') }}
    - dir_mode: 700
    - file_mode: 600
    - user: root
    - group: root
    - makedirs: True
    - recurse:
      - mode
      - user
      - group

{% for c in datamap.configs|default([]) %}
ferm_config_{{ c.name }}:
  file:
    - managed
    - name: {{ c.path }}
    - source: {{ c.template_path }}
    - mode: 600
    - user: root
    - group: root
    - template: jinja
    - require:
      - file: fermconf_dir
    - watch_in:
      - service: ferm
{% endfor %}
