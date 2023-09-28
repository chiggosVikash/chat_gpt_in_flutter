

import 'dart:convert';

import 'package:chiggos_gpt/src/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' show post;
import '../models/chat_model.dart';
import 'package:flutter/material.dart';
part 'response_generator.g.dart';


@Riverpod(keepAlive: true)
class ResponseGeneratorP extends _$ResponseGeneratorP{

  @override
  FutureOr<List<ChatModel>> build(){
    return [];
  }


  Future<void> getResponse({required String prompt,required ScrollController scrollController})async{
    // state = const AsyncValue.loading();
    if(state.value!.length > 1){
      _animateScrollPos(scrollController: scrollController);
    }
    final request = ChatModel(content: prompt, role: 'user');
    state = AsyncValue.data([...state.value ?? [],request]);



    try{
        final response = await post(Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Api.gptApi}',
        },
            body: jsonEncode({"model": "gpt-3.5-turbo",
              "messages":[ request.toJson()],})
        );

        if(response.statusCode == 200){
          final data = await jsonDecode(response.body);
          final responseMessage = data["choices"][0]["message"];
          final chatModel = ChatModel.fromJson(responseMessage);
          state = AsyncValue.data([...state.value ?? [], chatModel]);
        }else{
          state = AsyncValue.error("Failed to generate response", StackTrace.fromString("Failed"));
        }

    }catch(e,st){
      state = AsyncValue.error(e,st);
      if(kDebugMode){
        rethrow;
      }
    }

    _animateScrollPos(scrollController: scrollController);

  }


  void _animateScrollPos({required ScrollController scrollController}){
    scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }






}