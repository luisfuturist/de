# Docker shortcuts
alias d='docker'                      
alias di='docker images'              
alias dco='docker container'           
alias dp='docker ps'                 
alias dpa='docker ps -a'              
alias drm='docker rm'                 
alias drma='docker rm $(docker ps -aq)'      # Remove all containers
alias drmi='docker rmi'
alias drmia='docker rmi $(docker images -q)' # Remove all images
alias dd='docker stop'
alias dru='docker run'
alias druirm='docker run -it --rm'
alias de='docker exec'
alias dei='docker exec -it'
alias dl='docker logs -f'
alias dnea='docker network ls'
alias dvoa='docker volume ls'
alias dvorma='docker volume rm $(docker volume ls -q)' # Remove all volumes

# Docker Compose shortcuts
alias dcu='docker compose up'
alias dcud='docker-compose up -d'
alias dcd='docker-compose down'
alias dcl='docker-compose logs -f'
alias dcb='docker-compose build'
alias dcru='docker-compose run'
alias dcrurm='docker-compose run --rm'
alias dce='docker-compose exec'
alias dcp='docker-compose ps'
