## Install sniproxy in a docker container on a ubuntu machine using ansible

### Install angstwad.docker_ubuntu from ansible-galaxy
```SHELL
  ansible-galaxy install angstwad.docker_ubuntu
```

### run ansible
```SHELL
  ansible-playbook -vv -i {hosts_file} -s docker.yml -u {user}
```

## custom dns server

### run server
```SHELL
  bundle exec ./main.rb {proxy_server_ip}
```