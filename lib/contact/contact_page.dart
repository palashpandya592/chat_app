// ignore_for_file: must_be_immutable

import 'package:chatting_app/contact/bloc/contact_bloc.dart';
import 'package:chatting_app/model/app_user_model.dart';
import 'package:chatting_app/provider/contact_provider.dart';
import 'package:chatting_app/repository/contact_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactPage extends StatelessWidget {
  final AppUser authenticatedUser;

  const ContactPage({Key? key, required this.authenticatedUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc(
        ContactRepository(
          contactFirebaseProvider:
              ContactFirebaseProvider(firestore: FirebaseFirestore.instance),
        ),
      )..add(
          ContactListRequested(loginUID: authenticatedUser.uid),
        ),
      child: ContactView(loginUser: authenticatedUser),
    );
  }
}

class ContactView extends StatelessWidget {
  final AppUser loginUser;

  ContactView({Key? key, required this.loginUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactLoadInProgress) {
            return const CircularProgressIndicator();
          } else if (state is ContactLoadFailure) {
            return const Text('Unable to load contacts');
          } else if (state is ContactLoadSuccess) {
            return StreamBuilder(
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: state.contacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    var abc = state.contacts[index];
                    return ListTile(
                      title: Text(
                        abc.email,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                );
              },
            );
          }
          return Text('');
        },
      ),
    );
  }
}
