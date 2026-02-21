import 'dart:js' as js;

/// Сервис для работы с Telegram Web App API
class TelegramWebAppService {
  
  /// Инициализирует Telegram Web App
  static void initialize() {
    try {
      js.context.callMethod('eval', [
        '''
        if (window.Telegram && window.Telegram.WebApp) {
          window.telegramWebApp = window.Telegram.WebApp;
          window.telegramWebApp.ready();
        }
        '''
      ]);
    } catch (e) {
      print('Ошибка инициализации Telegram: $e');
    }
  }

  /// Получает данные пользователя Telegram
  static Map<String, dynamic>? getUserData() {
    try {
      final initDataUnsafe = js.context['Telegram']?['WebApp']?['initDataUnsafe'];
      if (initDataUnsafe != null && initDataUnsafe['user'] != null) {
        final user = initDataUnsafe['user'];
        return {
          'id': user['id'],
          'is_bot': user['is_bot'] ?? false,
          'first_name': user['first_name'] ?? '',
          'last_name': user['last_name'] ?? '',
          'username': user['username'] ?? '',
          'language_code': user['language_code'] ?? '',
          'photo_url': user['photo_url'] ?? '',
          'is_premium': user['is_premium'] ?? false,
        };
      }
    } catch (e) {
      print('Ошибка получения данных пользователя: $e');
    }
    return null;
  }

  /// Получает ID чата
  static int? getChatId() {
    try {
      return js.context['Telegram']?['WebApp']?['initDataUnsafe']?['chat']?['id'];
    } catch (e) {
      print('Ошибка получения ID чата: $e');
    }
    return null;
  }

  /// Получает ID приложения
  static int? getAppId() {
    try {
      return js.context['Telegram']?['WebApp']?['initDataUnsafe']?['auth_date'];
    } catch (e) {
      print('Ошибка получения ID приложения: $e');
    }
    return null;
  }

  /// Устанавливает цвет шапки
  static void setHeaderColor(String color) {
    try {
      js.context['Telegram']?['WebApp']?.callMethod('setHeaderColor', [color]);
    } catch (e) {
      print('Ошибка установки цвета шапки: $e');
    }
  }

  /// Устанавливает цвет фона
  static void setBackgroundColor(String color) {
    try {
      js.context['Telegram']?['WebApp']?.callMethod('setBackgroundColor', [color]);
    } catch (e) {
      print('Ошибка установки цвета фона: $e');
    }
  }

  /// Воспроизводит легкую вибрацию
  static void hapticFeedbackLight() {
    try {
      js.context['Telegram']?['WebApp']?.callMethod('HapticFeedback_light', []);
    } catch (e) {
      print('Ошибка вибрации light: $e');
    }
  }

  /// Воспроизводит среднюю вибрацию
  static void hapticFeedbackMedium() {
    try {
      js.context['Telegram']?['WebApp']?.callMethod('HapticFeedback_medium', []);
    } catch (e) {
      print('Ошибка вибрации medium: $e');
    }
  }

  /// Воспроизводит тяжелую вибрацию
  static void hapticFeedbackHeavy() {
    try {
      js.context['Telegram']?['WebApp']?.callMethod('HapticFeedback_heavy', []);
    } catch (e) {
      print('Ошибка вибрации heavy: $e');
    }
  }

  /// Воспроизводит вибрацию выбора
  static void hapticFeedbackSelection() {
    try {
      js.context['Telegram']?['WebApp']?.callMethod('HapticFeedback_selection', []);
    } catch (e) {
      print('Ошибка вибрации selection: $e');
    }
  }

  /// Закрывает приложение
  static void close() {
    try {
      js.context['Telegram']?['WebApp']?.callMethod('close', []);
    } catch (e) {
      print('Ошибка закрытия приложения: $e');
    }
  }

  /// Показывает кнопку "Готово" (для iOS)
  static void showMainButton(String text) {
    try {
      final mainButton = js.context['Telegram']?['WebApp']?['MainButton'];
      mainButton?['text'] = text;
      mainButton?.callMethod('show', []);
    } catch (e) {
      print('Ошибка показа кнопки: $e');
    }
  }

  /// Скрывает кнопку "Готово"
  static void hideMainButton() {
    try {
      js.context['Telegram']?['WebApp']?['MainButton']?.callMethod('hide', []);
    } catch (e) {
      print('Ошибка скрытия кнопки: $e');
    }
  }

  /// Проверяет, что приложение работает в Telegram
  static bool isInTelegram() {
    try {
      return js.context['Telegram'] != null && 
             js.context['Telegram']?['WebApp'] != null;
    } catch (e) {
      return false;
    }
  }

  /// Получает версию Telegram Web App
  static String? getWebAppVersion() {
    try {
      return js.context['Telegram']?['WebApp']?['version'];
    } catch (e) {
      print('Ошибка получения версии: $e');
    }
    return null;
  }

  /// Показывает popup-уведомление
  static void showPopup(String text) {
    try {
      js.context['Telegram']?['WebApp']?.callMethod('showPopup', [
        {'text': text}
      ]);
    } catch (e) {
      print('Ошибка показа popup: $e');
    }
  }

  /// Показывает alert
  static void showAlert(String text) {
    try {
      js.context['Telegram']?['WebApp']?.callMethod('showAlert', [text]);
    } catch (e) {
      print('Ошибка показа alert: $e');
    }
  }

  /// Показывает confirm диалог
  static void showConfirm(String text, Function(bool) callback) {
    try {
      js.context['Telegram']?['WebApp']?.callMethod('showConfirm', [text]);
    } catch (e) {
      print('Ошибка показа confirm: $e');
    }
  }

  /// Отправляет данные боту
  static void sendData(String data) {
    try {
      js.context['Telegram']?['WebApp']?.callMethod('sendData', [data]);
    } catch (e) {
      print('Ошибка отправки данных: $e');
    }
  }

  /// Проверяет, включен ли режим расширения (раскрытия на весь экран)
  static bool isExpanded() {
    try {
      return js.context['Telegram']?['WebApp']?['isExpanded'] ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Раскрывает приложение на весь экран
  static void expand() {
    try {
      js.context['Telegram']?['WebApp']?.callMethod('expand', []);
    } catch (e) {
      print('Ошибка раскрытия приложения: $e');
    }
  }

  /// Получает высоту safe area (область без системных элементов)
  static double getSafeAreaInset() {
    try {
      final inset = js.context['Telegram']?['WebApp']?['safeAreaInset'];
      return (inset?['top'] ?? 0).toDouble();
    } catch (e) {
      return 0.0;
    }
  }
}
