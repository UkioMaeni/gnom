import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gnom/pages/chat_page/chat_page.dart';
import 'package:gnom/pages/chat_page/components/bot_message.dart';
import 'package:gnom/pages/chat_page/components/client_message.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';
import 'package:gnom/pages/chat_support_page/components/bot_support_message.dart';
import 'package:gnom/pages/chat_support_page/components/client_support_message.dart';
import 'package:gnom/pages/chat_support_page/store/chat_support_store.dart';
class ChatSupportPageChatArea extends StatefulWidget {
  const ChatSupportPageChatArea({super.key});

  @override
  State<ChatSupportPageChatArea> createState() => _ChatSupportPageChatAreaState();
}

class _ChatSupportPageChatAreaState extends State<ChatSupportPageChatArea> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      
      builder: (context) {
        List<Message> messages=chatSupportStore.chats;
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
      return BotSupportMessage(message: message);
    }else{
      return ClientSupportMessage(message: message);
    }
    
  }

}