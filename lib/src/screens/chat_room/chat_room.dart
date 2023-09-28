import 'package:chiggos_gpt/src/providers/response_generator.dart';
import 'package:chiggos_gpt/src/screens/chat_room/message_view.dart';
import 'package:chiggos_gpt/src/screens/chat_room/prompt_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRoom extends ConsumerStatefulWidget {
  const ChatRoom({super.key});

  @override
  ConsumerState createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<ChatRoom> {

  final _promptController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _promptController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: const Text("Chiggos-GPT"),),

      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child:Consumer(builder: (context, ref, child) {
                final responseGenerator = ref.watch(responseGeneratorPProvider);
                if(responseGenerator.value == null){
                  return const Center(child: Text("Loading..."),);
                }
                if(responseGenerator.value!.isEmpty){
                  return const Center(child: Text("Start Chatting.."),);
                }
                int conversationLength = responseGenerator.value!.length;
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: responseGenerator.value!.length,
                  itemBuilder: (context,index){
                    if(responseGenerator.value![conversationLength -1 ].role == "user" && index == conversationLength - 1){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        MessageView(model: responseGenerator.value![index]),
                          const Text("Chiggos-GPT - Generating your response...")
                        ],),
                      );
                    }
                    return MessageView(model: responseGenerator.value![index]);
                  }); },)
            ),

            PromptBox(promptController: _promptController,
              scrollController: _scrollController,

            )


          ],
        ),
      ),

    );
  }

}
