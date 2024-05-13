import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gnom/pages/chat_page/chat_page.dart';
import 'package:gnom/store/chat_store.dart';
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
            return messageItem(messages[index]);
          },
        );
      }
    );
  }

  Widget messageItem(Message message){

    if(message.sender=="bot"){
      return Container(
      //alignment: message.sender=="bot"?Alignment.centerLeft:Alignment.centerRight,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(left: 20),
      
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color.fromARGB(157, 43, 42, 42),
              borderRadius: BorderRadius.circular(20)
            ),
          ),
          SizedBox(width: 10,),
          Container(
            constraints: BoxConstraints(
              maxWidth: 200,
              minWidth: 50
            ),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color:Color.fromARGB(157, 43, 42, 42),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Text(
              message.text,
              style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: "NoirPro",
                      height: 1,
                      color: Colors.white
                      ),
            ),
          ),
        ],
      ),
    );
    }

    return Container(
      //alignment: message.sender=="bot"?Alignment.centerLeft:Alignment.centerRight,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(right: 20),
      constraints: BoxConstraints(
        maxWidth: 200,
        minWidth: 50
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
            Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color:Color.fromARGB(157, 43, 42, 42),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Text(
              message.text,
              style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: "NoirPro",
                      height: 1,
                      color: Colors.white
                      ),
            ),
          ),
          SizedBox(width: 10,),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color.fromARGB(157, 43, 42, 42),
              borderRadius: BorderRadius.circular(20)
            ),
          ),
          
        
        ],
      ),
    );
  }

}