import 'package:chatting_app/model/app_user_model.dart';
import 'package:chatting_app/provider/contact_provider.dart';

class ContactRepository {
  final ContactProvider contactProvider;

  ContactRepository({required this.contactProvider});

  Future<List<AppUser>> getContacts({required String loginUID}) async {
    final listUserMaps = await contactProvider.getContacts(loginUID: loginUID);
    return listUserMaps.map((userMap) => AppUser.fromMap(userMap)).toList();
  }
}
