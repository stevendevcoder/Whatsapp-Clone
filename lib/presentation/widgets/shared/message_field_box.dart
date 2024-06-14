import 'package:flutter/material.dart';
//import 'package:tes_no_app/domain/entities/message.dart';

class MessageFieldBox extends StatelessWidget {
  final ValueChanged<String> onValue;

  const MessageFieldBox({
    super.key,
    required this.onValue
  });

  @override
  Widget build(BuildContext context) {

    //final colors = Theme.of(context).colorScheme;

    final textControll = TextEditingController();
    final focusNode = FocusNode();

    final outlineInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(20)
    );

    final inputDecoration = InputDecoration(
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      suffixIcon: IconButton(
        icon: const Icon(Icons.send_rounded),
        onPressed: () {
          final textValue = textControll.value.text;
          onValue(textValue);
          print("Por icono: $textValue");
          textControll.clear();
        }
      )
    );

    return TextFormField(
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      controller: textControll,
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        final textValue = textControll.value.text;
        onValue(textValue);
        print("Por enter: $textValue");
        textControll.clear();
        focusNode.requestFocus();
      }
    );
  }
}