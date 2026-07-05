import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repositories/i_auth_repository.dart';

class FirebaseAuthRepository implements IAuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository(this._firebaseAuth);

  AppUser? _mapFirebaseUser(User? user) {
    if (user == null) return null;
    return AppUser(
      id: user.uid,
      email: user.email,
      displayName: user.displayName,
    );
  }

  @override
  Stream<AppUser?> get authStateChanges =>
      _firebaseAuth.authStateChanges().map(_mapFirebaseUser);

  @override
  AppUser? get currentUser => _mapFirebaseUser(_firebaseAuth.currentUser);

  @override
  Future<Either<Failure, AppUser>> signInWithGoogle() async {
    try {
      final UserCredential userCredential;
      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        provider.addScope('email');
        provider.addScope('profile');
        userCredential = await _firebaseAuth.signInWithPopup(provider);
      } else {
        final googleUser = await GoogleSignIn.instance.authenticate();
        final googleAuth = googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );

        userCredential = await _firebaseAuth.signInWithCredential(credential);
      }

      final user = userCredential.user;

      if (user != null) {
        return right(_mapFirebaseUser(user)!);
      }
      return left(const ServerFailure('Failed to sign in with Google.'));
    } catch (e) {
      return left(ServerFailure('Google Sign In Error: $e'));
    }
  }

  @override
  Future<Either<Failure, AppUser>> signInAnonymously() async {
    try {
      final cred = await _firebaseAuth.signInAnonymously();
      final user = cred.user;
      if (user != null) {
        return right(_mapFirebaseUser(user)!);
      }
      return left(const ServerFailure('Anonymous login failed.'));
    } catch (e) {
      return left(ServerFailure('An error occurred during anonymous auth: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      if (!kIsWeb) {
        await GoogleSignIn.instance.signOut();
      }
      await _firebaseAuth.signOut();
      return right(unit);
    } catch (e) {
      return left(ServerFailure('Failed to sign out: $e'));
    }
  }
}
