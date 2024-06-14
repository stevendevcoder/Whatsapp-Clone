import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:tes_no_app/models/chat_model.dart';

class ChatProvider extends ChangeNotifier {

  final ScrollController chatScrollController = ScrollController();
  final ScrollController homePageScrollController = ScrollController();

  List<Chat>? loadedChats = [];
  //Chat? loadedChatPersona;
  
  //Constructor
  ChatProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    loadedChats = await loadChat();
    /*if (loadedChats!.isNotEmpty) {
      loadedChatPersona = loadedChats![0]; 
    }*/
    notifyListeners();
  }

  //Envia mensaje al messageList y notificar a los listeners

  Future<void> sendMessage({required String text, bool me = true, String? img}) async {
    if(text.isEmpty) return;

    print("Recibido en provider como: $text");
    /*
    final newMessage = Message(text: text, timestamp: DateTime.now(), me: me, image: img);
    img ?? await newMessage.fetchRandomImage();
    messagesList.add(newMessage);

    notifyListeners();
    moveScrollToBottom();

    if(me && text.contains('?')){
      await fetchHerResponse().then((respuesta) {
        sendMessage(text: respuesta.text ?? '', me: false, img: respuesta.image);
      });
    } */
  }

  //Cargar el chat del json
  Future<List<Chat>> loadChat() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/messages.json');
      final jsonResponse = json.decode(jsonString);
      List<dynamic> chatsJson = jsonResponse['chats'];
      List<Chat> chats = chatsJson.map((chatJson) => Chat.fromJson(chatJson)).toList();
      return chats;
    } catch (e) {
      // Handle error loading chats
      print('Error loading chats: $e');
      return []; // Return empty list if error occurs
    }
  }

  //Actualiza el scroll para que cuando se envie el mensaje esté abajo
  void moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration( milliseconds: 300),
      curve: Curves.easeOut
    );
  }

  //Obtiene la respuesta de la api para la respuesta
  Future<Message> fetchHerResponse() async {
    return GetYesNoAnswer().getAnswer();
  }
}