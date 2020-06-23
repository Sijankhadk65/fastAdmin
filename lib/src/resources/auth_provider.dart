import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final _provider = FirebaseAuth.instance;

  Future<AuthResult> signIn(String email, String password) {
    return _provider.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() => _provider.signOut();

  Stream<FirebaseUser> authStatus() => _provider.onAuthStateChanged;
}
