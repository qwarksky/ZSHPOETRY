# ZSHPOETRY

## Pourquoi ?
* Polyvalence entre les systèmes
* Réduire la taille de l'environnement sans passer par une machine virtuelle
* Alternative à WSL pour Python

## Documentation et commandes utiles

Manuel docker : https://docs.docker.com/manuals/

Les commandes DOCKER basique 
* Vérifier le Dockerfile :  docker build --check .
* Construire une image depuis un Dockerfile :  docker build -t zshpoetry . 
* Nettoyage complet de votre système docker :  docker system prune -af  =>  attention ça enlève le cache,les volumes, toutes vos conteneurs. Adapter si vous avez plusieurs dockers.
* Lancer une image : docker run -it zshpoetry /bin/zsh 
* Lister vos images : docker images
* Monitoring dockers : docker stats
* Stopper un docker : docker stop zshpoetry

## Exploitation depuis le terminal
1. $> git clone https://github.com/qwarksky/ZSHPOETRY.git ZSHPOETRY
2. $> docker build -t zshpoetry .
3. $> docker run -it zshpoetry /bin/zsh 
