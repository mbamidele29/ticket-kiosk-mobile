import 'package:flutter/material.dart';

class Category {
  final String id, name;

  Category({@required this.id, @required this.name});

  factory Category.fromJson(Map json){
    return Category(
      id: json['_id'], 
      name: json['name']
    );
  }
}