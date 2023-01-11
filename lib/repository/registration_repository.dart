import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/provider/registration_provider.dart';

class RegistrationRepository {
  final RegistrationProvider registrationProvider;

  RegistrationRepository({required this.registrationProvider});

  Future<UserModel?> getUserDetail({required String uid}) async {
    final userMapFromFirebase =
        await registrationProvider.getUserDetail(uid: uid);
    return userMapFromFirebase == null
        ? null
        : UserModel.fromMap(userMapFromFirebase);
  }

  Future<void> registerUserDetail({required UserModel user}) async {
    await registrationProvider.registerUser(user: user.toMap());
  }
}
