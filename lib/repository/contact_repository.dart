import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/provider/contact_provider.dart';

class ContactRepository {
  final ContactProvider contactProvider;

  ContactRepository({required this.contactProvider});

  Future<List<UserModel>> getContacts({required String loginUID}) async {
    final listUserMaps = await contactProvider.getContacts(loginUID: loginUID);
    return listUserMaps.map((userMap) => UserModel.fromMap(userMap)).toList();
  }
}
