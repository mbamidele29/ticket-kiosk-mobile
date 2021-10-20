import 'package:flutter/material.dart';

class Comment{
  final String id;
  final List<Comment> comments;
  final String body, createdAt, updatedAt;
  final String createdById, createdByFirstName, createdByLastName;

  Comment({
    @required this.id, 
    @required this.body, 
    @required this.comments, 
    @required this.createdAt, 
    @required this.updatedAt, 
    @required this.createdById, 
    @required this.createdByLastName,
    @required this.createdByFirstName, 
  });

  factory Comment.fromJson(Map json){
    return Comment(
      id: json['id'], 
      body: json['body'], 
      comments: json['comments'], 
      createdAt: json['createdAt'], 
      updatedAt: json['updatedAt'], 
      createdById: json['createdById'], 
      createdByLastName: json['createdByLastName'], 
      createdByFirstName: json['createdByFirstName']
    );
  }
}