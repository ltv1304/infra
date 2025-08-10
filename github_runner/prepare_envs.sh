#!/bin/bash

# -h
# -h prepare-env.sh - Скрипт для подготовки .env файла с параметрами запуска
# -h
# -h Использование:
# -h   ./prepare-env.sh [GIT_REPOSITORY]
# -h
# -h Параметры:
# -h   GIT_REPOSITORY - имя Git-репозитория в формате: owner/repo_name:
# -h
# -h Пример:
# -h   ./prepare-env.sh ltv1304/infra

set -euo pipefail

# Функция вывода справки
show_help() {
  grep '^# -h' < "$0" | tail -n +2 | sed 's/^# -h//'
  exit 0
}

# Проверка на запрос справки
if [[ "$#" -gt 0 && ("$1" == "-h" || "$1" == "--help") ]]; then
  show_help
fi

# Проверка передачи параметра
if [ $# -eq 0 ]; then
  echo "Внимание: GIT_REPOSITORY не указан" >&2
  echo "Вы можете указать его как параметр: ./prepare-env.sh owner/repo_name" >&2
fi

# Создаем/очищаем .env файл
echo "# Auto-generated environment file" > .env
echo "# Created at: $(date)" >> .env
echo >> .env

# Добавляем группы
echo "# Docker group IDs" >> .env
echo "DOCKER_GID=$(getent group docker | cut -d: -f3 || echo '')" >> .env
echo "RUNNER_GID=$(getent group runner | cut -d: -f3 || echo '')" >> .env
echo >> .env

# Добавляем GITHUB PAT
echo "# Git personal access token" >> .env
echo "ACCESS_TOKEN=$(pass github/access_token)" >> .env
echo >> .env

# Добавляем репозиторий
echo "# Git repository configuration" >> .env
echo "GIT_REPOSITORY=$1" >> .env

echo "Файл .env успешно создан"
echo "Репозиторий: $1"