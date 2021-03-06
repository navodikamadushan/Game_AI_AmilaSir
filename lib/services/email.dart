import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import "package:gameaiupdate/services/alert.dart";

class EmailService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AlertService _alertService = AlertService();
  User user;
  Future sendEmailVerification() async {
    user = _auth.currentUser;
    if (!user.emailVerified) {
      _auth.currentUser.sendEmailVerification();
      await user.reload();
      return 'sent email!';
    } else {
      //return 'already verified!';
    }
    return user.emailVerified;
  }

  Future<void> checkEmailVerified(Timer timer) async {
    user = _auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      print('verified!');
    }
  }
}
