

import 'dart:convert';
import 'dart:developer';

import 'package:mobile_device_identifier/mobile_device_identifier.dart';

class PhoneInfo{
  Future<String> getDeviceId()async{
    String? deviceId = await  MobileDeviceIdentifier().getDeviceId();
   
    if(deviceId==null){
      return "imposter";
    }
    return deviceId;
  }
}

final phoneInfo=PhoneInfo();
