import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:tes_no_app/presentation/pages/home_page.dart';
import 'package:tes_no_app/presentation/providers/chat_provider.dart';
import 'package:tes_no_app/presentation/widgets/chat/message_bubble.dart';
import 'package:tes_no_app/models/chat_model.dart';
import 'package:tes_no_app/presentation/widgets/shared/message_field_box.dart';

import '../../providers/chat_provider.dart';


class ChatScreen extends StatelessWidget{
  final int chatId;

  const ChatScreen({super.key, required this.chatId});

  //Se ordenan los mensajes por fecha
  List<Message> ordenarMensajes(List<Message> mensajes1, List<Message> mensajes2){
    List<Message> ordenado = List.from(mensajes1 + mensajes2);
    
    ordenado.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return ordenado;
  } 

  @override
  Widget build(BuildContext context) {

    Future<void> _showMyDialog(String name) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Reportar a $name'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Deseas reportar a $name?.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Reportar',  style: TextStyle(color:Theme.of(context).colorScheme.error )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Cancelar', style: TextStyle(color: Colors.green )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    final chatProvider = context.watch<ChatProvider>();
    final loadedChat = chatProvider.loadedChats!.firstWhere((message) => message.id == chatId);
  
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(5.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1240w,f_auto,q_auto:best/newscms/2015_02/835681/150106-mia-khalifa-830a.jpg')
          ),
        ),
        title: Text(loadedChat.name),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () =>_showMyDialog(loadedChat.name),
          ),
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      body: _ChatView(
        messagesList: ordenarMensajes(loadedChat.my_messages, loadedChat.his_messages)
      ),
    );
  }
}


class _ChatView extends StatelessWidget {  

  final List<Message> messagesList;

  const _ChatView({
    required this.messagesList
  });

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatProvider.chatScrollController,
                itemCount: messagesList.length,
                itemBuilder: (BuildContext context, int index) {

                  return MessageBubble(mensaje: messagesList[index]);
                  
                },
              ),
            ),
            MessageFieldBox(
              onValue: (value) => chatProvider.sendMessage(text: value, me: true),
            )
          ],
        ),
      ),
    );
  }
}

