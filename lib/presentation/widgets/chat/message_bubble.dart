//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tes_no_app/models/chat_model.dart';

class MessageBubble extends StatelessWidget {
  final Message mensaje;

  const MessageBubble({super.key, required this.mensaje});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: mensaje.me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: mensaje.me ? colors.primary : colors.secondary,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(mensaje.text ?? '', style: TextStyle(color: Colors.white)),
          )
        ),
        if (mensaje.image != null && mensaje.image!.isNotEmpty) ...[
          const SizedBox(height: 10),
          _ImageBubble(imagen: mensaje.image!),
          const SizedBox(height: 10),
        ],

      ]
    );
  }
}

class _ImageBubble extends StatelessWidget {
  final String imagen;
  
  _ImageBubble({super.key, required this.imagen});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    print("LOADED IMAGE: $imagen");

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        imagen,
        width: size.width * 0.7,
        height: 150,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if ( loadingProgress == null) return child;
          return Container(
            width: size.width * 0.7,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: const Column(
              children: [
                Text("Cargando imagen...", style: TextStyle(color: Colors.grey)),
                SizedBox(height: 10),
                Icon(Icons.language_rounded),
              ],
            )
          );
        },
      )
    );
  }
}