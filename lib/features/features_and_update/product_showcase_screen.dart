import 'package:flutter/material.dart';

class ProductShowcaseScreen extends StatefulWidget {
  const ProductShowcaseScreen({super.key});

  @override
  State<ProductShowcaseScreen> createState() => _ProductShowcaseScreenState();
}

class _ProductShowcaseScreenState extends State<ProductShowcaseScreen> {
  void _handleButtonAction(
      String title, String dialogMessage, String buttonLabel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dialogMessage),
            const SizedBox(height: 8),
            Text(
              title == 'AI Posture Coach'
                  ? '• Analyzes your posture in real-time\n• Provides instant feedback\n• Improves alignment safely'
                  : title == 'Smart Mat Pro'
                      ? '• Enhanced haptic feedback\n• Customizable premium zones\n• Advanced heat therapy'
                      : '• Sync with friends globally\n• Join live group sessions\n• Beta access to new features',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          if (buttonLabel == 'Upgrade')
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Simulate purchase flow
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        const Text('Purchase initiated for Smart Mat Pro!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Proceed to Purchase'),
            ),
          if (buttonLabel == 'Try Beta')
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Simulate beta registration
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Registered for Group Sessions beta!'),
                    backgroundColor: Colors.purple,
                  ),
                );
              },
              child: const Text('Register for Beta'),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(
                            context); // Back to Features & Updates Screen
                      },
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Discover New Features',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Explore the latest upgrades for your Smart Yoga Mat',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                _buildProductCard(
                  context,
                  'AI Posture Coach',
                  'Real-time posture correction using AI technology',
                  'Learn More',
                  Colors.blue,
                  'Learn more about AI Posture Coach',
                ),
                _buildProductCard(
                  context,
                  'Smart Mat Pro',
                  'Advanced haptic feedback & premium zones',
                  'Upgrade',
                  Colors.green,
                  'Upgrade to Smart Mat Pro',
                ),
                _buildProductCard(
                  context,
                  'Group Sessions',
                  'Practice with friends in sync',
                  'Try Beta',
                  Colors.purple,
                  'Join the Group Sessions beta',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(
      BuildContext context,
      String title,
      String description,
      String buttonLabel,
      Color buttonColor,
      String dialogMessage) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            color: Colors.blue[50],
            child: const Center(child: Text('Image Placeholder')),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                _handleButtonAction(title, dialogMessage, buttonLabel),
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              minimumSize: const Size(double.infinity, 40),
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
