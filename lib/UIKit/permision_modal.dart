import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermisionModal extends StatefulWidget {
  const PermisionModal({super.key});

  @override
  State<PermisionModal> createState() => _PermisionModalState();
}

class _PermisionModalState extends State<PermisionModal> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "FORBIDDEN",
                style: TextStyle(
                  fontFamily: "NoirPro",
                  color: const Color.fromRGBO(254, 222,181, 1),
                height: 1,
                fontWeight: FontWeight.w600,
                fontSize: 45
              ),
            ),
            SizedBox(height: 20,),
            Text(
                "Разрешить приложению \"Gnom Helper\"  доступ к фото, мультимедия и файлам на устрйостве?",
                textAlign: TextAlign.center,
                style: TextStyle(  
                  fontFamily: "NoirPro",
                  color: Colors.white,
                height: 1.4,
                fontWeight: FontWeight.w600,
                fontSize: 14
              ),
              
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: ()async {
                final deviceInfo = await DeviceInfoPlugin().androidInfo;
                final version = deviceInfo.version.sdkInt;
                 PermissionStatus  status;
                if(version>=33){
                  await Permission.manageExternalStorage .request();
                    status= await Permission.manageExternalStorage.status;
                }else{
                  await Permission.storage.request();
                  status= await Permission.storage.status;
                }
                if(status==PermissionStatus.granted){
                  Navigator.pop(context);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(109, 199, 117, 117),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Text(
                        "РАЗРЕШИТЬ",
                        textAlign: TextAlign.center,
                        style: TextStyle(  
                          fontFamily: "NoirPro",
                          color: Colors.white,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                        fontSize: 14
                      ),
                      
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}