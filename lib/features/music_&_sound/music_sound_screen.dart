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
  bool _isBreathingPlaying = false;
  bool _isOceanPlaying = false;
  bool _isForestPlaying = false;
  bool _isLoading = true;
  String? _errorMessage;
  bool _canTapPlayPause = true; // Debounce control
  String selectedPreset = 'Custom Mix';

  @override
  void initState() {
    super.initState();
    _fetchSoundData();
  }

  void _fetchSoundData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Simulate fetching sound data or presets with a delay
      await Future.delayed(const Duration(seconds: 1));

      // Simulate a potential error (e.g., 20% chance of failure)
      if (DateTime.now().millisecond % 5 == 0) {
        throw Exception('Failed to load sound data. Please try again.');
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  void _stopAll() {
    setState(() {
      _isBreathingPlaying = false;
      _isOceanPlaying = false;
      _isForestPlaying = false;
      _breathingVolume = 0.0;
      _oceanVolume = 0.0;
      _forestVolume = 0.0;
    });
  }

  void _applyPreset(String preset) {
    setState(() {
      selectedPreset = preset; // Track the selected preset

      switch (preset) {
        case 'Morning Flow':
          _breathingVolume = 80.0;
          _oceanVolume = 30.0;
          _forestVolume = 20.0;
          _isBreathingPlaying = true;
          _isOceanPlaying = true;
          _isForestPlaying = true;
          break;
        case 'Evening Calm':
          _breathingVolume = 20.0;
          _oceanVolume = 70.0;
          _forestVolume = 40.0;
          _isBreathingPlaying = true;
          _isOceanPlaying = true;
          _isForestPlaying = true;
          break;
        case 'Deep Focus':
          _breathingVolume = 50.0;
          _oceanVolume = 20.0;
          _forestVolume = 60.0;
          _isBreathingPlaying = true;
          _isOceanPlaying = true;
          _isForestPlaying = true;
          break;
        case 'Custom Mix':
        default:
          // Reset to custom mix - user can adjust manually
          // Optionally set default values or keep current settings
          break;
      }
    });
  }

  void _debouncePlayPause(Function action) async {
    if (!_canTapPlayPause) return;
    setState(() {
      _canTapPlayPause = false;
    });
    action();
    await Future.delayed(const Duration(milliseconds: 500)); // 500ms debounce
    setState(() {
      _canTapPlayPause = true;
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
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                else if (_errorMessage != null)
                  Center(
                    child: Column(
                      children: [
                        Text(
                          _errorMessage!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _fetchSoundData,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                else ...[
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
                            Text(
                              'Master Volume: ${_masterVolume.toInt()}%',
                              style: const TextStyle(color: Colors.white),
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
                  Column(
                    children: [
                      Row(
                        children: [
                          _buildPresetButton('Custom Mix', Colors.grey),
                          _buildPresetButton('Morning Flow', Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 8), // Space between rows
                      Row(
                        children: [
                          _buildPresetButton('Evening Calm', Colors.grey),
                          _buildPresetButton('Deep Focus', Colors.grey),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSoundCard(
                    'BR',
                    'Breathing Exercise',
                    'Guided breathing patterns',
                    _breathingVolume,
                    Colors.green,
                    (value) {
                      setState(() {
                        _breathingVolume = value;
                        _isBreathingPlaying = value > 0;
                      });
                    },
                    _isBreathingPlaying,
                  ),
                  _buildSoundCard(
                    'WV',
                    'Ocean Waves',
                    'Calming ocean sounds',
                    _oceanVolume,
                    Colors.blue,
                    (value) {
                      setState(() {
                        _oceanVolume = value;
                        _isOceanPlaying = value > 0;
                      });
                    },
                    _isOceanPlaying,
                  ),
                  _buildSoundCard(
                    'FR',
                    'Forest Ambient',
                    'Nature sounds & birds',
                    _forestVolume,
                    Colors.green,
                    (value) {
                      setState(() {
                        _forestVolume = value;
                        _isForestPlaying = value > 0;
                      });
                    },
                    _isForestPlaying,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPresetButton(String label, Color color) {
    bool isSelected = selectedPreset == label;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              selectedPreset = label;
            });
            _applyPreset(label);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: isSelected ? Colors.lightGreen.shade200 : color,
              border: Border.all(
                color: isSelected ? Colors.green.shade800 : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.green.shade800 : Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSoundCard(
      String iconLabel,
      String title,
      String subtitle,
      double volume,
      Color playColor,
      Function(double) onVolumeChanged,
      bool isPlaying) {
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
                            style: const TextStyle(color: Colors.white),
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
                      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                          color: playColor),
                      onPressed: () => _debouncePlayPause(() {
                        onVolumeChanged(isPlaying ? 0 : 50);
                      }),
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
