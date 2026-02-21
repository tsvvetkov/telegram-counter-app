import 'package:flutter/material.dart';
import 'dart:js' as js;
import 'dart:html' as html;

void main() {
  runApp(const TelegramMiniAppCounterApp());
}

class TelegramMiniAppCounterApp extends StatelessWidget {
  const TelegramMiniAppCounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram Counter Mini App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _counter = 0;
  bool _isLoggedIn = false;
  String _userName = '';
  String _userPhoto = '';

  @override
  void initState() {
    super.initState();
    _initializeTelegramWebApp();
  }

  void _initializeTelegramWebApp() {
    try {
      // Инициализируем Telegram Web App
      js.context.callMethod('eval', [
        '''
        if (window.Telegram && window.Telegram.WebApp) {
          window.telegramWebApp = window.Telegram.WebApp;
          window.telegramWebApp.ready();
          window.telegramWebApp.setHeaderColor('#2196F3');
          window.telegramWebApp.setBackgroundColor('#ffffff');
        }
        '''
      ]);
    } catch (e) {
      print('Ошибка инициализации Telegram: $e');
    }
  }

  void _loginWithTelegram() {
    try {
      // Проверяем доступность Telegram WebApp
      final telegramWebApp = js.context['Telegram']?['WebApp'];
      
      if (telegramWebApp != null) {
        // Получаем данные пользователя
        final initData = js.context['Telegram']['WebApp']['initDataUnsafe'];
        
        if (initData != null && initData['user'] != null) {
          final user = initData['user'];
          setState(() {
            _isLoggedIn = true;
            _userName = user['first_name'] ?? 'Пользователь';
            _userPhoto = user['photo_url'] ?? '';
          });
          
          _showSnackBar('Успешно вошли как ${_userName}!');
        } else {
          _showSnackBar('Не удалось получить данные пользователя');
        }
      } else {
        _showSnackBar('Приложение работает только в Telegram Mini App');
      }
    } catch (e) {
      print('Ошибка входа: $e');
      _showSnackBar('Ошибка при входе через Telegram');
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    
    // Вибрация обратной связи (если доступна)
    try {
      js.context['Telegram']?['WebApp']?.callMethod('HapticFeedback_light', []);
    } catch (e) {
      print('Вибрация недоступна: $e');
    }
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Counter Mini App'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue[600],
      ),
      body: SafeArea(
        child: _isLoggedIn ? _buildCounterUI() : _buildLoginUI(),
      ),
    );
  }

  Widget _buildLoginUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.telegram,
              size: 60,
              color: Colors.blue[600],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Добро пожаловать!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Войдите через Telegram',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: _loginWithTelegram,
            icon: const Icon(Icons.telegram),
            label: const Text('Вход через Telegram'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterUI() {
    return Column(
      children: [
        // Карточка профиля пользователя
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              if (_userPhoto.isNotEmpty)
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(_userPhoto),
                )
              else
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.blue[100],
                  child: Icon(
                    Icons.person,
                    color: Colors.blue[600],
                    size: 32,
                  ),
                ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Привет, $_userName!',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Нажимайте кнопку для увеличения счетчика',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Счетчик
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Счетчик нажатий',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.blue[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Кнопки управления
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _incrementCounter,
                  icon: const Icon(Icons.add),
                  label: const Text('Нажать'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _resetCounter,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Сброс'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue[600],
                        side: BorderSide(color: Colors.blue[600]!),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isLoggedIn = false;
                          _counter = 0;
                          _userName = '';
                          _userPhoto = '';
                        });
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('Выход'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red[600],
                        side: BorderSide(color: Colors.red[600]!),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
