import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// import 'package:provider/provider.dart';
import 'package:smart_yoga_mat/features/splash/splash_screen.dart';
import 'package:smart_yoga_mat/provider/app_state.dart';

class BleService {
  static final FlutterReactiveBle _flutterReactiveBle = FlutterReactiveBle();
  static FlutterReactiveBle get instance => _flutterReactiveBle;

  // Initialize BLE service
  static Future<void> initialize() async {
    try {
      // Check BLE status first
      BleStatus status = await _flutterReactiveBle.statusStream.first;
      print('BLE Status: $status');

      if (status == BleStatus.ready) {
        print('BLE is ready');
      } else {
        print('BLE is not ready: $status');
      }
    } catch (e) {
      print('Error initializing BLE: $e');
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BleService.initialize();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) {
          return MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
