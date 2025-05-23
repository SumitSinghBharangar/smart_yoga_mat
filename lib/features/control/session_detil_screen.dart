import 'package:flutter/material.dart';

class SessionDetilScreen extends StatefulWidget {
  const SessionDetilScreen({super.key});

  @override
  State<SessionDetilScreen> createState() => _SessionDetilScreenState();
}

class _SessionDetilScreenState extends State<SessionDetilScreen> {
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
                  'Session Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Review your session stats and insights',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Session Overview',
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
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Warm-Up Session',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('Duration: 8 minutes'),
                      Text('Date: May 23, 2025'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Detailed Stats',
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
                    _buildStatCard(
                        'Mat Temperature', '78°F', Colors.orange[100]!),
                    _buildStatCard(
                        'Heart Rate Zone', 'Light', Colors.green[100]!),
                    _buildStatCard('Calories Burned', '45', Colors.blue[100]!),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Historical Trend',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                _buildTrendCard(
                    'May 22, 2025', 'Relaxation', '10 min', '55 cal'),
                _buildTrendCard('May 21, 2025', 'Warm-Up', '7 min', '40 cal'),
                _buildTrendCard(
                    'May 20, 2025', 'Relaxation', '12 min', '60 cal'),
                _buildTrendCard('May 19, 2025', 'Warm-Up', '6 min', '35 cal'),
                _buildTrendCard(
                    'May 18, 2025', 'Relaxation', '9 min', '50 cal'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
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
              label,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendCard(
      String date, String sessionType, String duration, String calories) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[800], // Dark background for white text
        border: Border.all(color: Colors.green, width: 1.5),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon to represent session type
          Icon(
            sessionType.toLowerCase().contains('warm')
                ? Icons.local_fire_department
                : Icons.spa,
            color: Colors.green,
            size: 30,
          ),
          const SizedBox(width: 12),
          // Session details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$sessionType Session',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Duration and Calories with icons
          Row(
            children: [
              const Icon(Icons.timer, color: Colors.white70, size: 20),
              const SizedBox(width: 4),
              Text(
                duration,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.local_fire_department,
                  color: Colors.white70, size: 20),
              const SizedBox(width: 4),
              Text(
                calories,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
