import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_yoga_mat/common/buttons/scale_button.dart';
import 'package:smart_yoga_mat/features/control/control_panel_screen.dart';
import 'package:smart_yoga_mat/features/utils/utils.dart';
import 'package:smart_yoga_mat/provider/app_state.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  List<Map<String, String>> _devices = [];
  bool _isScanning = false;
  String? _errorMessage;

  void _scanForDevices(String connectionType) async {
    setState(() {
      _isScanning = true;
      _devices = [];
      _errorMessage = null;
    });

    try {
      // Simulate scanning for devices with a delay
      await Future.delayed(const Duration(seconds: 2));

      // Simulate a potential error (e.g., 20% chance of failure)
      if (DateTime.now().millisecond % 5 == 0) {
        throw Exception('Failed to scan for devices. Please try again.');
      }

      setState(() {
        _isScanning = false;
        _devices = [
          {
            'name': '$connectionType SmartMat Pro - SN001',
            'details': 'Signal: Strong • Battery: 85%',
          },
          {
            'name': '$connectionType SmartMat Lite - SN002',
            'details': 'Signal: Medium • Battery: 72%',
          },
        ];
      });
    } catch (e) {
      setState(() {
        _isScanning = false;
        _errorMessage = e.toString();
      });
    }
  }

  void _pairDevice(String deviceName, AppState appState) {
    appState.setConnectionStatus(true, deviceName);
    Utils.go(
      context: context,
      screen: const ControlPanelScreen(),
    );
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
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Connect Your Mat',
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                'Make sure your mat is powered on and in pairing mode',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20.h),
              ScaleButton(
                onTap: _isScanning ? () {} : () => _scanForDevices('Bluetooth'),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: Text(
                    _isScanning ? 'Scanning...' : 'Connect via Bluetooth',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.h,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              ScaleButton(
                onTap: _isScanning ? () {} : () => _scanForDevices('Wi-Fi'),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: Text(
                    _isScanning ? 'Scanning...' : 'Connect via Wi-Fi',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.h,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              const Text(
                'Available Devices',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              _isScanning
                  ? const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            'Scanning for devices...',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    )
                  : _errorMessage != null
                      ? Center(
                          child: Column(
                            children: [
                              Text(
                                _errorMessage!,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () => _scanForDevices(
                                    'Bluetooth'), // Retry with Bluetooth as default
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
                      : _devices.isEmpty
                          ? const Center(
                              child: Text(
                                'No devices found',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : Column(
                              children: _devices.map((device) {
                                return _buildDeviceTile(
                                  context,
                                  device['name']!,
                                  device['details']!,
                                );
                              }).toList(),
                            ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.green,
                      width: 1,
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Connection Tips',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Hold the power button for 3 seconds',
                      style: TextStyle(color: Colors.white),
                    ),
                    const Text(
                      '• LED should flash blue when ready',
                      style: TextStyle(color: Colors.white),
                    ),
                    const Text(
                      '• Stay within 10 feet of your mat',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceTile(
      BuildContext context, String deviceName, String details) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            color: Colors.blue[100],
            child: const Icon(Icons.devices, color: Colors.blue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deviceName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  details,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => _pairDevice(deviceName, appState),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Pair'),
          ),
        ],
      ),
    );
  }
}
