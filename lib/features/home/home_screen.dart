import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_yoga_mat/common/buttons/dynamic_button.dart';
import 'package:smart_yoga_mat/common/buttons/scale_button.dart';
import 'package:smart_yoga_mat/features/connectons/screens/connection_screen.dart';
import 'package:smart_yoga_mat/features/control/control_panel_screen.dart';
import 'package:smart_yoga_mat/features/control/session_detil_screen.dart';
import 'package:smart_yoga_mat/features/features_and_update/features_update_screen.dart';
import 'package:smart_yoga_mat/features/music_&_sound/music_sound_screen.dart';
import 'package:smart_yoga_mat/features/utils/utils.dart';
import 'package:smart_yoga_mat/features/widgets/feature_card.dart';
import 'package:smart_yoga_mat/provider/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final recentSession =
        appState.sessions.isNotEmpty ? appState.sessions[0] : null;

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
              const Text(
                'Your intelligent companion for mindful practice',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  ScaleButton(
                    onTap: () {
                      if (appState.isConnected) {
                        Utils.go(
                          context: context,
                          screen: const ControlPanelScreen(),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please connect to your mat first'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: FeatureCard(
                      icon: Icons.fitness_center,
                      iconColor: Colors.amber,
                      title: 'Guided Sessions',
                      description:
                          'Personalized yoga routines with real-time feedback',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ScaleButton(
                    onTap: () {
                      Utils.go(
                        context: context,
                        screen: const MusicSoundScreen(),
                      );
                    },
                    child: FeatureCard(
                      icon: Icons.music_note,
                      iconColor: Colors.purple,
                      title: 'Ambient Sounds',
                      description:
                          'Relaxing soundscapes to enhance your practice',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ScaleButton(
                    onTap: () {
                      Utils.go(
                        context: context,
                        screen: const SessionDetailsScreen(),
                      );
                    },
                    child: FeatureCard(
                      icon: Icons.bar_chart,
                      iconColor: Colors.blue,
                      title: 'Progress Tracking',
                      description:
                          'Monitor your yoga journey with detailed analytics',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent Activity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recentSession != null
                          ? '${recentSession.sessionType} Session • ${recentSession.duration}'
                          : 'No recent sessions',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    if (recentSession != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Date: ${recentSession.date.split(' ')[0]} • Calories: ${recentSession.calories}',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ],
                ),
              ),
              const Spacer(),
              Center(
                child: DynamicButton.fromText(
                  text: "Connect to mat",
                  onPressed: () {
                    Utils.go(
                      context: context,
                      screen: const ConnectionScreen(),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ScaleButton(
                onTap: () {
                  Utils.go(
                    context: context,
                    screen: const FeaturesUpdateScreen(),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Text(
                    "View Features",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
