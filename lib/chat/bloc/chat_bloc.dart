import 'dart:async';

import 'package:chatting_app/chat/bloc/chat_event.dart';
import 'package:chatting_app/chat/bloc/chat_state.dart';
import 'package:chatting_app/repository/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  ChatBloc(this.chatRepository) : super(ChatInitial()) {
    on<ChatRequested>(_onChatListRequested);
  }

  FutureOr<void> _onChatListRequested(
      ChatRequested event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoadInProgress());
    } catch (e) {
      emit(ChatLoadFailure(msg: 'Unable to Load message'));
    }
  }
}
