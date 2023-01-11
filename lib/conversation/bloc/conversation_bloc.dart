import 'package:chatting_app/conversation/bloc/conversation_event.dart';
import 'package:chatting_app/conversation/bloc/conversation_state.dart';
import 'package:chatting_app/repository/conversation_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ConversationRepository conversationRepository;

  ConversationBloc(this.conversationRepository) : super(ConversationInitial()) {
    on<ConversationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
