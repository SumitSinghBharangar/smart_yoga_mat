import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:smart_yoga_mat/common/buttons/dynamic_button.dart';
import 'package:smart_yoga_mat/common/buttons/scale_button.dart';

import 'package:smart_yoga_mat/features/connectons/screens/connection_screen.dart';
import 'package:smart_yoga_mat/features/control/control_panel_screen.dart';
import 'package:smart_yoga_mat/features/control/session_detil_screen.dart';
import 'package:smart_yoga_mat/features/features_and_update/features_update_screen.dart';
import 'package:smart_yoga_mat/features/music_&_sound/music_sound_screen.dart';
import 'package:smart_yoga_mat/features/utils/utils.dart';
import 'package:smart_yoga_mat/features/widgets/feature_card.dart';
import 'package:smart_yoga_mat/provider/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchRecentActivity();
  }

  void _fetchRecentActivity() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (DateTime.now().millisecond % 5 == 0) {
        throw Exception('Failed to load recent activity. Please try again.');
      }

      final appState = Provider.of<AppState>(context, listen: false);
      if (appState.sessions == null) {
        throw Exception('Failed to load sessions');
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

  Future<void> _requestBluetoothPermissions(BuildContext context) async {
    print('DEBUG: Starting Bluetooth permission request');

    try {
      // Check if context is still mounted
      if (!context.mounted) {
        print('DEBUG: Context not mounted at start');
        return;
      }

      print('DEBUG: About to request permissions');

      // Request permissions one by one to identify which one causes issues
      PermissionStatus bluetoothStatus = await Permission.bluetooth.request();
      print('DEBUG: Bluetooth permission: $bluetoothStatus');

      if (!context.mounted) {
        print('DEBUG: Context not mounted after bluetooth permission');
        return;
      }

      PermissionStatus bluetoothScanStatus =
          await Permission.bluetoothScan.request();
      print('DEBUG: Bluetooth scan permission: $bluetoothScanStatus');

      if (!context.mounted) {
        print('DEBUG: Context not mounted after bluetooth scan permission');
        return;
      }

      PermissionStatus bluetoothConnectStatus =
          await Permission.bluetoothConnect.request();
      print('DEBUG: Bluetooth connect permission: $bluetoothConnectStatus');

      if (!context.mounted) {
        print('DEBUG: Context not mounted after bluetooth connect permission');
        return;
      }

      PermissionStatus locationStatus =
          await Permission.locationWhenInUse.request();
      print('DEBUG: Location permission: $locationStatus');

      if (!context.mounted) {
        print('DEBUG: Context not mounted after location permission');
        return;
      }

      print('DEBUG: All permissions requested successfully');

      // Check if required permissions are granted
      bool allGranted = bluetoothScanStatus == PermissionStatus.granted &&
          bluetoothConnectStatus == PermissionStatus.granted &&
          locationStatus == PermissionStatus.granted;

      print('DEBUG: All permissions granted: $allGranted');

      if (!allGranted) {
        print(
            'DEBUG: Not all permissions granted, checking if permanently denied');

        // Check if any permission is permanently denied
        bool scanPermanentlyDenied =
            await Permission.bluetoothScan.isPermanentlyDenied;
        bool connectPermanentlyDenied =
            await Permission.bluetoothConnect.isPermanentlyDenied;
        bool locationPermanentlyDenied =
            await Permission.locationWhenInUse.isPermanentlyDenied;

        bool isPermanentlyDenied = scanPermanentlyDenied ||
            connectPermanentlyDenied ||
            locationPermanentlyDenied;

        print('DEBUG: Permissions permanently denied: $isPermanentlyDenied');

        // Check context again after async operation
        if (!context.mounted) {
          print('DEBUG: Context not mounted after checking permanently denied');
          return;
        }

        if (isPermanentlyDenied) {
          print('DEBUG: Showing permanently denied snackbar');
          // Use try-catch for SnackBar as well
          try {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Bluetooth and location permissions are required. Please enable them in app settings.',
                ),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Settings',
                  textColor: Colors.white,
                  onPressed: () async {
                    try {
                      await openAppSettings();
                    } catch (e) {
                      print('DEBUG: Error opening app settings: $e');
                    }
                  },
                ),
              ),
            );
          } catch (e) {
            print('DEBUG: Error showing permanently denied snackbar: $e');
          }
          return;
        }

        print('DEBUG: Throwing permission not granted exception');
        throw Exception('Required permissions not granted');
      }

      print('DEBUG: All permissions granted, proceeding to navigation');

      // Add a delay and check context before navigation
      await Future.delayed(const Duration(milliseconds: 500));

      if (!context.mounted) {
        print('DEBUG: Context not mounted before navigation');
        return;
      }

      print('DEBUG: About to navigate to ConnectionScreen');

      // Try standard navigation instead of Utils.go()
      try {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ConnectionScreen(),
          ),
        );
        print('DEBUG: Navigation successful');
      } catch (navError) {
        print('DEBUG: Navigation error: $navError');
        // Fallback: try your Utils.go method
        try {
          Utils.go(context: context, screen: const ConnectionScreen());
          print('DEBUG: Utils.go navigation successful');
        } catch (utilsError) {
          print('DEBUG: Utils.go navigation error: $utilsError');
          throw Exception('Navigation failed: $utilsError');
        }
      }
    } catch (e, stackTrace) {
      print('DEBUG: Exception caught: $e');
      print('DEBUG: Stack trace: $stackTrace');

      // Check context before showing error SnackBar
      if (!context.mounted) {
        print('DEBUG: Context not mounted for error snackbar');
        return;
      }

      try {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Permission error: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      } catch (snackBarError) {
        print('DEBUG: Error showing error snackbar: $snackBarError');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final recentSession =
        appState.sessions.isNotEmpty ? appState.sessions[0] : null;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Smart Yoga Mate",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Your intelligent companion for mindful practice',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  ScaleButton(
                    onTap: () {
                      if (appState.isConnected) {
                        Utils.go(
                          context: context,
                          screen: const ControlPanelScreen(),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please connect to your mat first'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: FeatureCard(
                      icon: Icons.fitness_center,
                      iconColor: Colors.amber,
                      title: 'Guided Sessions',
                      description:
                          'Personalized yoga routines with real-time feedback',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ScaleButton(
                    onTap: () {
                      Utils.go(
                        context: context,
                        screen: const MusicSoundScreen(),
                      );
                    },
                    child: FeatureCard(
                      icon: Icons.music_note,
                      iconColor: Colors.purple,
                      title: 'Ambient Sounds',
                      description:
                          'Relaxing soundscapes to enhance your practice',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ScaleButton(
                    onTap: () {
                      Utils.go(
                        context: context,
                        screen: const SessionDetailsScreen(),
                      );
                    },
                    child: FeatureCard(
                      icon: Icons.bar_chart,
                      iconColor: Colors.blue,
                      title: 'Progress Tracking',
                      description:
                          'Monitor your yoga journey with detailed analytics',
                    ),
                  ),
                ],
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
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _fetchRecentActivity,
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
              else
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recent Activity',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        recentSession != null
                            ? '${recentSession.sessionType} Session • ${recentSession.duration}'
                            : 'No recent sessions',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      if (recentSession != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Date: ${recentSession.date.split(' ')[0]} • Calories: ${recentSession.calories}',
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ],
                  ),
                ),
              Spacer(),
              Center(
                child: DynamicButton.fromText(
                  text: "Connect to mat",
                  onPressed: () {
                    _requestBluetoothPermissions(context);
                  },
                ),
              ),
              const SizedBox(height: 20),
              ScaleButton(
                onTap: () {
                  Utils.go(
                    context: context,
                    screen: const FeaturesUpdateScreen(),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Text(
                    "View Features",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required BuildContext context,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
