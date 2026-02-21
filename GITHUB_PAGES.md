# 📤 Публикация на GitHub Pages

## Вариант 1️⃣: Автоматическая публикация через GitHub Actions (РЕКОМЕНДУЕТСЯ)

Самый простой способ! Приложение будет автоматически публиковаться при каждом push.

### Шаг 1: Создайте репозиторий на GitHub
- Перейдите на https://github.com/new
- Назовите: `telegram-counter-app`
- Выберите `Public`
- Создайте репозиторий

### Шаг 2: Отправьте код на GitHub

```bash
# Инициализируйте git
git init

# Добавьте все файлы
git add .

# Сделайте первый коммит
git commit -m "Initial commit"

# Добавьте remote (замените USERNAME на ваш ник GitHub)
git remote add origin https://github.com/USERNAME/telegram-counter-app.git

# Переименуйте ветку в main (если нужно)
git branch -M main

# Отправьте на GitHub
git push -u origin main
```

### Шаг 3: Включите GitHub Pages

1. Перейдите в репозиторий на GitHub
2. Нажмите `Settings` → `Pages`
3. В разделе "Build and deployment":
   - Source: выберите `GitHub Actions`
4. Дождитесь, пока рабочий процесс закончится

### ✅ Готово!
Приложение будет доступно по адресу:
```
https://USERNAME.github.io/telegram-counter-app/
```

Проверьте статус deployment в вкладке `Actions` репозитория.

---

## Вариант 2️⃣: Ручная публикация (для опытных)

Если вы хотите контролировать каждый шаг:

### Шаг 1: Соберите приложение

```bash
flutter clean
flutter pub get
flutter build web --release
```

### Шаг 2: Установите пакет `gh-pages`

```bash
npm install -g gh-pages
```

или через pip (если используете Python):

```bash
pip install ghp-import
```

### Шаг 3: Опубликуйте

Если установлен `gh-pages` (npm):
```bash
gh-pages -d build/web
```

Или через `ghp-import` (Python):
```bash
ghp-import -p -f -m "Deploy Flutter app" build/web
```

### ✅ Готово!
После выполнения команды приложение будет на GitHub Pages.

---

## Вариант 3️⃣: Ручной push на ветку `gh-pages`

Самый контролируемый способ:

### Шаг 1: Соберите приложение
```bash
flutter clean
flutter pub get
flutter build web --release
```

### Шаг 2: Создайте ветку `gh-pages`
```bash
git checkout --orphan gh-pages
git rm -rf .
```

### Шаг 3: Скопируйте файлы из `build/web`
```bash
# Очистите папку
rm -rf *

# Скопируйте файлы
cp -r ../build/web/* .

# Или если вы используете Windows
# copy ..\build\web\* .
```

### Шаг 4: Отправьте на GitHub
```bash
git add .
git commit -m "Deploy Flutter web app"
git push origin gh-pages
```

### Шаг 5: Включите GitHub Pages
1. Перейдите в `Settings` → `Pages`
2. Выберите branch: `gh-pages`
3. Нажмите `Save`

---

## 🔗 Создание URL для Telegram Mini App

После публикации у вас будет URL:
```
https://USERNAME.github.io/telegram-counter-app/
```

**ВАЖНО:** GitHub Pages требует HTTPS, что идеально для Telegram Mini App!

### Регистрация в Telegram BotFather

1. Напишите @BotFather в Telegram
2. Команда: `/newapp`
3. Выберите вашего бота
4. Введите название приложения: "Counter"
5. Вставьте URL: `https://USERNAME.github.io/telegram-counter-app/`
6. Согласитесь с условиями
7. Получите APP_SHORT_NAME

### Откройте приложение в Telegram

1. Откройте чат с вашим ботом
2. Внизу будет кнопка с вашим приложением
3. Нажмите на неё
4. Приложение откроется в полноэкранном режиме

---

## 🔄 Обновление приложения

### Если используете GitHub Actions (Вариант 1):

```bash
# Сделайте изменения в коде
# Например, измените main.dart

# Коммитьте и отправляйте
git add .
git commit -m "Add new feature"
git push origin main
```

Приложение автоматически пересоберется и опубликуется!

### Если используете ручной способ:

```bash
# Переключитесь на main ветку
git checkout main

# Сделайте изменения
# ...

# Коммитьте
git add .
git commit -m "Update feature"
git push origin main

# Пересоберите
flutter build web --release

# Опубликуйте
gh-pages -d build/web
```

---

## 🐛 Решение проблем

### "Failed to build" в GitHub Actions
- Проверьте `pubspec.yaml` на синтаксические ошибки
- Убедитесь, что все зависимости указаны правильно
- Попробуйте `flutter pub get` локально

### "404 Not Found"
- Убедитесь, что GitHub Pages включены в Settings
- Проверьте, что ветка `gh-pages` существует
- Дождитесь завершения workflow (может занять 1-2 минуты)

### Приложение работает неправильно
- Откройте DevTools (F12 в браузере)
- Проверьте консоль на ошибки
- Убедитесь, что используете HTTPS (важно для Telegram API)

### Telegram не видит приложение
- Убедитесь, что URL правильный и доступен
- Проверьте, что приложение зарегистрировано у BotFather
- Попробуйте перезагрузить Telegram

---

## 📊 Проверка статуса

1. Перейдите в репозиторий
2. Нажмите на вкладку `Actions`
3. Посмотрите последний workflow
4. Если галочка 🟢 - всё хорошо
5. Если крестик 🔴 - есть ошибка (кликните для деталей)

---

## 💡 Советы

1. **Резервная копия**: Всегда делайте коммиты перед большими изменениями
2. **Тестирование**: Тестируйте локально перед push
3. **Версионирование**: Используйте теги для версий:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```
4. **README**: Добавьте README.md в репозиторий с инструкциями

---

**Готово!** Теперь ваше приложение будет жить на GitHub Pages и работать в Telegram! 🎉
