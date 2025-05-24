import 'package:flutter/material.dart';
import 'package:smart_yoga_mat/common/models/session_model.dart';

import '../services/firestore_service.dart';

class AppState with ChangeNotifier {
  bool _isConnected = false;
  String _connectedDevice = '';
  List<SessionModel> _sessions = [];
  final FirestoreService _firestoreService = FirestoreService();

  bool get isConnected => _isConnected;
  String get connectedDevice => _connectedDevice;
  List<SessionModel> get sessions => _sessions;

  AppState() {
    _firestoreService.getSessions().listen((sessionList) {
      _sessions = sessionList;
      notifyListeners();
    });
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
