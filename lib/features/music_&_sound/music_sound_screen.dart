import 'package:flutter/material.dart';

class MusicSoundScreen extends StatefulWidget {
  const MusicSoundScreen({super.key});

  @override
  State<MusicSoundScreen> createState() => _MusicSoundScreenState();
}

class _MusicSoundScreenState extends State<MusicSoundScreen> {
  double _masterVolume = 75.0;
  double _breathingVolume = 70.0;
  double _oceanVolume = 50.0;
  double _forestVolume = 60.0;
  bool _isPlaying = false;

  void _stopAll() {
    setState(() {
      _isPlaying = false;
      _breathingVolume = 0.0;
      _oceanVolume = 0.0;
      _forestVolume = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Music & Sounds',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create the perfect atmosphere for your practice',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Master Controls',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Master Volume: 75%',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Slider(
                            value: _masterVolume,
                            min: 0,
                            max: 100,
                            onChanged: (value) {
                              setState(() {
                                _masterVolume = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _stopAll,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Stop All',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Preset Modes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: [
                    _buildPresetButton('Custom Mix', Colors.blue),
                    _buildPresetButton('Morning Flow', Colors.grey),
                    _buildPresetButton('Evening Calm', Colors.grey),
                    _buildPresetButton('Deep Focus', Colors.grey),
                  ],
                ),
                const SizedBox(height: 20),
                _buildSoundCard(
                    'BR',
                    'Breathing Exercise',
                    'Guided breathing patterns',
                    _breathingVolume,
                    Colors.green, (value) {
                  setState(() {
                    _breathingVolume = value;
                    _isPlaying = true;
                  });
                }),
                _buildSoundCard('WV', 'Ocean Waves', 'Calming ocean sounds',
                    _oceanVolume, Colors.blue, (value) {
                  setState(() {
                    _oceanVolume = value;
                    _isPlaying = true;
                  });
                }),
                _buildSoundCard('FR', 'Forest Ambient', 'Nature sounds & birds',
                    _forestVolume, Colors.green, (value) {
                  setState(() {
                    _forestVolume = value;
                    _isPlaying = true;
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPresetButton(String label, Color color) {
    return ElevatedButton(
      onPressed: () {
        // Preset logic will be added later
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildSoundCard(String iconLabel, String title, String subtitle,
      double volume, Color playColor, Function(double) onVolumeChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(7)),
            child: Center(
                child: Text(iconLabel,
                    style: const TextStyle(color: Colors.blue))),
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
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Volume: ${volume.toInt()}%',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Slider(
                            value: volume,
                            min: 0,
                            max: 100,
                            onChanged: onVolumeChanged,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(volume > 0 ? Icons.play_arrow : Icons.pause,
                          color: playColor),
                      onPressed: () {
                        onVolumeChanged(volume > 0 ? 0 : 50);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
