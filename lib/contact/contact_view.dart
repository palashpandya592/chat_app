import 'package:chatting_app/contact/bloc/contact_bloc.dart';
import 'package:chatting_app/model/app_user_model.dart';
import 'package:chatting_app/utilities/app_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactView extends StatelessWidget {
  final AppUser loginUser;

  ContactView({Key? key, required this.loginUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactLoadInProgress) {
            return CircularProgressIndicator();
          } else if (state is ContactLoadFailure) {
            return Text(AppStrings.unableToLoadContacts);
          } else if (state is ContactLoadSuccess) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Text(
                    AppStrings.allContactList,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                      child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('uid', isNotEqualTo: loginUser.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                              ConnectionState.active ||
                          snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.hasError}');
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              dynamic user = snapshot.data?.docs[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          NetworkImage(user!['photoUrl'])),
                                  title: Text(
                                    user['displayName'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    user['email'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Text(AppStrings.noUserFound);
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    },
                  )),
                ],
              ),
            );
          }
          return Text(AppStrings.noUserFound);
        },
      ),
    );
  }
}
