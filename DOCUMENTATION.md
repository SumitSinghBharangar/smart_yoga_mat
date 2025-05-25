# SmartYogaMat App Documentation

## Overview

The SmartYogaMat app is a Flutter-based mobile application that connects to a Smart Yoga Mat via Bluetooth Low Energy (BLE). It allows users to connect to the mat, control its settings (e.g., temperature, session mode), and track their yoga progress.

## Approach

- **Architecture**: Used a clean architecture approach with separation of concerns:
  - `lib/features/`: UI screens (Home, Connection, Control Panel).
  - `lib/provider/`: State management using Provider.
  - `lib/utils/`: Utility functions for navigation.
- **Bluetooth Integration**: Integrated `flutter_reactive_ble` for BLE connectivity, with simulated logic for testing.
- **State Management**: Used Provider to manage connection state and session data.

## Technologies Used

- **Flutter/Dart**: For cross-platform app development (Flutter 3.6.0, Dart 3.6.0).
- **flutter_reactive_ble**: For BLE communication.
- **permission_handler**: To manage Bluetooth and location permissions.
- **provider**: For state management.
- **Android/iOS**: Configured platform-specific settings for BLE.

## Challenges Faced and Solutions

- **Challenge**: Initial use of `flutter_bluetooth_serial` led to compatibility issues.
  - **Solution**: Switched to `flutter_reactive_ble` for better support and null safety.
- **Challenge**: Testing BLE without a physical mat.
  - **Solution**: Implemented simulated BLE logic with predefined devices ("SmartYogaMat-001", "SmartYogaMat-002").
- **Challenge**: Managing permissions across platforms.
  - **Solution**: Used `permission_handler` to request permissions on the Home Screen, ensuring a smooth user experience.

## Unique/Creative Choices

- **Simulated BLE Logic**: To facilitate development and testing without a physical mat, I implemented simulated BLE scanning and connection logic. This allowed for UI and state management testing.
- **Progress Tracking**: Added a `_calculateTodayProgress` method in `AppState` to track daily yoga progress based on sessions, providing a percentage of completion against a daily goal.
- **Dark Theme UI**: Chose a consistent dark theme (black background, white/grey text) to create a calming, yoga-appropriate aesthetic.

## Reasoning

- **Simulated BLE**: Essential for development without hardware, ensuring the app’s core functionality could be tested and demonstrated.
- **Progress Tracking**: Enhances user engagement by providing feedback on their yoga practice, encouraging daily consistency.
- **Dark Theme**: Aligns with the calming nature of yoga, reducing eye strain during practice.
