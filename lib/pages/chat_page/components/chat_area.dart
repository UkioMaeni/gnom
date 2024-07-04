import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gnom/pages/chat_page/chat_page.dart';
import 'package:gnom/pages/chat_page/components/bot_message.dart';
import 'package:gnom/pages/chat_page/components/client_message.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';
class ChatPageChatArea extends StatefulWidget {
  final EChatPageType type;
  const ChatPageChatArea({super.key,required this.type});

  @override
  State<ChatPageChatArea> createState() => _ChatPageChatAreaState();
}

class _ChatPageChatAreaState extends State<ChatPageChatArea> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      
      builder: (context) {
        List<Message> messages=chatStore.chats[widget.type.name]??[];
        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return messageItem(messages[(messages.length-1)-index]);
          },
        );
      }
    );
  }

  Widget messageItem(Message message){

    if(message.sender=="bot"){
      return BotMessage(message: message,type:widget.type.name);
    }else{
      return ClientMessage(message: message);
    }
    
  }

}