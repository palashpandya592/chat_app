import 'package:chatting_app/utilities/app_assets.dart';
import 'package:chatting_app/utilities/app_strings.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Text(AppStrings.chatPage,
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(Assets.googleLogo),
                      ),
                      title: Text('Name',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Email',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
