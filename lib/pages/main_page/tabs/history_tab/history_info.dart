import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:external_path_ios_mac/external_path_ios_mac.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

    if(Platform.isAndroid){
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
                                    print(response.data);
                                    await chatStore.updateHistoryAsDocument(widget.model.messageId,gnomDirectory.path+"/${id}.${fileExchange}",fileExchange,response.data);
                                    setState(() {
                                      
                                    });
    }
    if(Platform.isIOS){
      final _externalPathIosMacPlugin = ExternalPathIosMac();
      Directory newPath= await getApplicationDocumentsDirectory();
      print(newPath.path);
      final path =newPath.path; //(await _externalPathIosMacPlugin.getDirectoryPath(directory: ExternalPathIosMac.DIRECTORY_DOWNLOADS))??"Unknow";
      print(path);
      final gnomDirectory = Directory(path);
      if(!gnomDirectory.existsSync()){
                                    gnomDirectory.create();
                                  }
      print(widget.model.answer);
      //String url= widget.model.answer.contains("http")?widget.model.answer:"http://45.12.237.135/"+widget.model.answer;
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
                                    print(response.data);
                                    await chatStore.updateHistoryAsDocument(widget.model.messageId,gnomDirectory.path+"/${id}.${fileExchange}",fileExchange,response.data);
                                    setState(() {
                                      
                                    });
    }
                                  
                                    
  }

  @override
  Widget build(BuildContext context) {
    print(widget.model.answer);
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Observer(
        builder: (context) {
          final model = chatStore.history.where((element) => element.messageId==widget.model.messageId,).toList()[0];
          print(model.type);
          print("RELOAD");
          print(model.answerBuffer);
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
                            if(model.question=="image"){
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Image.memory(model.fileBuffer!,fit: BoxFit.contain,),
                                    constraints: BoxConstraints(
                                      minWidth: 100,
                                      minHeight: 100,
                                      maxWidth: 300,
                                      maxHeight: 300

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
                                SizedBox(width: 10,),
                                ],
                              );
                            }
                            Message mess= Message(id: model.messageId, status: "", text: model.question, sender: "client", fileBuffer: null);
                            
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
                              if(model.answer.isEmpty){
                                    Message mess= Message(id: model.messageId, status: "", text: "wait...", sender: "client", fileBuffer: null);
                                    return Align(child: BotMessage(message: mess,type: model.type,),alignment: Alignment.centerLeft,);
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
                                    // if(model.answerBuffer!=null){
                                    //   print("buffer");
                                    //   return Image.memory(model.fileBuffer!);
                                    // }
                                    print(model.answer+"////////");
                                    
                                      if(
                                        (
                                          model.answer.contains("math")||
                                          model.answer.contains("referat")||
                                          model.answer.contains("presentation")||
                                          model.answer.contains("http")
                                        ) && 
                                        model.Apath.isEmpty
                                        ){
                                        downloadFile();
                                        return CircularProgressIndicator();
                                      }
                                      if(model.AisDocument){
                                        if(model.answer=="pdf"){
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Color.fromARGB(157, 43, 42, 42),
                                                      width: 3
                                                    ),
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(10),
                                                      topRight: Radius.circular(10)
                                                    )
                                                  ),
                                                  child: Image.asset("assets/icon/pdf.png",fit: BoxFit.cover,),
                                                  width: 250,
                                                  height: 250,
                                                ),
                                                GestureDetector(
                                                  onTap: () async{
                                                    try {
                                                      print('open');
                                                      print(model.Apath);
                                                      if(Platform.isIOS){
                                                        Directory newPath= await getApplicationDocumentsDirectory();
                                                        print(newPath);
                                                        final file = File(model.Apath);
                                                        if( !(await file.exists())){
                                                          await file.create();
                                                        }

                                                        file.writeAsBytesSync(model.answerBuffer!);
                                                        final result=await OpenFile.open(model.Apath);
                                                      }
                                                      
                                                      
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                    
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
                                        if(model.answer=="pptx"){
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Color.fromARGB(157, 43, 42, 42),
                                                      width: 3
                                                    ),
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(10),
                                                      topRight: Radius.circular(10)
                                                    )
                                                  ),
                                                  child: Image.asset("assets/icon/pptx.png",fit: BoxFit.cover,),
                                                  width: 250,
                                                  height: 250,
                                                ),
                                                GestureDetector(
                                                  onTap: () async{
                                                    if(Platform.isIOS){
                                                        Directory newPath= await getApplicationDocumentsDirectory();
                                                        print(newPath);
                                                        final file = File(model.Apath);
                                                        if( !(await file.exists())){
                                                          await file.create();
                                                        }

                                                        file.writeAsBytesSync(model.answerBuffer!);
                                                        final result=await OpenFile.open(model.Apath);
                                                      }
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
                                        if(model.answer=="docx"){
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  
                                                  
                                                  child: Image.asset("assets/icon/docx.png",fit: BoxFit.cover,),
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Color.fromARGB(157, 43, 42, 42),
                                                      width: 3
                                                    ),
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(10),
                                                      topRight: Radius.circular(10)
                                                    )
                                                  ),
                                                  width: 250,
                                                  height: 250,
                                                ),
                                                GestureDetector(
                                                  onTap: () async{
                                                    if(Platform.isIOS){
                                                        Directory newPath= await getApplicationDocumentsDirectory();
                                                        print(newPath);
                                                        final file = File(model.Apath);
                                                        if( !(await file.exists())){
                                                          await file.create();
                                                        }

                                                        file.writeAsBytesSync(model.answerBuffer!);
                                                        final result=await OpenFile.open(model.Apath);
                                                      }
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
                                        if(model.answer=="png"){
                                          final file = model.answerBuffer;
                                          print(model.question);
                                          return Container(
                                            width: width*2/3,
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: ()async {
                                                    Directory newPath= await getApplicationDocumentsDirectory();
                                                    print(newPath.path);
                                                    await ImageGallerySaver.saveImage(file!);
                                                    Fluttertoast.showToast(
                                                        msg: "OK",
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: const Color.fromARGB(255, 52, 55, 52),
                                                        textColor: Colors.white,
                                                      );
                                                    
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    alignment: Alignment.centerRight,
                                                    padding: EdgeInsets.only(right: 20),
                                                    width: width*2/3,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(157, 43, 42, 42),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10),
                                                        topRight: Radius.circular(10)
                                                      )
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Builder(
                                                          builder: (context) {
                                                            final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                                            return Text(
                                                                    state.locale.saveToGalery,
                                                                    style: const TextStyle(
                                                                          fontSize: 15,
                                                                          fontWeight: FontWeight.w400,
                                                                          fontFamily: "NoirPro",
                                                                          height: 1,
                                                                          color: Colors.white
                                                                          ),
                                                                    );
                                                          },
                                                        ),
                                                        SizedBox(width: 10,),
                                                        Icon(Icons.save,size: 15,color: Colors.white,),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
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
                                                                child: Image.memory(file),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.only(
                                                      bottomLeft: Radius.circular(10),
                                                      bottomRight: Radius.circular(10)
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Container(  
                                                          
                                                          child: Image.memory(file!,fit: BoxFit.cover,),
                                                        ),
                                                        
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      }
                                      
                                      return  Container(
                                        // constraints: BoxConstraints(
                                        //         //maxWidth: MediaQuery.of(context).size.width-120,
                                        //         minWidth: width*2/3
                                        //       ),
                                        width: width*2/3,
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: ()async {
                                                
                                                await Clipboard.setData(ClipboardData(text: model.answer));
                                                if(Platform.isIOS){
                                                  Fluttertoast.showToast(
                                                    msg: "OK",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: const Color.fromARGB(255, 52, 55, 52),
                                                    textColor: Colors.white,
                                                  );
                                                }
                                              },
                                              child: Container(
                                                height: 40,
                                                width: width*2/3,
                                                alignment: Alignment.centerRight,
                                                padding: EdgeInsets.only(right: 20),
                                                
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(157, 20, 20, 20),
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    topRight: Radius.circular(10)
                                                  )
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Builder(
                                                      builder: (context) {
                                                        final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                                        return Text(
                                                                state.locale.copy,
                                                                style: const TextStyle(
                                                                      fontSize: 15,
                                                                      fontWeight: FontWeight.w400,
                                                                      fontFamily: "NoirPro",
                                                                      height: 1,
                                                                      color: Colors.white
                                                                      ),
                                                                );
                                                      },
                                                    ),
                                                    SizedBox(width: 10,),
                                                    Icon(Icons.copy,size: 15,color: Colors.white,),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                                // constraints: BoxConstraints(
                                                //   maxWidth: width*3/4,
                                                //   minWidth:  width*2/3
                                                // ),
                                                width: width*2/3,
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color:Color.fromARGB(157, 43, 42, 42),
                                                  borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(10),
                                                    bottomRight: Radius.circular(10)
                                                  )
                                                ),
                                                child: Text(
                                                    model.answer,
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