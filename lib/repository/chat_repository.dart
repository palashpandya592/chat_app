import 'package:chatting_app/model/conversation_model.dart';
import 'package:chatting_app/provider/chat_provider.dart';

class ChatRepository {
  final ChatProvider chatProvider;

  ChatRepository({required this.chatProvider});

  Future<List<ConversationModel>> getChats({required String loginUID}) async {
    final chatMaps = await chatProvider.getChats(loginUID: loginUID);
    return chatMaps
        .map((chatMap) => ConversationModel.fromMap(chatMap))
        .toList();
  }
}
