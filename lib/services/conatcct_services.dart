import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_exam/services/auth_services.dart';

class ContactService {
  ContactService._();

  static ContactService contactService = ContactService._();

  final _fireStore = FirebaseFirestore.instance;

  Future<void> addContactInFireStore(
      {required int id,
      required String name,
      required String phoneNo,
      required String email}) async {
    await _fireStore
        .collection('users')
        .doc(AuthServices.authServices.getCurrentUser()!.email)
        .collection('contact')
        .doc(id.toString())
        .set({'id': id, 'name': name, 'phoneNo': phoneNo, 'email': email});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readContactInStore() {
    return _fireStore
        .collection('users')
        .doc(AuthServices.authServices.getCurrentUser()!.email)
        .collection('contact')
        .snapshots();
  }
}
