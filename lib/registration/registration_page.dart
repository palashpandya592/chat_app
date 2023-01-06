import 'package:chatting_app/bottom/bottom_page.dart';
import 'package:chatting_app/model/app_user_model.dart';
import 'package:chatting_app/provider/registration_provider.dart';
import 'package:chatting_app/registration/bloc/registration_bloc.dart';
import 'package:chatting_app/repository/registration_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatelessWidget {
  final AppUser authenticatedUser;

  const RegistrationPage({Key? key, required this.authenticatedUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(
        registrationRepository: RegistrationRepository(
          registrationFirebaseProvider: RegistrationFirebaseProvider(
            fireStore: FirebaseFirestore.instance,
          ),
        ),
      )..add(
          RegistrationDetailRequested(uid: authenticatedUser.uid),
        ),
      child: RegistrationView(authenticatedUser: authenticatedUser),
    );
  }
}

class RegistrationView extends StatelessWidget {
  final AppUser authenticatedUser;

  const RegistrationView({Key? key, required this.authenticatedUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationActionFailure) {
              BlocProvider.of<RegistrationBloc>(context).add(
                RegistrationDetailUpdated(user: authenticatedUser),
              );
            } else if (state is RegistrationActionError) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('')));
            }
          },
          buildWhen: (prev, current) {
            if (current is RegistrationActionFailure ||
                current is RegistrationActionError) {
              return false;
            }
            return true;
          },
          builder: (context, state) {
            if (state is RegistrationInProgress) {
              return CircularProgressIndicator();
            } else if (state is RegistrationUpdateSuccess) {
              return BottomPage(authenticatedUser: state.user);
            } else if (state is RegistrationDetailRequestSuccess) {
              return BottomPage(authenticatedUser: state.user);
            }

            return Text('');
          },
        ),
      ),
    );
  }
}
