import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnom/UIKit/permision_modal.dart';
import 'package:gnom/config/http_config.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/pages/chat_page/chat_page.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';
import 'package:flutter/services.dart';
import 'package:external_path/external_path.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:external_path/external_path.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
class BotMessage extends StatefulWidget {
  final Message message;
  final String  type;
  const BotMessage({super.key,required this.message,required this.type});

  @override
  State<BotMessage> createState() => _BotMessageState();
}

class _BotMessageState extends State<BotMessage> {


  bool isDownload=false;




  @override
  Widget build(BuildContext context) {
    //print(widget.message.link);
    return  Container(
      //alignment: message.sender=="bot"?Alignment.centerLeft:Alignment.centerRight,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(left: 20),
      
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 40,
              height: 40,
              
              child: Image.asset("assets/png/gnome_profile.jpg",height: 118,width: 118,),
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
                Builder(
                  builder: (context) {
                    if(widget.message.link!=null&&widget.message.fileBuffer!=null){
                      return GestureDetector(
                          child: Image.memory(widget.message.fileBuffer!),
                          onTap: () async{
                            await OpenFile.open(widget.message.link!);
                          },
                        );
                    }
                    if(widget.message.text=="file" && widget.message.link!=null){
                      List<String> splits=widget.message.link!.split(".");
                      print(splits[splits.length-1]);
                      if(widget.type=="presentation"){
                        return Image.asset("assets/png/power_point_icon.png");
                      }
                      return  Image.asset("assets/jpg/pdf_icon.jpg");
                    }
                    if(widget.message.link!=null&&widget.message.text==""){
                      if(widget.type=="presentation"){
                        return Image.asset("assets/png/power_point_icon.png");
                      }
                      return Image.asset("assets/jpg/pdf_icon.jpg");
                    }
                    
                    return Text(
                      widget.message.text,
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
                
                if((widget.message.link!=null )&&widget.message.text=="")
                GestureDetector(
                  onTap: () async{
                    final deviceInfo = await DeviceInfoPlugin().androidInfo;
                    final version = deviceInfo.version.sdkInt;
                    
                    // if(version>=33){
                      
                    //     PermissionStatus  status= await Permission.manageExternalStorage.status;
                    //     if(status.isDenied){
                    //       await showDialog(
                    //         context: context,
                    //         barrierDismissible: false,
                    //         builder: (context) {
                    //           return Dialog(

                    //             backgroundColor: Colors.transparent,
                    //             child: PermisionModal(),
                    //           );
                    //         },
                    //       );
                    //     }
                    //     status= await Permission.manageExternalStorage.status;
                        
                    //   if(status!=PermissionStatus.granted){
                    //     return;
                    //   }
                    // }else{
                    //   await Permission.storage.request();
                    //   final status= await Permission.storage.status;
                    //   if(status!=PermissionStatus.granted){
                    //     return;
                    //   }
                    // }
                    
                    var path = await ExternalPath.getExternalStorageDirectories();
                    print(path);
                    String directoryPath=path[0]+'/Android/media/com.gnom.helper';
                    if(version<=32){
                      directoryPath=path[0]+'/Android/data/com.gnom.helper';
                    }
                    final gnomDirectory = Directory(directoryPath);
                    final directory = await getApplicationDocumentsDirectory();
                    
                    print(directory.path);                    
                    String downloadDirectory= path[0]+"/Download";
                      //downloadDirectory=directory.path;
                    if(!gnomDirectory.existsSync()){
                      gnomDirectory.create();
                    }
                    bool find=gnomDirectory.existsSync();
                    print(find);
                    setState(() {
                      isDownload=true;
                      
                    });
                    try {
                      print("http://45.12.237.135/"+widget.message.link!);
                      
                      final response=await Dio().get(
                         "http://45.12.237.135/"+widget.message.link!,
                         options: Options(responseType: ResponseType.bytes)
                      );
                      print(response.headers["content-type"]);
                      String fileExchange=response.headers["content-type"]?[0].replaceAll("application/", "")??"none";
                      if(fileExchange.contains("officedocument")){
                        fileExchange="pptx";
                      }
                      print(fileExchange);
                      String id= Uuid().v4();
                      final file = File(gnomDirectory.path+"/${id}.${fileExchange}");
                      await file.create();
                      file.writeAsBytesSync(response.data);
                      chatStore.updateStatusForDownloadFile(widget.message.id, gnomDirectory.path+"/${id}.${fileExchange}",widget.type);
                      
                    } catch (e) {
                      print(e);
                    } finally{
                      isDownload=false;
                    }
                    

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Builder(
                      builder: (context) {
                        final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                        return Text(
                        state.locale.download,
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
                if(widget.message.text=="file"&&widget.message.link!=null)
                GestureDetector(
                  onTap: ()async {
                    try {
                      // await Permission.manageExternalStorage.request();
                      // print(await Permission.manageExternalStorage.status);
                      print(widget.message.link);
                      final extension = path.extension(widget.message.link!);
                      print(extension);
                      bool exist=await File(widget.message.link!).exists();
                      print(exist);
                      print("aaa");
                      await OpenFile.open(widget.message.link!,type: "application/vnd.openxmlformats-officedocument.presentationml.presentation");
                      //await launchUrl(Uri.parse(widget.message.link!));
                      //await OpenFilex.open(widget.message.link!);
                      //await OpenFilex.open(widget.message.link!);
                      
                      print("end");
                    } catch (e) {
                      print(e);
                    }
                    
                    
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Builder(
                        builder: (context) {
                          print(widget.message.link);
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
          ),
        ],
      ),
    );
  }
}