import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:order_app/helpers/usershelper.dart';
import 'package:order_app/models/usermodels.dart';

class AuthProvider with ChangeNotifier {
  String getMessageFromErrorCode(dynamic errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";

      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";

      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";

      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";

      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";

      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";

      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";

      default:
        return "Login failed. Please try again.";
    }
  }

  final fireAuth = FirebaseAuth.instance;
  Future signUp(String username, String number, String email, String password,
      BuildContext context) async {
    try {
      final userCreds = await fireAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final userId = userCreds.user!.uid;
      UserModel addedUser = UserModel(
          userId: userId, username: username, email: email, number: number);
      UsersHelper.addUser(addedUser);

      notifyListeners();
    } on dynamic catch (e) {
      String message = '';
      message = getMessageFromErrorCode(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(message),
              title: const Text("Error occured"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ok"))
              ],
            );
          });
    }
  }

  Future logIn(String email, String password, BuildContext context) async {
    try {
      await fireAuth.signInWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
    } on dynamic catch (e) {
      String message = '';
      message = getMessageFromErrorCode(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(message),
              title: const Text("Error occured"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ok"))
              ],
            );
          });
    }
    notifyListeners();
  }

  Future<void> logOut() async {
    await fireAuth.signOut();
    notifyListeners();
    print(isAuth());
  }

  String? get currentUserId {
    if (fireAuth.currentUser != null) {
      return fireAuth.currentUser!.uid;
    }
    return null;
  }

  bool isAuth() {
    return !(fireAuth.currentUser == null);
  }

  Future<UserModel?> get currentUser async {
    if (fireAuth.currentUser != null) {
      final user = await UsersHelper.getUser(currentUserId!);
      notifyListeners();
      return user;
    }
    return null;
  }
}
