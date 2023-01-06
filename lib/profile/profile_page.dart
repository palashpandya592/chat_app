// ignore_for_file: deprecated_member_use
import 'package:chatting_app/model/app_user_model.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(body: Center(child: Text('Hello')));
  }
}
