
import '../screens/chat_room/chat_room.dart';
import 'package:flutter/material.dart';

class ScreenRoute{
  Route<dynamic> onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case "/":
        return MaterialPageRoute(builder: (context)=> const ChatRoom());

      default:
        return MaterialPageRoute(builder: (context)=> Scaffold(
          body: Center(child: Text("Route does not exist ${settings.name}"),),
        ));
    }
  }
}