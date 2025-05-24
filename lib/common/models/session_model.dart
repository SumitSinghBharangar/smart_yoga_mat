import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class SessionModel {
  String sessionType;
  String duration;
  String calories;
  String date;
  String matTemp;
  String heartRateZone;
  DateTime createdAt;
  String id;

  SessionModel({
    required this.sessionType,
    required this.duration,
    required this.calories,
    required this.date,
    required this.matTemp,
    required this.heartRateZone,
    required this.createdAt,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sessionType': sessionType,
      'duration': duration,
      'calories': calories,
      'date': date,
      'matTemp': matTemp,
      'heartRateZone': heartRateZone,
      'createdAt': Timestamp.fromDate(createdAt),
      'id': id,
    };
  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return SessionModel(
      sessionType: map['sessionType'] as String,
      duration: map['duration'] as String,
      calories: map['calories'] as String,
      date: map['date'] as String,
      matTemp: map['matTemp'] as String,
      heartRateZone: map['heartRateZone'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SessionModel.fromJson(String source) =>
      SessionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
