import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id, username, email, firstName, lastName, phoneNumber, createdAt;

  User({
    @required this.id,
    @required this.email,
    @required this.username,
    @required this.lastName,
    @required this.firstName,
    @required this.createdAt,
    @required this.phoneNumber,
  });

  factory User.fromJSON(Map json){
    return User(
      id: json['_id'], 
      email: json['email'], 
      username: json['username'], 
      lastName: json['lastName'], 
      firstName: json['firstName'],
      createdAt: json['createdAt'], 
      phoneNumber: json['phoneNumber'].toString(),
    );
  }

  Map toJSON(){
    return {
      id: id,
      email: email,
      username: username,
      lastName: lastName,
      firstName: firstName,
      createdAt: createdAt,
      phoneNumber: phoneNumber,
    };
  }

  @override
  List<Object> get props => [id, username, email, firstName, lastName, phoneNumber, createdAt];
}