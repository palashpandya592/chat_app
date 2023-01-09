import 'package:chatting_app/model/app_user_model.dart';
import 'package:chatting_app/provider/contact_provider.dart';

class ContactRepository {
  final ContactFirebaseProvider contactFirebaseProvider;

  ContactRepository({required this.contactFirebaseProvider});

  Future<List<AppUser>> getContacts({required String loginUID}) async {
    final listUserMaps =
        await contactFirebaseProvider.getContacts(loginUID: loginUID);
    return listUserMaps.map((userMap) => AppUser.fromMap(userMap)).toList();
  }
}
