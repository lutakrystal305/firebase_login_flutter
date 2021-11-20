import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FbaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUp(String email, String pass, String name, String phone,
      Function onSuccess, Function(String) onError) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) =>
            _createUser(user.user!.uid, name, phone, onSuccess, onError));
  }

  void signIn(
      String email, String pass, Function onSuccess, Function(String) onError) {
    _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) => onSuccess())
        .catchError((err) {
      // ignore: avoid_print
      print(err.toString());
      onError('SignIn failt, try again!');
    });
  }

  _createUser(String userId, String name, String phone, Function onSuccess,
      Function(String) onError) {
    var user = <String, String>{};
    user['name'] = name;
    user['phone'] = phone;

    var ref = FirebaseDatabase.instance.reference().child('users');
    ref.child(userId).set(user).then((z) {
      // ignore: avoid_print
      print('success');
      onSuccess();
    }).catchError((err) {
      // ignore: avoid_print
      print(err.toString());
      onError('SignUp fail, try again!');
      // ignore: avoid_print
    }).whenComplete(() => print('Completed'));
  }

  Future<void> signOut() async {
    // ignore: avoid_print
    print("signOut");
    return _firebaseAuth.signOut();
  }
}
