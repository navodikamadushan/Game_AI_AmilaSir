import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference deviceInfo = FirebaseFirestore.instance.collection('deviceInfo');
  final CollectionReference tf_categories = FirebaseFirestore.instance.collection('tf_categories');

  Future updateUserData(String email, String language) async {
    return await users.doc(uid).set({
      'email': email,
      'language': language,
    });
  }

  Future updateDeviceInfo(String deviceId, String language) async {
    return await deviceInfo.doc(deviceId).set({
      'language': language,
    });
  }

  // add user details to user document
  Future addUserProfileData(String currentUserId, String name, String email, String phoneno, String about) async {
    return await users.doc(currentUserId).set({
      'name': name,
      'email': email,
      'phoneno': phoneno,
      'about': about,
    });
  }

  // update to user document
  Future updateUserProfileData(String currentUserId, String name, String email, String about) async {
    return await users.doc(currentUserId).update({
      'name': name,
      'email': email,
      'about': about,
    });
  }

  // store phone number to user document
  Future updatePhoneNumbertoUserProfile(String currentUserId, String phonenumber) async {
    return await users.doc(currentUserId).update({
      'phoneno': phonenumber,
    });
  }

  // get tf_categories stream
  Stream<QuerySnapshot> get lessons {
    return tf_categories.snapshots();
  }
}
