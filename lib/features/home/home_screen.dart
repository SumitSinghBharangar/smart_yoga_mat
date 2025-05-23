import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_yoga_mat/common/buttons/dynamic_button.dart';
import 'package:smart_yoga_mat/common/buttons/scale_button.dart';
import 'package:smart_yoga_mat/features/connectons/screens/connection_screen.dart';
import 'package:smart_yoga_mat/features/features_and_update/features_update_screen.dart';
import 'package:smart_yoga_mat/features/utils/utils.dart';
import 'package:smart_yoga_mat/features/widgets/feature_card.dart';

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
              const Text(
                'Your intelligent companion for mindful practice',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  ScaleButton(
                    onTap: () {},
                    child: FeatureCard(
                      icon: Icons.fitness_center,
                      iconColor: Colors.amber,
                      title: 'Guided Sessions',
                      description:
                          'Personalized yoga routines with real-time feedback',
                    ),
                  ),
                  SizedBox(height: 16),
                  ScaleButton(
                    onTap: () {},
                    child: FeatureCard(
                      icon: Icons.music_note,
                      iconColor: Colors.purple,
                      title: 'Ambient Sounds',
                      description:
                          'Relaxing soundscapes to enhance your practice',
                    ),
                  ),
                  SizedBox(height: 16),
                  ScaleButton(
                    onTap: () {},
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
              const Spacer(),
              Center(
                  child: DynamicButton.fromText(
                text: "Connect to mat",
                onPressed: () {
                  Utils.go(
                    context: context,
                    screen: ConnectionScreen(),
                  );
                },
              )),
              SizedBox(
                height: 20,
              ),
              ScaleButton(
                onTap: () {
                  Utils.go(
                    context: context,
                    screen: FeaturesUpdateScreen(),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blue,
                    ),
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
              // ScaleButton(
              //   onTap: () {},
              //   child: OutlinedButton(
              //     onPressed: () {
              //       Utils.go(
              //         context: context,
              //         screen: FeaturesUpdateScreen(),
              //       );
              //     },
              //     style: OutlinedButton.styleFrom(
              //       minimumSize: const Size(double.infinity, 50),
              //       side: const BorderSide(color: Colors.blue),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //     ),
              //     child: const Text(
              //       'View Features',
              //       style: TextStyle(fontSize: 18, color: Colors.blue),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 20),
//               const Text(
//                 'Smart Yoga Mat',
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Your intelligent companion for mindful practice',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//               const SizedBox(height: 30),
//               _buildFeatureCard('Guided Sessions',
//                   'Personalized yoga routines with real-time feedback'),
//               _buildFeatureCard('Ambient Sounds',
//                   'Relaxing soundscapes to enhance your practice'),
//               _buildFeatureCard('Progress Tracking',
//                   'Monitor your yoga journey with detailed analytics'),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () {
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(builder: (_) => const ConnectionScreen()),
//                   // );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   minimumSize: const Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Connect to Mat',
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               OutlinedButton(
//                 onPressed: () {
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(builder: (_) => const FeaturesUpdatesScreen()),
//                   // );
//                 },
//                 style: OutlinedButton.styleFrom(
//                   minimumSize: const Size(double.infinity, 50),
//                   side: const BorderSide(color: Colors.blue),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'View Features',
//                   style: TextStyle(fontSize: 18, color: Colors.blue),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFeatureCard(String title, String subtitle) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             color: Colors.blue[100],
//             child: const Icon(Icons.fitness_center, color: Colors.blue),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   subtitle,
//                   style: const TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
