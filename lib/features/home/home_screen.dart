import 'package:flutter/material.dart';
import 'package:smart_yoga_mat/common/buttons/dynamic_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
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
              const SizedBox(height: 20),
              const Text(
                "• Custom Heating\n• Bluetooth / Wi-Fi\n• Real-time Progress",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const Spacer(),
              Center(
                  child: DynamicButton.fromText(
                text: "Connect to mat",
                onPressed: () {},
              )),
            ],
          ),
        ),
      ),
    );
  }
}
