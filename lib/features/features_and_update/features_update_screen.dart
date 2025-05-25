import 'package:flutter/material.dart';
import 'package:smart_yoga_mat/features/features_and_update/product_showcase_screen.dart';
import 'package:smart_yoga_mat/features/utils/utils.dart';

class FeaturesUpdateScreen extends StatefulWidget {
  const FeaturesUpdateScreen({super.key});

  @override
  State<FeaturesUpdateScreen> createState() => _FeaturesUpdateScreenState();
}

class _FeaturesUpdateScreenState extends State<FeaturesUpdateScreen> {
  String _updateMessage = 'Up to date';
  bool _isChecking = false;
  String? _errorMessage;
  final TextEditingController _feedbackController = TextEditingController();
  bool _isSubmittingFeedback = false;

  void _checkForUpdates() async {
    setState(() {
      _isChecking = true;
      _errorMessage = null;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (DateTime.now().millisecond % 5 == 0) {
        throw Exception('Failed to check for updates. Please try again.');
      }

      const currentVersion = '2.1.4';
      const latestVersion = '2.1.5'; // Simulated latest version
      final updateAvailable = latestVersion != currentVersion;

      setState(() {
        _isChecking = false;
        _updateMessage = updateAvailable
            ? 'Update available: v$latestVersion'
            : 'No updates available';
      });

      // Show dialog with result
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[800],
          title: const Text(
            'Update Check',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            _updateMessage,
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            if (updateAvailable)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // In a real app, this would trigger the update process
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Update started...'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text(
                  'Update Now',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
          ],
        ),
      );
    } catch (e) {
      setState(() {
        _isChecking = false;
        _errorMessage = e.toString();
      });
    }
  }

  void _submitFeedback() async {
    if (_feedbackController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your feedback'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSubmittingFeedback = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (DateTime.now().millisecond % 5 == 0) {
        throw Exception(
            'Device storage is full. Please free up space and try again.');
      }

      // In a real app, you would use Firestore to store the feedback
      // Example: await FirebaseFirestore.instance.collection('feedback').add({
      //   'message': _feedbackController.text,
      //   'timestamp': DateTime.now().toString(),
      // });

      setState(() {
        _isSubmittingFeedback = false;
      });

      // Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Feedback submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      _feedbackController.clear();
    } catch (e) {
      setState(() {
        _isSubmittingFeedback = false;
      });

      // Check if the error is storage-related
      final errorMessage = e.toString().contains('storage')
          ? e.toString()
          : 'Failed to submit feedback: $e';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

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
                          children: [
                            const Text(
                              'Current Version: v2.1.4',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _errorMessage != null
                                  ? 'Error checking updates'
                                  : 'Released: Nov 2024 • $_updateMessage',
                            ),
                          ],
                        ),
                      ),
                      _errorMessage != null
                          ? ElevatedButton(
                              onPressed: _checkForUpdates,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Retry'),
                            )
                          : ElevatedButton(
                              onPressed: _isChecking ? null : _checkForUpdates,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                _isChecking
                                    ? 'Checking...'
                                    : 'Check for Updates',
                              ),
                            ),
                    ],
                  ),
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
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
                const SizedBox(height: 20),
                const Text(
                  'Share Your Feedback',
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
                    border: Border.all(color: Colors.green, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _feedbackController,
                        maxLines: 3,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Tell us about your experience...',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.green),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed:
                            _isSubmittingFeedback ? null : _submitFeedback,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          _isSubmittingFeedback
                              ? 'Submitting...'
                              : 'Submit Feedback',
                        ),
                      ),
                    ],
                  ),
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
                screen: const ProductShowcaseScreen(),
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
