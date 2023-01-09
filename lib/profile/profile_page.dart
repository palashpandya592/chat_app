// ignore_for_file: deprecated_member_use
import 'package:chatting_app/login/bloc/login_bloc.dart';
import 'package:chatting_app/model/app_user_model.dart';
import 'package:chatting_app/utilities/app_colors.dart';
import 'package:chatting_app/utilities/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  final AppUser authenticatedUser;

  const ProfilePage({Key? key, required this.authenticatedUser})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var profile = widget.authenticatedUser;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profile.photoUrl),
                radius: 70,
              ),
              SizedBox(height: 50),
              Text(
                profile.displayName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: 6),
              Text(
                profile.email,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.black),
              ),
              SizedBox(height: 50),
              ElevatedButton.icon(
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context).add(LoginRemoved());
                },
                icon: Icon(Icons.logout),
                label: Text(AppStrings.logOut),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 23, vertical: 11),
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
