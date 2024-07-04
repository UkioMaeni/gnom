import 'package:flutter/material.dart';
import 'package:gnom/pages/chat_page/components/bot_message.dart';
import 'package:gnom/pages/chat_page/components/client_message.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';
import 'package:gnom/pages/main_page/tabs/history_tab/history_tab.dart';

class HistoryInfo extends StatefulWidget {
  final HistoryModel model;
  const HistoryInfo({super.key,required this.model});

  @override
  State<HistoryInfo> createState() => _HistoryInfoState();
}

class _HistoryInfoState extends State<HistoryInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/jpg/app_bg.jpg"),
                  fit: BoxFit.cover
                )
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Align(
                  child: Column(
                    children: [
                      Text(
                            "Вопрос:",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              fontFamily: "NoirPro",
                              height: 1,
                              color: Colors.white
                              ),
                          ),
                     Builder(
                       builder: (context) {
                        Message mess= Message(id: widget.model.messageId, status: "", text: widget.model.theme, sender: "client", fileBuffer: null);
                         return Align(child: ClientMessage(message: mess),alignment: Alignment.centerRight,);
                       }
                     ),
                     Text(
                            "Ответ:",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              fontFamily: "NoirPro",
                              height: 1,
                              color: Colors.white
                              ),
                          ),
                     Builder(
                       builder: (context) {
                        Message mess= Message(id: widget.model.messageId, status: "", text: widget.model.answer, sender: "client", fileBuffer: null);
                         return BotMessage(message: mess,type: widget.model.type,);
                       }
                     )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}