import 'package:chatting_app/conversation/conversation_message_view.dart';
import 'package:chatting_app/message/message_receiver_bloc/message_receiver_bloc.dart';
import 'package:chatting_app/message/message_sender_bloc/message_sender_bloc.dart';
import 'package:chatting_app/message/message_sender_view.dart';
import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/provider/message_provider.dart';
import 'package:chatting_app/repository/message_repository.dart';
import 'package:chatting_app/utilities/app_assets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationMainView extends StatelessWidget {
  final UserModel loginUser;
  final UserModel receiver;
  final String conversationId;

  ConversationMainView({
    Key? key,
    required this.loginUser,
    required this.receiver,
    required this.conversationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(Assets.chatBackground),
        fit: BoxFit.cover,
        opacity: .5,
      )),
      child: Column(
        children: [
          Expanded(
            child: BlocProvider(
              create: (context) => MessageReceiverBloc(
                messageRepository: MessageRepository(
                  messageProvider:
                      MessageProvider(firestore: FirebaseFirestore.instance),
                ),
              )..add(
                  MessageRequested(conversationId: conversationId),
                ),
              child: ConversationMessageView(
                  loginUser: loginUser, receiver: receiver),
            ),
          ),
          BlocProvider(
            create: (context) => MessageSenderBloc(
              MessageRepository(
                messageProvider: MessageProvider(
                  firestore: FirebaseFirestore.instance,
                ),
              ),
            ),
            child: ConversationSenderView(
              conversationId: conversationId,
              senderUID: loginUser.uid,
              receiverUID: receiver.uid,
              receiverName: receiver.displayName,
            ),
          )
        ],
      ),
    );
  }
}
