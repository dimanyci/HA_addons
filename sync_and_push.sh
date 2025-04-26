#!/bin/bash

# Переход в папку проекта
cd /tmp/HA_addons || { echo "❗ Ошибка: папка /tmp/HA_addons не найдена"; exit 1; }

echo "🔄 Синхронизация с удалённым репозиторием..."
git pull --rebase || { echo "❗ Ошибка git pull. Попробуй git pull --allow-unrelated-histories вручную."; exit 1; }

echo "✅ Синхронизация завершена!"

echo "📂 Добавляем изменения в индекс..."
git add .

echo "📝 Введите комментарий к коммиту (оставьте пустым для стандартного):"
read -r COMMIT_MSG

# Если комментарий пустой — подставляем дефолтный
if [ -z "$COMMIT_MSG" ]; then
    COMMIT_MSG="Update Home Assistant Add-ons"
fi

echo "📦 Выполняем коммит..."
git commit -m "$COMMIT_MSG"

echo "🚀 Отправляем изменения на GitHub..."
git push

echo "✅ Всё готово!"
