#!/bin/bash

# Настройки
WORK_DIR="/tmp/HA_addons"
LOG_FILE="/tmp/git_sync.log"
GITHUB_USER="dimanyci"

# Очистка логов
echo "🚀 Старт синхронизации ($(date))" > "$LOG_FILE"

# Переход в рабочую папку
cd "$WORK_DIR" || { echo "❗ Ошибка: папка $WORK_DIR не найдена" | tee -a "$LOG_FILE"; exit 1; }

# Проверка текущего статуса
echo "🔄 Синхронизация с GitHub..." | tee -a "$LOG_FILE"

# Пытаемся сделать pull c rebase
if ! git pull --rebase 2>>"$LOG_FILE"; then
  echo "⚠️ Ошибка rebase. Пробую git pull --allow-unrelated-histories..." | tee -a "$LOG_FILE"
  git pull --allow-unrelated-histories >>"$LOG_FILE" 2>&1 || { echo "❗ Git pull всё равно не удался." | tee -a "$LOG_FILE"; exit 1; }
fi

echo "✅ Git pull завершён." | tee -a "$LOG_FILE"

# Добавляем все изменения
git add . >>"$LOG_FILE" 2>&1

# Просим комментарий к коммиту
echo "📝 Введите комментарий к коммиту (оставьте пустым для стандартного):"
read -r COMMIT_MSG

if [ -z "$COMMIT_MSG" ]; then
  COMMIT_MSG="Update Home Assistant Add-ons"
fi

# Выполняем коммит
if git commit -m "$COMMIT_MSG" >>"$LOG_FILE" 2>&1; then
  echo "📦 Коммит создан." | tee -a "$LOG_FILE"
else
  echo "ℹ️ Нет изменений для коммита." | tee -a "$LOG_FILE"
fi

# Пушим изменения
echo "🚀 Пуш на GitHub..." | tee -a "$LOG_FILE"
if git push >>"$LOG_FILE" 2>&1; then
  echo "✅ Пуш выполнен успешно!" | tee -a "$LOG_FILE"
else
  echo "❌ Ошибка пуша! Проверь лог $LOG_FILE" | tee -a "$LOG_FILE"
fi

echo "🏁 Скрипт завершил работу." | tee -a "$LOG_FILE"
