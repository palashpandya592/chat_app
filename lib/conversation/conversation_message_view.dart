import 'package:chatting_app/message/message_receiver_bloc/message_receiver_bloc.dart';
import 'package:chatting_app/model/message_model.dart';
import 'package:chatting_app/model/user_model.dart';
import 'package:chatting_app/utilities/app_colors.dart';
import 'package:chatting_app/utilities/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationMessageView extends StatelessWidget {
  final UserModel loginUser;
  final UserModel receiver;

  ConversationMessageView(
      {Key? key, required this.loginUser, required this.receiver})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<MessageReceiverBloc, MessageReceiverState>(
        builder: (context, state) {
          if (state is MessageLoadInProgress) {
            return Center(child: Text(''));
          } else if (state is MessageLoadFailure) {
            return Text('Unable to fetch Message');
          } else if (state is MessageLoadSuccess) {
            return MessageListBuilder(
                messageModel: state.messageModel, loginUID: loginUser.uid);
          }
          return Text('');
        },
      ),
    );
  }
}

class MessageListBuilder extends StatelessWidget {
  final String loginUID;
  final List<MessageModel?> messageModel;

  MessageListBuilder(
      {Key? key, required this.loginUID, required this.messageModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return messageModel.isEmpty
        ? Text(AppStrings.noMessage)
        : ListView.builder(
            itemCount: messageModel.length,
            reverse: true,
            // shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final message = messageModel.elementAt(index);
              return MessageBody(
                chatColor: message?.senderUID == loginUID,
                messageModel: message,
              );
            },
          );
  }
}

class MessageBody extends StatelessWidget {
  final bool chatColor;
  final MessageModel? messageModel;

  MessageBody({Key? key, required this.chatColor, required this.messageModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      child: Align(
        alignment: chatColor ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: chatColor ? AppColors.primary : AppColors.teal,
            borderRadius: BorderRadius.circular(10),
          ),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          child: Text(
            messageModel?.content ?? '',
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
