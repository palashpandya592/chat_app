import 'package:chatting_app/contact/bloc/contact_bloc.dart';
import 'package:chatting_app/contact/contact_view.dart';
import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/provider/contact_provider.dart';
import 'package:chatting_app/repository/contact_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactPage extends StatelessWidget {
  final UserModel authenticatedUser;

  ContactPage({Key? key, required this.authenticatedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc(
        ContactRepository(
          contactProvider:
              ContactProvider(firestore: FirebaseFirestore.instance),
        ),
      )..add(
          ContactListRequested(loginUID: authenticatedUser.uid),
        ),
      child: ContactView(loginUser: authenticatedUser),
    );
  }
}
