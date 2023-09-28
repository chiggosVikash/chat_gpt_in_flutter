import 'package:chiggos_gpt/src/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageView extends ConsumerWidget {
  final ChatModel _model;
  const MessageView({super.key,required ChatModel model}):_model = model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: _model.role == "user" ? Theme.of(context).colorScheme.secondaryContainer.withOpacity(.3)
              :Theme.of(context).colorScheme.surfaceVariant.withOpacity(.5)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_model.role == "user" ? "You" : "Chiggos-GPT"),

              IconButton(onPressed: ()async{

                await Clipboard.setData(ClipboardData(text: _model.content));

              }, icon: const Icon(Icons.copy))
            ],
          ),
          Text(_model.content,style: _model.role == "user"?GoogleFonts.abyssinicaSil(): GoogleFonts.openSans(),
         )
        ],),
      ),
    );
  }
}
