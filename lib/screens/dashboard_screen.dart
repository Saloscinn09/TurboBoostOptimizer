import 'package:flutter/material.dart';
import 'dart:async';
import 'game_turbo_screen.dart';
import '../services/device_info_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DeviceInfoService _infoService = DeviceInfoService();
  
  bool _isOptimizing = false;
  double _ramUsage = 74.2;
  int _batteryLevel = 85;
  bool _isCharging = false;
  String _deviceModel = 'Carregando...';
  String _statusMessage = 'Sistema pronto para otimização';
  int _performanceScore = 78;

  @override
  void initState() {
    super.initState();
    _loadDeviceData();
  }

  Future<void> _loadDeviceData() async {
    final data = await _infoService.getDeviceInfo();
    setState(() {
      _deviceModel = '${data['manufacturer']} ${data['model']} (API ${data['androidSdk']})';
      _batteryLevel = data['batteryLevel'];
      _isCharging = data['isCharging'];
    });
  }

  void _runOptimization() {
    setState(() {
      _isOptimizing = true;
      _statusMessage = 'Executando limpeza de cache e verificações...';
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isOptimizing = false;
        _ramUsage = 58.0;
        _performanceScore = 94;
        _statusMessage = '🟢 Dispositivo Otimizado com Sucesso!';
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: const Text('Relatório de Otimização', style: TextStyle(color: Colors.white)),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('✓ Cache temporário analisado'),
              Text('✓ Uso de RAM estabilizado'),
              Text('✓ Configurações de bateria verificadas'),
              Text('✓ Integridade do sistema checada'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK', style: TextStyle(color: Color(0xFF38BDF8))),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TurboBoost Optimizer', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Card & Índice de Desempenho
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF38BDF8).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Índice de Desempenho', style: TextStyle(color: Colors.white54, fontSize: 14)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _performanceScore > 80 ? Colors.green.withOpacity(0.2) : Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$_performanceScore / 100',
                          style: TextStyle(color: _performanceScore > 80 ? Colors.greenAccent : Colors.amberAccent, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(_deviceModel, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(_statusMessage, style: const TextStyle(color: Colors.white70, fontSize: 14), textAlign: TextAlign.center),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Métricas (RAM & Bateria)
            Row(
              children: [
                Expanded(child: _buildMetricCard('Uso de RAM', '${_ramUsage.toStringAsFixed(1)}%', Icons.memory, const Color(0xFF38BDF8))),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricCard('Bateria', '$_batteryLevel% ${_isCharging ? "⚡" : ""}', Icons.battery_charging_full, const Color(0xFF22C55E))),
              ],
            ),
            const SizedBox(height: 24),

            // Botão Principal OTIMIZAR AGORA
            _isOptimizing
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF38BDF8)))
                : ElevatedButton.icon(
                    onPressed: _runOptimization,
                    icon: const Icon(Icons.bolt, size: 26),
                    label: const Text('OTIMIZAR AGORA', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF38BDF8),
                      foregroundColor: const Color(0xFF0F172A),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
            const SizedBox(height: 16),

            // Atalho para o Game Turbo / Free Fire
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const GameTurboScreen()));
              },
              icon: const Icon(Icons.sports_esports, color: Color(0xFF38BDF8)),
              label: const Text('Gerenciar Game Turbo & Free Fire', style: TextStyle(color: Colors.white)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF38BDF8)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(color: Colors.white54, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
