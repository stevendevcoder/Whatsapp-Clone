
//import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class Chat {
  final int id;
  final String name;
  final String profileIMG;
  List<Message> my_messages = [];
  List<Message> his_messages = [];
  

  Chat({
    required this.id,
    required this.name,
    required this.profileIMG,
    required this.my_messages,
    required this.his_messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    //Cargar los mensajes de cada chat como listas
    final myMessages = (json['my_messages'] as List<dynamic>)
      .map(
        (msg) => Message.fromJson(msg, true)
      ).toList();
    final hisMessages = (json['my_messages'] as List<dynamic>)
    .map(
        (msg) => Message.fromJson(msg, false)
    ).toList();

    return Chat(
      id: json['id'],
      name: json['name'],
      profileIMG: json['profileIMG'],
      my_messages: myMessages,
      his_messages: hisMessages,
    );
  }
}

class Message {
  final String? text;
  String? image;
  final String? file;
  final DateTime timestamp;
  final bool edited;
  final bool me;

  Message({
    this.text,
    this.image,
    this.file,
    required this.timestamp,
    this.edited = false,
    required this.me
  }) {
    if(image == null) fetchRandomImage().then((value) => image = value);
  }

  Future<String?> fetchRandomImage({BuildContext? context}) async {
    final _dio = Dio();

    try {
      final response = await _dio.get('https://yesno.wtf/api');
      final data = response.data;
      
      print("RESPUESTA HTTP: ${response.statusCode}");

      if (response.statusCode == 200) {
        final String imageURL = data['image'];
        return imageURL;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  factory Message.fromJson(Map<String, dynamic> json, bool me) {
    return Message(
      text: json['text'],
      image: json['image'],
      file: json['file'],
      timestamp: DateTime.parse(json['timestamp']),
      edited: json['edited'] ?? false,
      me: me
    );
  }
}

