import 'package:chatting_app/model/app_user_model.dart';
import 'package:chatting_app/provider/login_provider.dart';

class LoginRepository {
  LoginRepository({required this.loginFirebaseProvider});

  final LoginFirebaseProvider loginFirebaseProvider;

  Future<AppUser?> loginWithGoogle() async {
    final firebaseUser = await loginFirebaseProvider.loginWithGoogle();
    return firebaseUser == null
        ? null
        : AppUser(
            uid: firebaseUser.uid,
            displayName: firebaseUser.displayName ?? '',
            email: firebaseUser.email ?? '',
            photoUrl: firebaseUser.photoURL ?? '',
          );
  }

  Stream<bool> isLoggedIn() {
    final streamOfUser = loginFirebaseProvider.getLoggedInUserStates();
    return streamOfUser.map((user) => user != null);
  }

  Stream<AppUser?> getLoggedInUser() {
    final loggedInUserStream = loginFirebaseProvider.getLoggedInUserStates();
    return loggedInUserStream.map((firebaseUser) {
      if (firebaseUser == null) {
        return null;
      } else {
        return AppUser(
          uid: firebaseUser.uid,
          displayName: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
          photoUrl: firebaseUser.photoURL ?? '',
        );
      }
    });
  }

  Future<void> logOut() async {
    await loginFirebaseProvider.logOut();
  }
}
