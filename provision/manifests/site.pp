node registry {

}

node manager {
  # whaterver app we run to run here
}

node /^worker\d+$/ {
  include docker
  docker::image { 'base':
    require => Class['docker'],
  }
}
