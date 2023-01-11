import 'package:chatting_app/conversation/bloc/conversation_bloc.dart';
import 'package:chatting_app/conversation/conversation_view.dart';
import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/provider/conversation_provider.dart';
import 'package:chatting_app/repository/conversation_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationPage extends StatelessWidget {
  final String? conversationId;
  final UserModel sender;
  final UserModel receiver;

  ConversationPage({
    Key? key,
    this.conversationId,
    required this.sender,
    required this.receiver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConversationBloc(
        ConversationRepository(
          conversationProvider:
              ConversationProvider(firestore: FirebaseFirestore.instance),
        ),
      ),
      child: ConversationView(loginUser: sender, receiver: receiver),
    );
  }
}
