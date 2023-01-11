import 'package:chatting_app/model/conversation_model.dart';
import 'package:equatable/equatable.dart';

abstract class ConversationState extends Equatable {
  ConversationState();

  @override
  List<Object> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationLoadInProgress extends ConversationState {}

class ConversationLoadSuccess extends ConversationState {
  final ConversationModel conversation;

  ConversationLoadSuccess({required this.conversation});
}

class ConversationLoadFailure extends ConversationState {
  final String msg;

  ConversationLoadFailure({required this.msg});
}