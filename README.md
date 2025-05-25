# SmartYogaMat App

A Flutter app to connect and control a Smart Yoga Mat via Bluetooth.

## Project Description

The SmartYogaMat app allows users to connect to a Smart Yoga Mat using Bluetooth Low Energy (BLE). It provides a user-friendly interface to:
- Connect to the mat via the Connection Screen.
- Control mat settings (e.g., temperature, session modes) through the Control Panel.
- Track daily yoga progress based on completed sessions.

## Setup Instructions

### Prerequisites
- **Flutter SDK**: Version 3.6.0 or higher
- **Dart SDK**: '>=3.6.0 <4.0.0'
- **IDE**: Android Studio or VS Code with Flutter plugins installed
- **Physical Device**: An Android or iOS device for testing (emulators may not support BLE)

### Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/SumitSinghBharangar/smart_yoga_mat.git
   cd smart_yoga_mat
Install Dependencies:
Run the following command to fetch all required packages:
bash

flutter pub get
Platform Setup:
Android:
Ensure the minSdkVersion is set to 21 in android/app/build.gradle for BLE support:
gradle

minSdkVersion 21
Add the following permissions in android/app/src/main/AndroidManifest.xml:
xml

<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
iOS:
Add Bluetooth permissions in ios/Runner/Info.plist:
xml

<key>NSBluetoothAlwaysUsageDescription</key>
<string>We need to use Bluetooth to connect to your Smart Yoga Mat.</string>
<key>UIBackgroundModes</key>
<array>
    <string>bluetooth-central</string>
    <string>bluetooth-peripheral</string>
</array>
Install iOS dependencies:
bash

cd ios && pod install && cd ..
Run the App:
Connect a physical device (Android or iOS).
Run the app using:
bash

flutter run
Project Structure
lib/features/: Contains the app’s screens:
home_screen.dart: Entry point with navigation to other screens.
connection_screen.dart: Handles BLE device scanning and connection.
control_panel_screen.dart: Manages mat settings.
lib/provider/: State management:
app_state.dart: Manages connection state and session data.
lib/utils/: Utility functions:
utils.dart: Navigation helper.
Notes
Simulated BLE: The app uses simulated BLE logic for testing (predefined devices: "SmartYogaMat-001", "SmartYogaMat-002"). To use real BLE, uncomment the BLE scanning and connection code in connection_screen.dart.
Progress Tracking: The app tracks daily yoga progress in AppState using _calculateTodayProgress, based on sessions completed today (May 25, 2025) against a goal of 3 sessions.
Testing: Ensure Bluetooth and location services are enabled on your device for BLE functionality.
Troubleshooting
If the app fails to build, run:
bash

flutter clean
flutter pub get
