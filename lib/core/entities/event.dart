import 'package:flutter/material.dart';
import 'package:ticket_kiosk/core/entities/category.dart';
import 'package:ticket_kiosk/core/entities/comment.dart';
import 'package:ticket_kiosk/core/entities/ticket.dart';

class Event {
  final Category category;
  final List<String> tags;
  final String eventType;
  final List<Ticket> tickets;
  final List<Comment> comments;
  final List<String> eventDates;
  final String id, title, description, banner;
  String placeId, address, createdAt, updatedAt;
  final String createdById, createdByFirstName, createdByLastName, nextEventDate;

  final String minCost, maxCost;

  Event({
    @required this.category,
    @required this.nextEventDate,
    @required this.eventDates,
    @required this.minCost,
    @required this.maxCost,
    @required this.tags, 
    @required this.eventType, 
    @required this.tickets, 
    @required this.comments, 
    @required this.placeId, 
    @required this.address, 
    @required this.createdAt, 
    @required this.updatedAt, 
    @required this.id, 
    @required this.title, 
    @required this.description, 
    @required this.banner, 
    @required this.createdById, 
    @required this.createdByFirstName, 
    @required this.createdByLastName, 
  });

  factory Event.fromJSON(Map json){
    List<Ticket> tickets=[];
    List<Comment> comments=[];

    List<String> eventDates=List<String>.from(json['eventDates'])..sort((a, b)=>a.compareTo(b));
    List.from(json['tickets']).forEach((element) {tickets.add(Ticket.fromJson(element));});
    List.from(json['comments']).forEach((element) {comments.add(Comment.fromJson(element));});

    String minCost='0', maxCost='0', nextEventDate='';
    if(tickets.length>0){
      tickets.sort((a, b)=>a.cost>b.cost ? 1 : 0);
      minCost='${tickets.first.currency}${tickets.first.cost}';
      maxCost='${tickets.last.currency}${tickets.last.cost}';
    }
    if(eventDates.isNotEmpty)nextEventDate=eventDates[0];

    return Event(
      nextEventDate: nextEventDate,
      minCost: minCost,
      maxCost: maxCost,
      eventDates: eventDates,
      // inviteOnly: json['inviteOnly'], 
      tags: List<String>.from(json['tags']), 
      eventType: json['eventType'], 
      tickets: tickets, 
      comments: comments, 
      placeId: json['placeId'], 
      address: json['address'], 
      createdAt: json['createdAt'], 
      updatedAt: json['updatedAt'], 
      id: json['id'], 
      title: json['title'], 
      description: json['description'], 
      category: Category.fromJson(json['category']),
      banner: json['banner'], 
      createdById: json['createdById'], 
      createdByFirstName: json['createdByFirstName'], 
      createdByLastName: json['createdByLastName']
    );
  }

  Map toJSON(){
    return {
      'nextEventDate': nextEventDate,
      'minCost': minCost,
      'maxCost': maxCost,
      'eventDates': eventDates,
      'tags': tags, 
      'eventType': eventType, 
      'tickets': tickets, 
      'comments': comments, 
      'placeId': placeId, 
      'address': address, 
      'createdAt': createdAt, 
      'updatedAt': updatedAt, 
      'id': id, 
      'title': title, 
      'description': description, 
      'categoryId': category?.id, 
      'categoryName': category?.name, 
      'banner': banner, 
      'createdById': createdById, 
      'createdByFirstName': createdByFirstName, 
      'createdByLastName': createdByLastName
    };
  }

  @override
    String toString() {
      return this.toJSON().toString();
    }
}

enum EventType {
  PUBLIC, PRIVATE
}