import 'package:chatting_app/chat/bloc/chat_bloc.dart';
import 'package:chatting_app/chat/bloc/chat_event.dart';
import 'package:chatting_app/chat/chat_view.dart';
import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/provider/chat_provider.dart';
import 'package:chatting_app/repository/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  final UserModel authenticatedUser;

  ChatPage({Key? key, required this.authenticatedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(
        ChatRepository(
          chatProvider: ChatProvider(firestore: FirebaseFirestore.instance),
        ),
      )..add(
          ChatRequested(loginUID: authenticatedUser.uid),
        ),
      child: ChatView(),
    );
  }
}
