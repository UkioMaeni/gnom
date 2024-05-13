import 'dart:typed_data';
import 'package:mobx/mobx.dart';

part 'chat_store.g.dart';



class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {

  @observable
  ObservableMap<String,List<Message>> chats=ObservableMap<String,List<Message>>.of({"math":[m1,m2]});
  

}

ChatStore chatStore = ChatStore();


final m1=Message(id: 1,status: "send",text: "привd asdawdw ad f3 a sdf sdf  sdfsdfsd fsdf sdfsdf dfs fsf 4w ewfwfw e ет",sender: "bot");
final m2=Message(id: 1,status: "send",text: "привет",sender: "people");

class Message{
  int id;
  String text;
  String status;
  String sender;
  Message({
    required this.id,
    required this.status,
    required this.text,
    required this.sender
  });
}

