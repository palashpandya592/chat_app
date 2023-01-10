import 'package:chatting_app/model/conversation_model.dart';
import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoadInProgress extends ChatState {}

class ChatLoadFailure extends ChatState {
  final String msg;

  ChatLoadFailure({required this.msg});

  @override
  List<Object> get props => [msg];
}

class ChatLoadSuccess extends ChatState {
  final List<Conversation> chats;

  ChatLoadSuccess({required this.chats});

  @override
  List<Object> get props => [chats];
}
