import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/repository/contact_repository.dart';
import 'package:equatable/equatable.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;

  ContactBloc(this.contactRepository) : super(ContactInitial()) {
    on<ContactListRequested>(_onContactListRequested);
  }

  FutureOr<void> _onContactListRequested(
      ContactListRequested event, Emitter<ContactState> emit) async {
    try {
      emit(ContactLoadInProgress());
      final contacts =
          await contactRepository.getContacts(loginUID: event.loginUID);
      emit(ContactLoadSuccess(contacts: contacts));
    } catch (e) {
      log(e.toString());
      emit(ContactLoadFailure(msg: 'Unable to load contacts'));
    }
  }
}
