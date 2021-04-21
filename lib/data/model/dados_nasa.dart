import 'package:flutter/material.dart';

class DadosNasa extends ChangeNotifier{
  String copyright;
  String date;
  String explanation;
  String mediaType;
  String title;
  String url;

  DadosNasa(
      {this.copyright,
        this.date,
        this.explanation,
        this.mediaType,
        this.title,
        this.url});

  factory DadosNasa.fromJson(Map<String, dynamic> json) {
    return DadosNasa(
      copyright: json['copyright'],
      date: json['date'],
      explanation: json['explanation'],
      mediaType: json['media_type'],
      title: json['title'],
      url: json['url'],
    );
  }

}
