# 🚀 Быстрый старт: Telegram Counter Mini App

## Что это?

Одностраничное Flutter приложение, которое работает как Telegram Mini App с функциями:
- ✅ Вход через Telegram
- ✅ Счетчик по нажатию кнопки
- ✅ Отображение профиля пользователя
- ✅ Красивый Material Design интерфейс

## 🛠️ Установка (5 минут)

### Шаг 1: Установите Flutter
```bash
# Скачайте с https://flutter.dev/docs/get-started/install

# Проверьте установку
flutter --version
```

### Шаг 2: Клонируйте/скопируйте файлы проекта
```bash
# Структура должна быть:
telegram_counter_app/
├── lib/
│   ├── main.dart
│   └── services/
│       └── telegram_service.dart
├── web/
│   └── index.html
├── pubspec.yaml
└── README.md
```

### Шаг 3: Установите зависимости
```bash
flutter pub get
```

### Шаг 4: Запустите приложение
```bash
flutter run -d chrome
```

Приложение откроется в Chrome на `http://localhost:xxxxx`

## 📱 Тестирование в Telegram (для разработчиков)

### Способ 1: Используйте ngrok для локального туннеля
```bash
# Установите ngrok с https://ngrok.com

# Запустите Flutter приложение
flutter run -d chrome

# В другом терминале создайте туннель (если приложение на :9999)
ngrok http 9999

# Скопируйте URL из ngrok
```

### Способ 2: Разверните на Firebase Hosting
```bash
# Установите Firebase CLI
npm install -g firebase-tools

# Инициализируйте проект
firebase init hosting

# Соберите приложение
flutter build web

# Разверните
firebase deploy
```

## 🤖 Создание Telegram Bot и Mini App

### Шаг 1: Создайте бота через @BotFather
```
Напишите @BotFather в Telegram
/newbot
Следуйте инструкциям
Получите TOKEN бота
```

### Шаг 2: Создайте Mini App
```
Напишите @BotFather
/newapp
Введите название (например: "Counter App")
Вставьте URL вашего приложения
Получите APP_SHORT_NAME
```

### Шаг 3: Откройте приложение в Telegram
```
Откройте чат с вашим ботом
Внизу будет кнопка приложения
Нажмите её
```

## 📂 Структура файлов

```
lib/
├── main.dart                    # Главное приложение (главное и единственное место для кода)
└── services/
    └── telegram_service.dart    # Вспомогательный сервис для Telegram API

web/
└── index.html                   # HTML с подключением Telegram SDK

pubspec.yaml                      # Конфигурация зависимостей

README.md                         # Подробная документация
```

## 🎨 Главные компоненты

### MainPage (StatefulWidget)
Основной виджет приложения. Содержит:
- `_loginWithTelegram()` - вход через Telegram
- `_incrementCounter()` - увеличение счетчика
- `_buildLoginUI()` - экран входа
- `_buildCounterUI()` - экран со счетчиком

### Telegram Service
Вспомогательный класс с методами:
- `getUserData()` - получить данные пользователя
- `hapticFeedbackLight()` - вибрация
- `setHeaderColor()` - изменить цвет шапки
- и многое другое...

## ⚙️ Как это работает

1. **Инициализация**: При запуске приложение подключает Telegram Web App SDK
2. **Вход**: Пользователь нажимает кнопку "Вход через Telegram"
3. **Получение данных**: Приложение получает ID, имя и фото пользователя
4. **Счетчик**: Пользователь нажимает кнопку для увеличения счетчика
5. **Вибрация**: При каждом нажатии срабатывает haptic feedback

## 🔍 Отладка

### Способ 1: Chrome DevTools
```
Нажмите F12 в Chrome
Посмотрите в Console вывод
```

### Способ 2: Telegram Web App Debugger
```
В Telegram BotFather есть опция: /newapp
Там можно включить режим разработки
```

## 🚀 Публикация

### Вариант 1: Firebase Hosting (рекомендуется)
```bash
firebase deploy --only hosting
```

### Вариант 2: Vercel
```bash
npm i -g vercel
vercel deploy build/web
```

### Вариант 3: GitHub Pages
```bash
# Загрузите build/web на GitHub Pages
```

## 🎯 Дальнейшие улучшения

- 💾 Сохранение счетчика на сервер
- 📊 Таблица лидеров
- 🎁 Система достижений
- 🎨 Темная тема
- 🌍 Поддержка нескольких языков
- 👥 Мультиплеер режим

## 🐛 Решение проблем

### "Приложение работает только в Telegram Mini App"
✅ Это нормально! Тестируйте через Firefox/Chrome для разработки, но убедитесь, что используете HTTPS URL для Telegram

### Вибрация не работает
✅ Вибрация работает только на мобильных устройствах в Telegram

### Фото пользователя не загружается
✅ Может быть CORS проблема. Убедитесь, что используете HTTPS

## 📚 Дополнительные ресурсы

- [Flutter Web документация](https://flutter.dev/docs/get-started/web)
- [Telegram Web App документация](https://core.telegram.org/bots/webapps)
- [Material Design 3](https://m3.material.io/)
- [Dart документация](https://dart.dev/guides)

## 💬 Поддержка

Если что-то не работает:
1. Проверьте консоль браузера (F12 → Console)
2. Убедитесь, что используете HTTPS
3. Проверьте, что работаете в Telegram Mini App
4. Попробуйте очистить кеш браузера

---

**Готово!** 🎉 Теперь у вас есть полностью функциональное Telegram Mini App!
