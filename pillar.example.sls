ferm:
  lookup:
    configs:
      root:
        path: /etc/ferm/ferm.conf
        template_path:
          - salt://ferm/files/root.ferm
      basic:
        path: /etc/ferm/conf.d/01_basic.ferm
        template_path:
          - salt://ferm/files/basic.ferm
      host:
        path: /etc/ferm/conf.d/99_host.ferm
        template_path:
          - salt://ferm/files/postfix/smarthost.ferm
