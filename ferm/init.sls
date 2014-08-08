#!jinja|yaml

{% from "ferm/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('ferm:lookup')) %}

ferm:
  pkg:
    - installed
    - pkgs: {{ datamap.pkgs }}
  service:
    - {{ datamap.ensure|default('running') }}
    - name: {{ datamap.service.name|default('ferm') }}
    - enable: {{ datamap.service.enable|default(True) }}
    {# TODO: Currently it's not possible to set custom status checks. Therefor, (re)start if file has changed only #}
    - sig: {{ datamap.service.sig|default('init') }}

fermconf_dir:
  file:
    - directory
    - name: {{ datamap.config.fermconfdir.path|default('/etc/ferm/conf.d') }}
    - dir_mode: 700
    - file_mode: 600
    - user: root
    - group: root
    - makedirs: True
    #TODO activate this as soon as it works as expected: - clean: True
    - recurse:
      - mode
      - user
      - group

{% set configs = datamap.configs|default({}) %}
{% for k, v in configs.items() %}
ferm_config_{{ k }}:
  file:
    - managed
    - name: {{ v.path }}
    - source: {{ v.template_path }}
    - mode: 600
    - user: root
    - group: root
    - template: jinja
    - require:
      - file: fermconf_dir
    - watch_in:
      - service: ferm
{% endfor %}
