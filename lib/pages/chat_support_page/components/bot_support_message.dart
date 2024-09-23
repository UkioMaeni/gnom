import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gnom/config/http_config.dart';
import 'package:gnom/pages/chat_page/chat_page.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';
import 'package:flutter/services.dart';
import 'package:external_path/external_path.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';
class BotSupportMessage extends StatefulWidget {
  final Message message;
  const BotSupportMessage({super.key,required this.message});

  @override
  State<BotSupportMessage> createState() => _BotSupportMessageState();
}

class _BotSupportMessageState extends State<BotSupportMessage> {


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
                Builder(
                  builder: (context) {
                    if(widget.message.text=="file" && widget.message.link!=null){
                      List<String> splits=widget.message.link!.split(".");
                      print(splits[splits.length-1]);
                      return Text(
                        splits[splits.length-1],
                        style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: "NoirPro",
                                height: 1,
                                color: Colors.white
                                ),
                      );
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
                
                if(widget.message.link!=null&&widget.message.text=="")
                GestureDetector(
                  onTap: () async{
                    final deviceInfo = await DeviceInfoPlugin().androidInfo;
                    final version = deviceInfo.version.sdkInt;
                    if(version>=33){
                      await Permission.manageExternalStorage.request();
                      final status= await Permission.manageExternalStorage.status;
                      if(status!=PermissionStatus.granted){
                        return;
                      }
                    }else{
                      await Permission.storage.request();
                      final status= await Permission.storage.status;
                      if(status!=PermissionStatus.granted){
                        return;
                      }
                    }
                    var path = await ExternalPath.getExternalStorageDirectories();
                    final gnomDirectory = Directory(path[0]+'/Android/media/com.gnom.helper');
                    if(!gnomDirectory.existsSync()){
                      gnomDirectory.create();
                    }
                    setState(() {
                      isDownload=true;
                      
                    });
                    try {
                      print("http://45.12.237.135/"+widget.message.link!);
                      
                      final response=await Dio().get(
                         "http://45.12.237.135/"+widget.message.link!,
                         options: Options(responseType: ResponseType.bytes)
                      );
                      String fileExchange=response.headers["content-type"]?[0].replaceAll("application/", "")??"none";
                      print(fileExchange);
                      String id= Uuid().v4();
                      final file = File(gnomDirectory.path+"/${id}.${fileExchange}");
                      
                      file.writeAsBytesSync(response.data);
                      //chatStore.updateStatusForDownloadFile(widget.message.id, gnomDirectory.path+"/${id}.${fileExchange}",widget.type);
                      
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
                ),
                if(widget.message.text=="file"&&widget.message.link!=null)
                GestureDetector(
                  onTap: ()async {
                    try {
                      await OpenFile.open(widget.message.link!);
                    } catch (e) {
                      print(e);
                    }
                    
                    
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                      "ОТКРЫТЬ",
                      style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              fontFamily: "NoirPro",
                              height: 1,
                              color: Colors.white
                              ),
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