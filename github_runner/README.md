# Git Hub Runner

Это self-hosted Docker-out-of-Docker (DooD) ранер. 
Для его запуска требуется:
- получить github personal access токен и положить его в pass под именем github/access_token;
- сгенерить .env файл для контейнера с помощью скрипта prepare_envs.sh, который на вход требует так же имя репозитория для которого запускается runner в формате `repo_owner/repo_name`.

Изначальная задумка была такой, чтобы несколько ранеров могли использовать общую папку workspace, поэтому при создании workflows требуется учесть этот момент.