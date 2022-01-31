//@dart=2.8
import 'package:flutter/cupertino.dart';

class Note {
  int id;
  String title;
  String content;
  String dateTimeEdited;
  String dateTimeCreated;

  Note({this.id,this.title,this.content,this.dateTimeCreated,
    this.dateTimeEdited});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "dateTimeCreated": dateTimeEdited,
      "dateTimeEdited": dateTimeEdited,
    };
  }
}

//plugin dart json serialization generator
//toMap instead toJson