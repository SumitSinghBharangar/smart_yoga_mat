import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_yoga_mat/features/control/session_detil_screen.dart';
import 'package:smart_yoga_mat/features/utils/utils.dart';
import 'package:smart_yoga_mat/provider/app_state.dart';

class ControlPanelScreen extends StatefulWidget {
  const ControlPanelScreen({super.key});

  @override
  State<ControlPanelScreen> createState() => _ControlPanelScreenState();
}

class _ControlPanelScreenState extends State<ControlPanelScreen> {
  double _temperature = 30.0; // Default temperature
  bool _isWarmUpMode = false;
  bool _isRelaxationMode = false;
  bool _isLoading = true;
  String? _errorMessage;
  Map<String, dynamic>? _todayProgress;

  @override
  void initState() {
    super.initState();
    _fetchTodayProgress();
  }

  void _fetchTodayProgress() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _todayProgress = null;
    });

    try {
      final appState = Provider.of<AppState>(context, listen: false);
      if (!appState.isConnected) {
        throw Exception(
            'Not connected to the mat. Please connect and try again.');
      }

      // Simulate fetching today's progress data with a delay
      await Future.delayed(const Duration(seconds: 1));

      // Simulate a potential error (e.g., 20% chance of failure)
      if (DateTime.now().millisecond % 5 == 0) {
        throw Exception('Failed to load today\'s progress. Please try again.');
      }

      // Simulate fetched data (in a real app, this would come from the mat via Bluetooth)
      setState(() {
        _todayProgress = {
          'sessions': 2,
          'duration': '45 min',
          'calories': '120 kcal',
        };
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  void _startSession(String sessionType) async {
    final appState = Provider.of<AppState>(context, listen: false);
    if (!appState.isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not connected to the mat. Please connect first.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Simulate sending a command to the mat via Bluetooth to start the session
      // In a real app: appState.connection?.write("START_SESSION:$sessionType");
      await Future.delayed(const Duration(seconds: 1));

      appState.addSession(
        sessionType: sessionType,
        duration: '30 min', // Simulated duration
        date: DateTime.now().toString(),
        matTemp: _temperature.toStringAsFixed(1),
        heartRateZone: 'Moderate', // Simulated heart rate zone
        calories: '100', // Simulated calories
      );

      // Show a confirmation snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$sessionType session started!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to Session Details screen to view the updated session list
      Utils.go(
        context: context,
        screen: const SessionDetailsScreen(),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to start session: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _applyTemperature() async {
    final appState = Provider.of<AppState>(context, listen: false);
    if (!appState.isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not connected to the mat. Please connect first.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Simulate sending the temperature setting to the mat via Bluetooth
      // In a real app: appState.connection?.write("SET_TEMP:$_temperature");
      await Future.delayed(const Duration(seconds: 1));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Temperature set to ${_temperature.toStringAsFixed(1)}°C'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to set temperature: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

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
                  'Control Panel',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  appState.isConnected
                      ? 'Connected to: ${appState.deviceName ?? "Unknown Device"}'
                      : 'Not connected to any device',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
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
                          onPressed: _fetchTodayProgress,
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
                else if (_todayProgress == null)
                  const Center(
                    child: Text(
                      'No progress data available',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sessions: ${_todayProgress!['sessions']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Duration: ${_todayProgress!['duration']}'),
                            Text('Calories: ${_todayProgress!['calories']}'),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Utils.go(
                              context: context,
                              screen: const SessionDetailsScreen(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('View Details'),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
                const Text(
                  'Temperature Control',
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
                            'Mat Temperature: ${_temperature.toStringAsFixed(1)}°C',
                            style: const TextStyle(color: Colors.white),
                          ),
                          Slider(
                            value: _temperature,
                            min: 20,
                            max: 40,
                            divisions: 20,
                            label: _temperature.toStringAsFixed(1),
                            onChanged: (value) {
                              setState(() {
                                _temperature = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _applyTemperature,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Apply'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Session Modes',
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
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isWarmUpMode = true;
                            _isRelaxationMode = false;
                          });
                          _startSession('Warm-Up');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isWarmUpMode ? Colors.green : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Warm-Up Mode'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isWarmUpMode = false;
                            _isRelaxationMode = true;
                          });
                          _startSession('Relaxation');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isRelaxationMode ? Colors.green : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Relaxation Mode'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
