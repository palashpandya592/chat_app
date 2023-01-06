import 'package:chatting_app/model/app_user_model.dart';
import 'package:chatting_app/provider/registration_provider.dart';

class RegistrationRepository {
  RegistrationRepository({required this.registrationFirebaseProvider});

  final RegistrationFirebaseProvider registrationFirebaseProvider;

  Future<AppUser?> getUserDetail({required String uid}) async {
    final userMapFromFirebase =
        await registrationFirebaseProvider.getUserDetail(uid: uid);
    return userMapFromFirebase == null
        ? null
        : AppUser.fromMap(userMapFromFirebase);
  }

  Future<void> registerUserDetail({required AppUser user}) async {
    await registrationFirebaseProvider.registerUser(user: user.toMap());
  }
}
