import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:smart_yoga_mat/common/models/session_model.dart';
import 'package:smart_yoga_mat/services/firestore_service.dart'; // Simulated import

class Session {
  final String sessionType;
  final String duration;
  final String date;
  final String matTemp;
  final String heartRateZone;
  final String calories;

  Session({
    required this.sessionType,
    required this.duration,
    required this.date,
    required this.matTemp,
    required this.heartRateZone,
    required this.calories,
  });
}

class AppState with ChangeNotifier {
  bool _isConnected = false;
  String? _deviceName;
  String _connectedDevice = '';
  DiscoveredDevice? _device; // Simulated BLE device
  List<Session> _sessions = [];
  final FirestoreService _firestoreService = FirestoreService();

  bool get isConnected => _isConnected;
  String? get deviceName => _deviceName;
  String get connectedDevice => _connectedDevice;
  List<Session> get sessions => _sessions;


  

  void connectToDevice(DiscoveredDevice device) async {
    try {
      // Simulate establishing a BLE connection
      // In a real app: Connection handled in ConnectionScreen
      await Future.delayed(const Duration(seconds: 1));

      _isConnected = true;
      _deviceName = device.name.isNotEmpty ? device.name : device.id;
      _device = device;
      notifyListeners();
    } catch (e) {
      _isConnected = false;
      _deviceName = null;
      _device = null;
      notifyListeners();
      throw Exception('Failed to establish BLE connection: $e');
    }
  }

  void disconnectDevice() async {
    try {
      // Simulate closing the BLE connection
      // In a real app: Disconnection handled in ConnectionScreen
      await Future.delayed(const Duration(seconds: 1));

      _isConnected = false;
      _deviceName = null;
      _device = null;
      notifyListeners();
    } catch (e) {
      // Log error but proceed with state update
      _isConnected = false;
      _deviceName = null;
      _device = null;
      notifyListeners();
    }
  }

  void setConnectionStatus(bool status, String device) {
    _isConnected = status;
    _connectedDevice = device;
    notifyListeners();
  }

  Future<void> addSession(SessionModel session) async {
    await _firestoreService.addSession(session);
  }
}
