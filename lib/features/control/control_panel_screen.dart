import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_yoga_mat/common/models/session_model.dart';
import 'package:smart_yoga_mat/features/control/session_detil_screen.dart';
import 'package:smart_yoga_mat/features/music_&_sound/music_sound_screen.dart';
import 'package:smart_yoga_mat/provider/app_state.dart';

class ControlPanelScreen extends StatefulWidget {
  const ControlPanelScreen({super.key});

  @override
  State<ControlPanelScreen> createState() => _ControlPanelScreenState();
}

class _ControlPanelScreenState extends State<ControlPanelScreen> {
  bool _isSessionActive = false;
  String _activeSession = '';
  String _sessionDetails = '';
  final String _matTemp = '78°F';
  final String _heartRateZone = 'Light';
  final String _duration = '8 minutes';
  final String _calories = '45';
  DateTime _startTime = DateTime.now();

  void _startSession(String session) {
    setState(() {
      _isSessionActive = true;
      _activeSession = session;
      _startTime = DateTime.now();
      _sessionDetails =
          '$session Session Active\nMat Temperature: $_matTemp • Duration: $_duration\nHeart Rate Zone: $_heartRateZone • Calories: $_calories';
    });
  }

  void _stopSession() {
    final appState = Provider.of<AppState>(context, listen: false);
    final endTime = DateTime.now();
    final durationMinutes = endTime.difference(_startTime).inMinutes.toString();

    // Create a SessionModel instance
    final session = SessionModel(
      sessionType: _activeSession,
      duration: '$durationMinutes minutes',
      calories: _calories,
      date: endTime.toString(),
      matTemp: _matTemp,
      heartRateZone: _heartRateZone,
      createdAt: endTime,
      id: '', // Will be set by FirestoreService
    );

    // Save to Firestore via Provider
    appState.addSession(session);

    setState(() {
      _isSessionActive = false;
      _activeSession = '';
      _sessionDetails = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Back to Home Screen
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.music_note, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MusicSoundScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green, // Adjusted for dark theme
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Connected to ${appState.connectedDevice}',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Choose Your Session',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                _buildSessionCard(
                  'Warm-Up Mode',
                  'Gentle warm-up stretch routine to prepare your body',
                  Colors.orange,
                  '40%',
                  '+ 5 min remaining',
                  () => _startSession('Warm-Up'),
                ),
                const SizedBox(height: 10),
                _buildSessionCard(
                  'Relaxation Mode',
                  'Calming vibrations and cooling to ease tension and stress',
                  Colors.blue,
                  '',
                  '',
                  () => _startSession('Relaxation'),
                ),
                const SizedBox(height: 20),
                if (_isSessionActive)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SessionDetailsScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[900], // Adjusted for dark theme
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _sessionDetails,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _stopSession,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.red[900], // Adjusted for dark theme
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Stop',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                const Text(
                  'Today’s Progress',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildProgressCard('3', 'Sessions', Colors.grey[800]!),
                    _buildProgressCard('45m', 'Practice', Colors.grey[800]!),
                    _buildProgressCard('287', 'Calories', Colors.grey[800]!),
                    _buildProgressCard('85°F', 'Max Temp', Colors.grey[800]!),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSessionCard(String title, String subtitle, Color progressColor,
      String progress, String remaining, VoidCallback onStart) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
        ), // Adjusted for dark theme
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.circular(5)),
                // Adjusted for dark theme
                child: const Icon(Icons.fitness_center, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (progress.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.4,
                    backgroundColor:
                        Colors.grey[600], // Adjusted for dark theme
                    valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Progress: $progress',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              remaining,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onStart,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900], // Adjusted for dark theme
              minimumSize: const Size(double.infinity, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Begin $title',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
