import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/provider/registration_provider.dart';
import 'package:chatting_app/registration/bloc/registration_bloc.dart';
import 'package:chatting_app/registration/registration_view.dart';
import 'package:chatting_app/repository/registration_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatelessWidget {
  final UserModel authenticatedUser;

  const RegistrationPage({Key? key, required this.authenticatedUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(
        registrationRepository: RegistrationRepository(
          registrationProvider:
              RegistrationProvider(fireStore: FirebaseFirestore.instance),
        ),
      )..add(
          RegistrationDetailRequested(uid: authenticatedUser.uid),
        ),
      child: RegistrationView(authenticatedUser: authenticatedUser),
    );
  }
}
