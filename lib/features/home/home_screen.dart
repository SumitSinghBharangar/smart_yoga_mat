import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:smart_yoga_mat/features/connectons/screens/connection_screen.dart';
import 'package:smart_yoga_mat/features/control/control_panel_screen.dart';
import 'package:smart_yoga_mat/features/utils/utils.dart';
import 'package:smart_yoga_mat/provider/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _requestBluetoothPermissions(BuildContext context) async {
    try {
      // Request necessary permissions for BLE (Android only, iOS handles automatically)
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetooth,
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.locationWhenInUse, // Needed for BLE scanning on Android
      ].request();

      // Check if any permissions are denied
      bool allGranted = statuses[Permission.bluetoothScan] ==
              PermissionStatus.granted &&
          statuses[Permission.bluetoothConnect] == PermissionStatus.granted &&
          statuses[Permission.locationWhenInUse] == PermissionStatus.granted;

      if (!allGranted) {
        // Check if any permission is permanently denied
        bool isPermanentlyDenied =
            await Permission.bluetoothScan.isPermanentlyDenied ||
                await Permission.bluetoothConnect.isPermanentlyDenied ||
                await Permission.locationWhenInUse.isPermanentlyDenied;

        if (isPermanentlyDenied) {
          // Show SnackBar with action to open settings
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Bluetooth and location permissions are required. Please enable them in app settings.',
              ),
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: 'Settings',
                textColor: Colors.white,
                onPressed: () {
                  openAppSettings(); // Opens app settings
                },
              ),
            ),
          );
          return;
        }

        throw Exception(
            'Required permissions not granted. Please grant Bluetooth and location permissions to connect to the mat.');
      }

      // Navigate to Connection Screen if permissions are granted
      Utils.go(context: context, screen: const ConnectionScreen());
    } catch (e) {
      // Show error message if an error occurs
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(
        context); // Access AppState to show connection status

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'SmartYogaMat',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
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
                const SizedBox(height: 20),
                const Text(
                  'Welcome to SmartYogaMat',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  appState.isConnected
                      ? 'Connected to: ${appState.deviceName ?? "Unknown Device"}'
                      : 'Not connected to any device',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your smart companion for yoga practice.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => _requestBluetoothPermissions(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Consistent border radius
                    ),
                  ),
                  child: const Text(
                    'Connect to Mat',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Features',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                _buildFeatureCard(
                  context: context,
                  title: 'Control Panel',
                  description: 'Manage your yoga sessions and mat settings.',
                  onTap: () => Utils.go(
                      context: context, screen: const ControlPanelScreen()),
                ),
              ],
            ),
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
        padding: const EdgeInsets.all(16), // Consistent padding
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8), // Consistent border radius
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
              size: 20, // Consistent icon size
            ),
          ],
        ),
      ),
    );
  }
}
