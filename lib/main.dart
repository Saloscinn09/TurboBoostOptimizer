import 'package:flutter/material.dart';

void main() {
  runApp(const TurboBoostApp());
}

class TurboBoostApp extends StatelessWidget {
  const TurboBoostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turbo Boost Optimizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.dark(
          primary: Colors.blueAccent,
          secondary: Colors.cyanAccent,
          surface: const Color(0xFF1E1E1E),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isOptimizing = false;
  String _statusText = 'Sistema pronto para otimização';

  void _startOptimization() {
    setState(() {
      _isOptimizing = true;
      _statusText = 'Limpando cache e otimizando RAM...';
    });

    // Simulação rápida de processo (depois vamos integrar as funções reais)
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isOptimizing = false;
        _statusText = 'Otimização concluída com sucesso!';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turbo Boost Optimizer'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.speed,
              size: 80,
              color: Colors.cyanAccent,
            ),
            const SizedBox(height: 20),
            Text(
              _statusText,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _isOptimizing
                ? const CircularProgressIndicator(color: Colors.cyanAccent)
                : ElevatedButton.icon(
                    onPressed: _startOptimization,
                    icon: const Icon(Icons.bolt),
                    label: const Text(
                      'OTIMIZAR AGORA',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
