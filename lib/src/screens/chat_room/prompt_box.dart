import 'package:chiggos_gpt/src/providers/response_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PromptBox extends ConsumerWidget {
  final TextEditingController _promptController;
  final ScrollController scrollController;
  const PromptBox({super.key,required TextEditingController promptController,
    required this.scrollController

  }):_promptController = promptController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: TextFormField(
              controller: _promptController,
              minLines: 1,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Prompt Here....",
                isDense:true,
                  border: OutlineInputBorder()
              ),

            ),
          ),

          IconButton.filledTonal(onPressed: (){
            ref.read(responseGeneratorPProvider.notifier).getResponse(prompt: _promptController.text,scrollController: scrollController);
            _promptController.text = "";
          }, icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
