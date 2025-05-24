import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_yoga_mat/common/models/session_model.dart';

class FirestoreService {
  final CollectionReference sessions =
      FirebaseFirestore.instance.collection('sessions');

  Future<void> addSession(SessionModel session) async {
    final docRef = await sessions.add(session.toMap());
    await docRef.update({'id': docRef.id}); // Set the document ID in the data
  }

  Stream<List<SessionModel>> getSessions() {
    return sessions
        .orderBy('createdAt', descending: true)
        .limit(5)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                SessionModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }
}
