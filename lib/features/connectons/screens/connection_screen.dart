import 'dart:typed_data'; // For Uint8List
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart'; // For BLE scanning
import 'package:smart_yoga_mat/provider/app_state.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  bool _isLoading = true;
  bool _isConnecting = false;
  String? _errorMessage;
  List<DiscoveredDevice> _devices = [];
  late FlutterReactiveBle _ble;
  List<String> _deviceNames = []; // To store device names for display
  static const String predefinedMatName =
      'SmartYogaMat-Pro'; // Predefined mat name

  @override
  void initState() {
    super.initState();
    _ble = FlutterReactiveBle();
    _checkBluetoothAndScan();
  }

  void _checkBluetoothAndScan() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _devices = [];
      _deviceNames = [];
    });

    try {
      // Check Bluetooth state (permissions should already be granted from Home Screen)
      _ble.statusStream.listen((status) {
        if (status == BleStatus.ready) {
          _scanForDevices();
        } else {
          setState(() {
            _isLoading = false;
            _errorMessage =
                'Bluetooth is not enabled. Please enable Bluetooth to continue.';
          });
        }
      }, onError: (e) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error checking Bluetooth status: $e';
        });
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  void _scanForDevices() async {
    try {
      // Real BLE scanning (uncomment for deployment on real device)
      /*
      _ble.scanForDevices(withServices: []).listen((device) {
        if (device.name == predefinedMatName && !_deviceNames.contains(device.name)) {
          setState(() {
            _devices.add(device);
            _deviceNames.add(device.name);
          });
        }
      }, onError: (e) {
        throw Exception('Failed to scan for devices: $e');
      });
      // Wait for scanning to complete (e.g., 5 seconds)
      await Future.delayed(const Duration(seconds: 5));
      */

      // Simulated scanning for predefined mat name
      await Future.delayed(const Duration(seconds: 2));

      // Simulate a potential error
      if (DateTime.now().millisecond % 5 == 0) {
        throw Exception(
            'BLE error: Failed to scan for devices. Please try again.');
      }

      setState(() {
        _isLoading = false;
        // Only show the predefined mat name
        _deviceNames = [predefinedMatName];
        _devices = _deviceNames
            .map((name) => DiscoveredDevice(
                  id: name,
                  name: name,
                  serviceData: const {},
                  manufacturerData: Uint8List(0),
                  rssi: -50,
                  serviceUuids: const [],
                ))
            .toList();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  void _connectToDevice(DiscoveredDevice device) async {
    setState(() {
      _isConnecting = true;
      _errorMessage = null;
    });

    try {
      // Real BLE connection (uncomment for deployment on real device)
      /*
      _ble.connectToDevice(id: device.id).listen((connectionState) {
        if (connectionState.connectionState == DeviceConnectionState.connected) {
          // Connection successful
          final appState = Provider.of<AppState>(context, listen: false);
          appState.connectToDevice(device);
          setState(() {
            _isConnecting = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Connected to ${device.name} via BLE'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      }, onError: (e) {
        throw Exception('Failed to connect: $e');
      });
      */

      // Simulated connection
      await Future.delayed(const Duration(seconds: 1));

      // Simulate a potential connection error
      if (DateTime.now().millisecond % 5 == 0) {
        throw Exception(
            'Failed to connect to ${device.name}. Please try again.');
      }

      final appState = Provider.of<AppState>(context, listen: false);
      appState.connectToDevice(device);

      setState(() {
        _isConnecting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connected to ${device.name} via BLE'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _isConnecting = false;
        _errorMessage = e.toString();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connection error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
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
                const SizedBox(height: 10),
                const Text(
                  'Connect to Your Mat',
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
                      : 'Find and connect to your Smart Yoga Mat',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
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
                          onPressed: _checkBluetoothAndScan,
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
                else if (_devices.isEmpty)
                  const Center(
                    child: Text(
                      'No Smart Yoga Mat found',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                else
                  Column(
                    children: _devices
                        .asMap()
                        .entries
                        .map(
                          (entry) => Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(
                              onPressed: _isConnecting
                                  ? null
                                  : () => _connectToDevice(entry.value),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[800],
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    entry.value.name,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  _isConnecting
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.bluetooth,
                                          color: Colors.blue,
                                        ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
