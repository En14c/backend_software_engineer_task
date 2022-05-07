#!/bin/bash

COMMANDLINE_ARGS=("$@")
OPERATION=${COMMANDLINE_ARGS[0]}

function run_containers_detached {
  docker-compose up -d
}

function kill_containers {
  docker-compose down
}

function restart_containers {
  kill_containers
  run_containers_detached
}

function purge_dangling_images {
  local DANGLING_IMAGES=$(docker images -f "dangling=true" -q)
  if [ "$DANGLING_IMAGES" ]; then
    docker rmi $DANGLING_IMAGES
  fi
}

function build {
  kill_containers
  docker-compose build --force-rm
  purge_dangling_images
}

function run_migrations {
  docker exec -it pennylanetask_appwebserver_1 rails db:migrate
}

function run_seeds {
  docker exec -it pennylanetask_appwebserver_1 rails db:seed --trace
}

function elastic_search_create_index {
  docker exec -it pennylanetask_appwebserver_1 bundle exec rake elasticsearch_create_index
}

function deploy {
  build
  run_containers_detached
}

function main {
  case $OPERATION in
    kill)
      kill_containers
      ;;
    run)
      run_containers_detached
      ;;
    build)
      build
      ;;
    restart)
      restart_containers
      ;;
    deploy)
      deploy
      ;;
    migrations)
      run_migrations
      ;;
    elastic_search_index)
      elastic_search_create_index
      ;;
    run_seed)
      run_seeds
      ;;
    *)
      echo "[FATAL ERROR] INVALID OPERATION"
      ;;
  esac
}

main