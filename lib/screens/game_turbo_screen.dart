import 'package:flutter/material.dart';
import '../models/game_profile.dart';

class GameTurboScreen extends StatefulWidget {
  const GameTurboScreen({super.key});

  @override
  State<GameTurboScreen> createState() => _GameTurboScreenState();
}

class _GameTurboScreenState extends State<GameTurboScreen> {
  final List<GameProfile> _games = [
    GameProfile(
      id: '1',
      name: 'Free Fire - Alto Desempenho',
      packageName: 'com.dts.freefireth',
      doNotDisturb: true,
      keepScreenOn: true,
    ),
    GameProfile(
      id: '2',
      name: 'Exemplo de Jogo / Outro',
      packageName: 'com.exemplo.jogo',
      doNotDisturb: false,
      keepScreenOn: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Turbo & Free Fire'),
        backgroundColor: const Color(0xFF1E293B),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _games.length,
        itemBuilder: (context, index) {
          final game = _games[index];
          return Card(
            color: const Color(0xFF1E293B),
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(game.name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      const Icon(Icons.bolt, color: Color(0xFF38BDF8)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Pacote: ${game.packageName}', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                  const Divider(color: Colors.white12, height: 20),
                  SwitchListTile(
                    title: const Text('Não Perturbe durante a sessão', style: TextStyle(fontSize: 14)),
                    value: game.doNotDisturb,
                    activeColor: const Color(0xFF22C55E),
                    onChanged: (val) {
                      setState(() {
                        game.doNotDisturb = val;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Manter Tela Ligada', style: TextStyle(fontSize: 14)),
                    value: game.keepScreenOn,
                    activeColor: const Color(0xFF22C55E),
                    onChanged: (val) {
                      setState(() {
                        game.keepScreenOn = val;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Iniciando ${game.name} com perfil otimizado!')),
                      );
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('INICIAR JOGO'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF38BDF8),
                      foregroundColor: const Color(0xFF0F172A),
                      minimumSize: const Size(double.infinity, 44),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
