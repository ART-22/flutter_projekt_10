
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Практична робота №10',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// Перший екран
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController =
  TextEditingController();

  final TextEditingController _sizeController =
  TextEditingController(text: '32');

  Future<void> _openPreview() async {
    final text = _textController.text.trim();

    final fontSize = double.tryParse(
      _sizeController.text.trim().replaceAll(',', '.'),
    );

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Спочатку введіть текст'),
        ),
      );
      return;
    }

    if (fontSize == null ||
        !fontSize.isFinite ||
        fontSize < 1 ||
        fontSize > 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Введіть розмір від 1 до 200'),
        ),
      );
      return;
    }

    // Відкриваємо другий екран і чекаємо результат
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => PreviewScreen(
          text: text,
          fontSize: fontSize,
        ),
      ),
    );

    if (!context.mounted) return;

    // Визначаємо повідомлення залежно від результату
    final message = switch (result) {
      true => 'Cool!',
      false => 'Let’s try something else',
      null => "Don't know what to say",
    };

    // Показуємо діалогове вікно
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Результат'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text('Закрити'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Практична робота №10'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.text_fields,
                size: 75,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),

              const Text(
                'Налаштування тексту',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: _textController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Введіть текст',
                  hintText: 'Наприклад: Привіт, Flutter!',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.edit),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: _sizeController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Розмір шрифту',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.format_size),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: _openPreview,
                icon: const Icon(Icons.preview),
                label: const Text('Переглянути'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Другий екран
class PreviewScreen extends StatelessWidget {
  final String text;
  final double fontSize;

  const PreviewScreen({
    super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Попередній перегляд'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Ваш текст:',
                style: TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Ok'),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
