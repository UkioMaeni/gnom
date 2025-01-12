import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/core/tools/string_tool.dart';
import 'package:gnom/pages/chat_page/components/bot_message.dart';
import 'package:gnom/pages/chat_page/components/client_message.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';
import 'package:gnom/pages/main_page/tabs/history_tab/history_tab.dart';
import 'package:media_storage/media_storage.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class HistoryInfo extends StatefulWidget {
  final HistoryModel model;
  const HistoryInfo({super.key,required this.model});

  @override
  State<HistoryInfo> createState() => _HistoryInfoState();
}

class _HistoryInfoState extends State<HistoryInfo> {


  Future<Message?> searchReply()async{
    print("start");
    final mess= chatStore.searchMessage(widget.model.reply??"",widget.model.type);
    print(mess);
    print("end");
    return mess;
  }

  Future downloadFile()async{
                                  final deviceInfo = await DeviceInfoPlugin().androidInfo;
                                  final version = deviceInfo.version.sdkInt;
                                  var path = await MediaStorage.getExternalStorageDirectories();
                                  print(path);
                                  String directoryPath=path[0]+'/Android/media/com.gnom.helper';
                                  if(version<=32){
                                    directoryPath=path[0]+'/Android/data/com.gnom.helper';
                                  }
                                  final gnomDirectory = Directory(directoryPath);
                                  final directory = await getApplicationDocumentsDirectory();
                                  
                                  print(directory.path);                    
                                  
                                    //downloadDirectory=directory.path;
                                  if(!gnomDirectory.existsSync()){
                                    gnomDirectory.create();
                                  }
                                  bool find=gnomDirectory.existsSync();
                                  print(find);
                                  print(widget.model.type);
                                    
                                    
                                    String domain= widget.model.type=="presentation"? "http://31.129.106.28:8000/":"http://45.12.237.135/";
                                    String url= widget.model.answer.contains("http")?widget.model.answer:domain+widget.model.answer;
                                    print(url);
                                    final response=await Dio().get(
                                      url,
                                      options: Options(responseType: ResponseType.bytes)
                                    );
                                    print(response.headers["content-type"]);
                                    String fileExchange=response.headers["content-type"]?[0].replaceAll("application/", "")??"none";
                                    if(fileExchange.contains("vnd.openxmlformats-officedocument.presentationml.presentation")){
                                      fileExchange="pptx";
                                    }
                                    if(fileExchange.contains("vnd.openxmlformats-officedocument.wordprocessingml.document")){
                                      fileExchange="docx";
                                    }
                                    if(fileExchange.contains("image/png")){
                                      fileExchange="png";
                                    }

                                    print(fileExchange);
                                    String id= Uuid().v4();
                                    final file = File(gnomDirectory.path+"/${id}.${fileExchange}");
                                    await file.create();
                                    file.writeAsBytesSync(response.data);
                                    await chatStore.updateHistoryAsDocument(widget.model.messageId,gnomDirectory.path+"/${id}.${fileExchange}",fileExchange);
                                    setState(() {
                                      
                                    });
                                    
  }

  @override
  Widget build(BuildContext context) {
    print(widget.model.Apath);
    return Scaffold(
      body: Observer(
        builder: (context) {
          final model = chatStore.history.where((element) => element.messageId==widget.model.messageId,).toList()[0];
          print(widget.model.type);
          return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/png/app_bg.png"),
                      fit: BoxFit.cover
                    )
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      
                      child: ListView(
                        
                        children: [
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap:()=> Navigator.pop(context),
                            child: Row(
                              children: [
                                SizedBox(width: 20,),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Icon(Icons.arrow_back)
                                ),
                                SizedBox(width: 10,),
                                Builder(
                                  builder: (context) {
                                    final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                    return Text(
                                      StringTools.firstUpperOfString(state.locale.back),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "NoirPro",
                                        height: 1,
                                        color: Colors.white
                                        ),
                                    );
                                  }
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Builder(
                            builder: (context) {
                              final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                              return Text(
                                    "${state.locale.question}:",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NoirPro",
                                      height: 1,
                                      color: Colors.white
                                      ),
                                  );
                            }
                          ),
                              SizedBox(height: 20,),
                         Builder(
                           builder: (context) {
                            if(widget.model.question=="image"){
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Image.memory(widget.model.fileBuffer!,fit: BoxFit.cover,),
                                    width: 250,
                                    height: 250,
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
                                SizedBox(width: 10,),
                                ],
                              );
                            }
                            Message mess= Message(id: widget.model.messageId, status: "", text: widget.model.question, sender: "client", fileBuffer: null);
                            
                             return ClientMessage(message: mess);
                           }
                         ),
                         SizedBox(height: 20,),
                         Builder(
                           builder: (context) {
                            final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                             return Text(
                                    "${state.locale.answer}:",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "NoirPro",
                                      height: 1,
                                      color: Colors.white
                                      ),
                                  );
                           }
                         ),
                          SizedBox(height: 20,),
                          Builder(
                            builder: (context) {
                              if(widget.model.answer.isEmpty){
                                    Message mess= Message(id: widget.model.messageId, status: "", text: "wait...", sender: "client", fileBuffer: null);
                                    return Align(child: BotMessage(message: mess,type: widget.model.type,),alignment: Alignment.centerLeft,);
                                  }
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 10,),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        
                                        child: Image.asset("assets/png/gnome_profile.jpg",height: 118,width: 118,),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                  Observer(
                                    builder: (context) {
                                    // if(widget.model.answerBuffer!=null){
                                    //   print("buffer");
                                    //   return Image.memory(widget.model.fileBuffer!);
                                    // }
                                    print(widget.model.answer+"////////");
                                    
                                      if(
                                        (
                                          widget.model.answer.contains("math")||
                                          widget.model.answer.contains("referat")||
                                          widget.model.answer.contains("presentation")||
                                          widget.model.answer.contains("http")
                                        ) && 
                                        widget.model.Apath.isEmpty
                                        ){
                                        downloadFile();
                                        return CircularProgressIndicator();
                                      }
                                      if(widget.model.AisDocument){
                                        if(widget.model.answer=="pdf"){
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Image.asset("assets/jpg/pdf_icon.jpg",fit: BoxFit.cover,),
                                                  width: 250,
                                                  height: 250,
                                                ),
                                                GestureDetector(
                                                  onTap: () async{
                                                    await OpenFile.open(widget.model.Apath);
                                                  },
                                                  child: Container(
                                                    width: 250,
                                                    alignment: Alignment.center,
                                                      padding: EdgeInsets.symmetric(vertical: 10),
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(157, 43, 42, 42),
                                                        
                                                      ),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                                          return Text(
                                                          state.locale.open,
                                                          style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontFamily: "NoirPro",
                                                                  height: 1,
                                                                  color: Colors.white
                                                                  ),
                                                                            );
                                                        }
                                                      ),
                                                    ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                        if(widget.model.answer=="pptx"){
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Image.asset("assets/png/power_point_icon.png",fit: BoxFit.cover,),
                                                  width: 250,
                                                  height: 250,
                                                ),
                                                GestureDetector(
                                                  onTap: () async{
                                                    await OpenFile.open(widget.model.Apath);
                                                  },
                                                  child: Container(
                                                    width: 250,
                                                    alignment: Alignment.center,
                                                      padding: EdgeInsets.symmetric(vertical: 10),
                                                      decoration: BoxDecoration(
                                                        color: Color.fromARGB(157, 43, 42, 42),
                                                        
                                                      ),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                                          return Text(
                                                          state.locale.open,
                                                          style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontFamily: "NoirPro",
                                                                  height: 1,
                                                                  color: Colors.white
                                                                  ),
                                                                            );
                                                        }
                                                      ),
                                                    ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                        if(widget.model.answer=="png"){
                                          File file = File(widget.model.Apath);
                                          return GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: true,

                                                  builder: (context) {
                                                    
                                                    return Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                                      //backgroundColor: Colors.red,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          
                                                        },
                                                        child: Center(
                                                          child: Image.file(file,),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    
                                                    child: Image.file(file,fit: BoxFit.cover,),
                                                    width: 250,
                                                    height: 250,
                                                  ),
                                                  
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                      
                                      return  Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context).size.width-120,
                                            minWidth: 50
                                          ),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color:Color.fromARGB(157, 43, 42, 42),
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Text(
                                              widget.model.answer,
                                              style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: "NoirPro",
                                                      height: 1,
                                                      color: Colors.white
                                                      ),
                                            ),
                                        );
                                      
                                    }
                                  ),
                                ],
                              );
                            }
                          ),
                          SizedBox(height: 50,)
                        ],
                      ),
                    ),
                  ),
                );
        }
      ),
    );
  }
}