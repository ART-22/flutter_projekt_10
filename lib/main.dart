
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Віджет без стану
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Практична робота №7',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const ConfiguratorPage(),
    );
  }
}

// Віджет зі станом
class ConfiguratorPage extends StatefulWidget {
  const ConfiguratorPage({super.key});

  @override
  State<ConfiguratorPage> createState() =>
      _ConfiguratorPageState();
}

class _ConfiguratorPageState
    extends State<ConfiguratorPage> {

  double _topLeft = 0;
  double _topRight = 0;
  double _bottomLeft = 0;
  double _bottomRight = 0;

  // Скидання налаштувань
  void _reset() {
    setState(() {
      _topLeft = 0;
      _topRight = 0;
      _bottomLeft = 0;
      _bottomRight = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Конфігуратор Container'),
        backgroundColor: Colors.blue.shade100,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Практична робота №7',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Варіант 2 — налаштування кутів',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Контейнер попереднього перегляду
            Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_topLeft),
                    topRight: Radius.circular(_topRight),
                    bottomLeft:
                    Radius.circular(_bottomLeft),
                    bottomRight:
                    Radius.circular(_bottomRight),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            CornerSlider(
              title: 'Верхній лівий кут',
              value: _topLeft,
              onChanged: (value) {
                setState(() => _topLeft = value);
              },
            ),

            CornerSlider(
              title: 'Верхній правий кут',
              value: _topRight,
              onChanged: (value) {
                setState(() => _topRight = value);
              },
            ),

            CornerSlider(
              title: 'Нижній лівий кут',
              value: _bottomLeft,
              onChanged: (value) {
                setState(() => _bottomLeft = value);
              },
            ),

            CornerSlider(
              title: 'Нижній правий кут',
              value: _bottomRight,
              onChanged: (value) {
                setState(() => _bottomRight = value);
              },
            ),

            const SizedBox(height: 15),

            ElevatedButton.icon(
              onPressed: _reset,
              icon: const Icon(Icons.refresh),
              label: const Text('Скинути налаштування'),
            ),
          ],
        ),
      ),
    );
  }
}

// Повторно використовуваний StatelessWidget
class CornerSlider extends StatelessWidget {
  final String title;
  final double value;
  final ValueChanged<double> onChanged;

  const CornerSlider({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(
              '${value.round()} px',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: 0,
          max: 75,
          divisions: 75,
          label: '${value.round()}',
          onChanged: onChanged,
        ),
      ],
    );
  }
}
