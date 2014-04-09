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
{% if datamap.configure|default(False) %}
      - file: ferm
    - watch:
      - file: ferm
  file:
    - managed
    - name: {{ datamap.config.ferm.path|default('/etc/ferm/ferm.conf') }}
    - source: {{ datamap.config.ferm.template_path|default('salt://ferm/files/ferm.conf') }}
    - mode: '0644'
    - user: root
    - group: root
    - template: jinja
{% endif %}
