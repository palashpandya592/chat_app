import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/utilities/app_colors.dart';
import 'package:flutter/material.dart';

class ConversationView extends StatelessWidget {
  final UserModel loginUser;
  final UserModel receiver;

  const ConversationView(
      {Key? key, required this.loginUser, required this.receiver})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(receiver.displayName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            color: Colors.red,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  height: 45,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5, left: 25),
                        hintText: 'Message ${receiver.displayName}',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.primary,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Icon(Icons.send, size: 24, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
