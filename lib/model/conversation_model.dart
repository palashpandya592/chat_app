import 'dart:convert';

import 'package:chatting_app/model/app_user_model.dart';
import 'package:equatable/equatable.dart';

class Conversation extends Equatable {
  final String? id;
  final AppUser creator;
  final AppUser receiver;
  final List<String> members;

  Conversation({
    this.id,
    required this.creator,
    required this.receiver,
    required this.members,
  });

  Conversation copyWith({
    String? id,
    AppUser? creator,
    AppUser? receiver,
    List<String>? members,
  }) {
    return Conversation(
      id: id ?? this.id,
      creator: creator ?? this.creator,
      receiver: receiver ?? this.receiver,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'creator': creator.toMap(),
      'receiver': receiver.toMap(),
      'members': members,
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      id: map['id']?.toString(),
      creator: AppUser.fromMap(map['creator'] as Map<String, dynamic>),
      receiver: AppUser.fromMap(map['receiver'] as Map<String, dynamic>),
      members: List<String>.from(map['members'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversation.fromJson(String source) =>
      Conversation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Conversation(id: $id, creator: $creator, receiver: $receiver, members: $members)';
  }

  @override
  List<Object> get props => [creator, receiver, members];
}
