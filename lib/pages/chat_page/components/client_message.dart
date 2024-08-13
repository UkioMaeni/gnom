import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';

class ClientMessage extends StatefulWidget {
  final Message message;
  const ClientMessage({super.key,required this.message});

  @override
  State<ClientMessage> createState() => _ClientMessageState();
}

class _ClientMessageState extends State<ClientMessage> {
  @override
  Widget build(BuildContext context) {
    if(widget.message.fileBuffer!=null &&widget.message.fileBuffer!.isNotEmpty){
     return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.only(right: 20),
        width: 160,
        height: 200,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
         children: [
           SizedBox(
            width: MediaQuery.of(context).size.width-100,
            child: Image.memory(widget.message.fileBuffer!)
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
    return Container(
      //alignment: message.sender=="bot"?Alignment.centerLeft:Alignment.centerRight,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(right: 20),
      constraints: BoxConstraints(
        maxWidth: 200,
        minWidth: 50,
        minHeight: 50
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
            constraints: BoxConstraints(
              maxWidth: 200,
              minWidth: 50,
              minHeight: 50
            ),
            child: Text(
                widget.message.text,
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