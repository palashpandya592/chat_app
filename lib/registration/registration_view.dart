import 'package:chatting_app/bottom/bottom_page.dart';
import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/registration/bloc/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationView extends StatelessWidget {
  final UserModel authenticatedUser;

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
