import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smart_yoga_mat/common/buttons/scale_button.dart';
import 'package:smart_yoga_mat/features/control/control_panel_screen.dart';
import 'package:smart_yoga_mat/features/utils/utils.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
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
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                'Make sure your mat is powered on and in pairing mode',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ScaleButton(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(
                    14.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Connect via Bluetooth',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.h,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ScaleButton(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(
                    14.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: Text(
                    'Connect via Wi-Fi',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.h,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              const Text(
                'Available Devices',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              _buildDeviceTile(
                context,
                'SmartMat Pro - SN001',
                'Signal: Strong • Battery: 85%',
              ),
              _buildDeviceTile(
                context,
                'SmartMat Lite - SN002',
                'Signal: Medium • Battery: 72%',
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
                    SizedBox(height: 8),
                    Text(
                      '• Hold the power button for 3 seconds',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '• LED should flash blue when ready',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '• Stay within 10 feet of your mat',
                      style: TextStyle(
                        color: Colors.white,
                      ),
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
            onPressed: () {
              // Simulate pairing and update state
              // Provider.of<AppState>(context, listen: false)
              //     .setConnectionStatus(true, deviceName);
              // // Navigate to Control Panel Screen
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (_) => const ControlPanelScreen()),
              // );
              Utils.go(context: context, screen: ControlPanelScreen());
            },
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
