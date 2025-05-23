import 'package:flutter/material.dart';
import 'package:smart_yoga_mat/features/features_and_update/product_showcase_screen.dart';
import 'package:smart_yoga_mat/features/utils/utils.dart';

class FeaturesUpdateScreen extends StatefulWidget {
  const FeaturesUpdateScreen({super.key});

  @override
  State<FeaturesUpdateScreen> createState() => _FeaturesUpdateScreenState();
}

class _FeaturesUpdateScreenState extends State<FeaturesUpdateScreen> {
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
                  'Features & Updates',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Manage your mat and discover new features',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Software Updates',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Current Version: v2.1.4',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Released: Nov 2024 • Up to date'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Check for updates logic will be added later
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Check for Updates'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your Practice Analytics',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAnalyticsCard('47', 'Total Sessions', '+12 this week',
                        Colors.blue[100]!),
                    _buildAnalyticsCard('28h', 'Practice Time', '+5h this week',
                        Colors.yellow[100]!),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAnalyticsCard(
                        '12', 'Day Streak', 'Keep it up!', Colors.green[100]!),
                    _buildAnalyticsCard('Relaxation', 'Favorite Mode',
                        '65% of sessions', Colors.purple[100]!),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Discover New Features',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                _buildFeatureCard(
                  context,
                  'AI',
                  'AI Posture Coach',
                  'Real-time posture correction',
                  'Learn More',
                  Colors.blue,
                ),
                _buildFeatureCard(
                  context,
                  'PRO',
                  'Smart Mat Pro',
                  'Advanced haptic feedback & premium zones',
                  'Upgrade',
                  Colors.green,
                ),
                _buildFeatureCard(
                  context,
                  'GRP',
                  'Group Sessions',
                  'Practice with friends in sync',
                  'Try Beta',
                  Colors.purple,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyticsCard(
      String value, String label, String subtitle, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String iconLabel, String title,
      String subtitle, String buttonLabel, Color buttonColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: Text(iconLabel,
                    style: const TextStyle(color: Colors.blue))),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Utils.go(
                context: context,
                screen: ProductShowcaseScreen(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(buttonLabel),
          ),
        ],
      ),
    );
  }
}
