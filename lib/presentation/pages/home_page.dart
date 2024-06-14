import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tes_no_app/presentation/screens/chat/chat_screen.dart';

import '../../models/chat_model.dart';
import '../providers/chat_provider.dart';


class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final chatProvider = context.watch<ChatProvider>();
    final List<Chat>? loadedChats = chatProvider.loadedChats;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis chats'),
        centerTitle: true,
        actions: []
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: loadedChats == null 
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  controller: chatProvider.homePageScrollController,
                  itemCount: loadedChats!.length,
                  separatorBuilder: (context, index) => const Divider(height: 1,),
                  itemBuilder: (BuildContext context, int index) {
                    return _ChatBubble(chat: loadedChats[index]);
                  },

              )
            )
          ],
        )
      )
    );
  }
}


class _ChatBubble extends StatelessWidget {
  final Chat chat;

  const _ChatBubble({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        Navigator.pushNamed(context, '/chat/${chat.id}');
      },
      child: Container(
        padding: EdgeInsets.all(20),
        color: Color.fromARGB(118, 214, 214, 214),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          child: Row(
            children: [
              SizedBox(
                width: 45,
                height: 45,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(chat.profileIMG),
                ),
              ),
              SizedBox(width: 10),
              Text(chat.name, style: TextStyle(fontSize: 15)),
            ],
            
          ),
        ),
      ),
    );
  }
}