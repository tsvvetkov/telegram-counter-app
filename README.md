# tsvvetkov.github.io

# Telegram Counter Mini App на Flutter

Это одностраничное Flutter приложение с интеграцией Telegram Mini App и счетчиком нажатий.

## Возможности

✅ Вход через Telegram с получением данных пользователя
✅ Счетчик с увеличением при нажатии кнопки
✅ Отображение профиля пользователя (имя и фото)
✅ Сброс счетчика
✅ Выход из аккаунта
✅ Поддержка вибрации (haptic feedback) в Telegram
✅ Красивый Material Design интерфейс

## Требования

- Flutter SDK (версия 3.0.0 или выше)
- Dart SDK
- Веб-браузер
- Telegram приложение для тестирования

## Установка

1. Убедитесь, что у вас установлен Flutter:
```bash
flutter --version
```

2. Включите поддержку Web для Flutter:
```bash
flutter config --enable-web
```

3. Скопируйте файлы в ваш Flutter проект:
- `main.dart` → `lib/main.dart`
- `pubspec.yaml` → `pubspec.yaml`
- `web/index.html` → `web/index.html`

4. Установите зависимости:
```bash
flutter pub get
```

## Запуск приложения

### Локальное тестирование (веб-браузер)
```bash
flutter run -d chrome
```

### Сборка для продакшена
```bash
flutter build web
```

Файлы будут в папке `build/web/`

## Развертывание как Telegram Mini App

### Способ 1: Через Firebase Hosting

1. Инициализируйте Firebase:
```bash
firebase init hosting
```

2. Разверните:
```bash
flutter build web
firebase deploy
```

3. Скопируйте URL вашего приложения

### Способ 2: Через GitHub Pages

1. Создайте репозиторий на GitHub
2. Включите GitHub Pages в настройках
3. Загрузите содержимое `build/web/` в ветку `gh-pages`

### Способ 3: Через собственный сервер

Загрузите содержимое папки `build/web/` на ваш веб-сервер.

## Настройка Telegram Bot

1. Создайте бота через @BotFather:
   - Команда: `/newbot`
   - Следуйте инструкциям
   - Скопируйте токен бота

2. Создайте Telegram Mini App:
   - Команда: `/newapp` у @BotFather
   - Введите название приложения
   - Вставьте URL вашего приложения
   - Получите AppName

3. Откройте приложение в Telegram:
   - Перейдите в чат с вашим ботом
   - Нажмите на кнопку приложения

## Архитектура проекта

```
telegram_counter_mini_app/
├── lib/
│   └── main.dart           # Главное приложение
├── web/
│   └── index.html          # HTML с Telegram SDK
├── pubspec.yaml            # Конфигурация проекта
└── README.md               # Документация
```

## Основные компоненты

### MainPage (StatefulWidget)
- Управляет состоянием приложения
- Обработает логин через Telegram
- Управляет счетчиком

### _buildLoginUI()
- Экран входа с кнопкой Telegram
- Красивый дизайн с иконкой Telegram

### _buildCounterUI()
- Экран с счетчиком после входа
- Отображает профиль пользователя
- Кнопки для увеличения, сброса и выхода

## Функциональность Telegram Web App

### Получение данных пользователя
```dart
final user = js.context['Telegram']['WebApp']['initDataUnsafe']['user'];
```

### Вибрация (Haptic Feedback)
```dart
js.context['Telegram']['WebApp'].callMethod('HapticFeedback_light', []);
```

### Установка цвета шапки
```dart
js.context['Telegram']['WebApp'].callMethod('setHeaderColor', ['#2196F3']);
```

## Возможные расширения

- Сохранение счетчика на сервер
- Таблица лидеров
- Награды и достижения
- Синхронизация между устройствами
- Мультиплеер режим

## Поддерживаемые браузеры

- Chrome/Chromium
- Firefox
- Safari
- Edge
- Telegram веб-приложение

## Лицензия

MIT

## Поддержка

Если у вас есть вопросы, создайте issue в репозитории проекта.
