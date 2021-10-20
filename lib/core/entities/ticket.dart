import 'dart:convert';

import 'package:flutter/material.dart';

class Ticket {
  final String id;
  int cost, quantity, quantitySold;
  final String createdAt, updatedAt;
  String name, description, currency;

  Ticket({
    @required this.id, 
    @required this.cost, 
    @required this.name, 
    @required this.description, 
    @required this.quantity, 
    @required this.quantitySold, 
    @required this.currency, 
    @required this.createdAt, 
    @required this.updatedAt
  });

  factory Ticket.initial(){
    return Ticket(id: null, cost: null, name: null, description: null, quantity: null, quantitySold: null, currency: null, createdAt: null, updatedAt: null);
  }

  factory Ticket.fromJson(Map json){
    return Ticket(
      id: json['id'],
      cost: int.parse(json['cost']),
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
      quantitySold: json['quantitySold']==null ? 0 : int.parse(json['quantitySold']),
      currency: json['currency'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map toJson(){
    return {
      "id": this.id,
      "cost": this.cost,
      "name": this.name,
      "quantity": this.quantity,
      "quantitySold": this.quantitySold,
      "currency": this.currency,
      "description": this.description,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }

  @override
    String toString() {
      return jsonEncode(this.toJson());
    }
}