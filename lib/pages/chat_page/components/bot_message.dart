import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gnom/config/http_config.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';

class BotMessage extends StatefulWidget {
  final Message message;
  const BotMessage({super.key,required this.message});

  @override
  State<BotMessage> createState() => _BotMessageState();
}

class _BotMessageState extends State<BotMessage> {


  bool isDownload=false;




  @override
  Widget build(BuildContext context) {
    return  Container(
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
              maxWidth: MediaQuery.of(context).size.width-150,
              minWidth: 50
            ),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color:Color.fromARGB(157, 43, 42, 42),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                Text(
                  widget.message.text,
                  style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontFamily: "NoirPro",
                          height: 1,
                          color: Colors.white
                          ),
                ),
                
                if(widget.message.link!=null)
                GestureDetector(
                  onTap: () async{
                    setState(() {
                      isDownload=true;
                      
                    });
                    try {
                      print("http://45.12.237.135/"+widget.message.link!);
                      final file=await Dio().get(
                         "http://45.12.237.135/"+widget.message.link!
                      );
                      print(file.data);
                    } catch (e) {
                      print(e);
                    } finally{
                      isDownload=false;
                    }
                    

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                    "СКАЧАТЬ",
                    style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontFamily: "NoirPro",
                            height: 1,
                            color: Colors.white
                            ),
                  ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}