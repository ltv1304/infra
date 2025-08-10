# Git Hub Runner

Это self-hosted Docker-out-of-Docker (DooD) ранер. 
Для его запуска требуется:
- получить github personal access токен и положить его в pass под именем github/access_token;
- сгенерить .env файл для контейнера с помощью скрипта prepare_envs.sh, который на вход требует так же имя репозитория для которого запускается runner в формате `repo_owner/repo_name`.

Изначальная задумка была такой, чтобы несколько ранеров могли использовать общую папку workspace, поэтому при создании workflows требуется учесть этот момент.

Полезные материалы:
- [artice: основывался на этой статье](https://leothelegion.net/2025/07/28/use-docker-to-set-up-self-hosted-github-actions-runner-in-10-minutes/);
- [article: полезное](https://dev.to/flnzba/37-running-a-docker-container-in-a-docker-container-1de8);
- [article: попроще](https://dev.to/pwd9000/create-a-docker-based-self-hosted-github-runner-linux-container-48dh);
- [article: что б не потерять](https://senad-d.github.io/posts/github-actions-localy/);