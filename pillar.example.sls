ferm:
  lookup:
    configs:
      - name: root
        path: /etc/ferm/ferm.conf
        template_path:
          - salt://ferm/files/root.ferm
      - name: basic
        path: /etc/ferm/conf.d/01_basic.ferm
        template_path:
          - salt://ferm/files/basic.ferm
      - name: host
        path: /etc/ferm/conf.d/99_host.ferm
        template_path:
          - salt://ferm/files/postfix/smarthost.ferm
