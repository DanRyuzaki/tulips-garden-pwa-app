import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreErrorsController {
  static void firestoreErrorsController(String e, String source) {
    CollectionReference errorCollection =
        FirebaseFirestore.instance.collection('Errors');
    errorCollection
        .add({'exception': e, 'timestamp': DateTime.now(), 'source': source});
  }
}
