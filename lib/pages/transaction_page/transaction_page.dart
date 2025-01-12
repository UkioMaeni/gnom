

import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/core/tools/string_tool.dart';
import 'package:gnom/db/sql_lite.dart';
import 'package:gnom/http/subjects.dart';
import 'package:gnom/pages/chat_page/chat_page.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';
import 'package:gnom/pages/main_page/tabs/history_tab/history_tab.dart';
import 'package:gnom/pages/main_page/tabs/home_tab/pages/home_studies_page.dart';
import 'package:gnom/store/user_store.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class TransactionPage extends StatefulWidget {
  final EChatPageType type;
  final StudiesModel model;
  const TransactionPage({super.key,required this.type,required this.model});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {

  String type="no";
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }


  XFile? photo;

  
  bool modalView=false;
  bool isLoading = false;

  bool isErrorModal=false;
  sendRequest()async{
    
    setState(() {
          isLoading=true;
        });
    String newTransactionId = Uuid().v4();
    FormData formData=FormData();
        formData.fields.add(MapEntry("type", widget.model.type.name));
        formData.fields.add(MapEntry("messageId",newTransactionId ));
        if(type=="photo"){
          formData.files.add(MapEntry("file", MultipartFile.fromBytes(await photo!.readAsBytes(),filename: "file.${photo!.mimeType??"png"}", )));
        }else if(type=="keyboard"){
          formData.fields.add(MapEntry("text", _controller.text));
        }
        final result= await SubjectsHttp().sendRequest(formData);
        if(result!=null){
          if(type=="photo"){
            final historyModel = HistoryModel(icon: SizedBox.shrink(), favorite: false, question: "image", type: widget.type.name, progress: "process", messageId: newTransactionId, answer: "", answerMessageId: newTransactionId,QisDocument: true,AisDocument: false,Qpath: photo!.path,Apath: "",fileBuffer: await photo!.readAsBytes());
            await instanceDb.addHistory(historyModel);
            chatStore.addHistory(historyModel);
          }else if(type=="keyboard"){
              final historyModel = HistoryModel(icon: SizedBox.shrink(), favorite: false, question: _controller.text, type: widget.type.name, progress: "process", messageId: newTransactionId, answer: "", answerMessageId: newTransactionId,QisDocument: false,AisDocument: false,Apath: "",Qpath: "");
            instanceDb.addHistory(historyModel);
            chatStore.addHistory(historyModel);
          }
          Navigator.pop(context);
          userStore.selectedIndex=1;
        }else{
          setState(() {
          isLoading=false;
          modalView=false;
          isErrorModal=true;
        });
        } 
  }


  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            width: width,
            height: height,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/jpg/app_bg.jpg"),
                      fit: BoxFit.cover
                    )
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top+20),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              const SizedBox(width: 20,),
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: const Icon(Icons.arrow_back)
                              ),
                              const SizedBox(width: 10,),
                              Builder(
                                builder: (context) {
                                  final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                  return Text(
                                    state.locale.education,
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
                        SizedBox(height: 40,),
                        StudiesElementWithouAnimation(model:StudiesModel(icon: widget.model.icon, title: widget.model.title, sub: widget.model.sub, type: widget.model.type),),
                        SizedBox(height: 30,),
                        if(type=="no")ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Builder(
                                builder: (context) {
                                  bool isActive=true;
                                  if(
                                    widget.model.type==EChatPageType.math
                                  ){
                                    isActive=false;
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      if(!isActive){
                                        return;
                                      }
                                      setState(() {
                                        type="keyboard";
                                      });
                                    },
                                    child: Opacity(
                                      opacity: isActive?1:0.4,
                                      child: Container(
                                        width: 100,
                                        height: 80,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(vertical: 0),
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(196, 114, 137, 0.8),
                                        ),
                                        child: SvgPicture.asset("assets/svg/keyboard.svg",color:Color.fromRGBO(254, 222,181, 1),)
                                      ),
                                    ),
                                  );
                                }
                              ),
                              SizedBox(width: 10,),
                              Builder(
                                builder: (context) {
                                  bool isActive=true;
                                  if(
                                    widget.model.type==EChatPageType.referat||
                                    widget.model.type==EChatPageType.essay||
                                    widget.model.type==EChatPageType.presentation||
                                    widget.model.type==EChatPageType.sovet||
                                    widget.model.type==EChatPageType.generation
                                  ){
                                    isActive=false;
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      if(!isActive){
                                        return;
                                      }
                                      setState(() {
                                        type="photo";
                                      });
                                    },
                                    child: Opacity(
                                      opacity: isActive?1:0.4,
                                      child: Container(
                                        width: 100,
                                        height: 80,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(vertical: 5),
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(196, 114, 137, 0.8),
                                        ),
                                        child: SvgPicture.asset("assets/svg/add.svg",color:Color.fromRGBO(254, 222,181, 1),)
                                      ),
                                    ),
                                  );
                                }
                              ),
                            ],
                          ),
                        ),
                        if(type=="keyboard")
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: input(_controller,"Напишите сообщение")
                            ),
                            SizedBox(height: 40,),
                            buttonSend()
                          ],
                        ),
                        if(type=="photo")
                        Column(
                          children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Align(),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Builder(
                                        builder: (context) {
                                          if(photo!=null){
                                            return Container(
                                              padding: EdgeInsets.all(10),
                                              color: const Color.fromRGBO(196, 114, 137, 0.8),
                                              width: width*0.65,
                                              height: width*0.65,
                                              child:  ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Image.file(File(photo!.path))
                                              ),
                                            );
                                          }
                                          return GestureDetector(
                                            onTap: () async{
                                              try {
                                                
                                                await Permission.camera.request();
                                                final ImagePicker picker = ImagePicker();
                                                final LostDataResponse responses = await picker.retrieveLostData();
                                                print("start3");
                                                final List<XFile>? filess = responses.files;
                                                print("start4");
                                                print(filess);
                                                print("start1");
                                                final pickedFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 75,maxHeight: 300,maxWidth: 400,);
                                                
                                                print("start2");
                                                final LostDataResponse response = await picker.retrieveLostData();
                                                print("start3");
                                                final List<XFile>? files = response.files;
                                                print("start4");
                                                print(files);
                                                setState(() {
                                                  photo=pickedFile;
                                                });
                                              } catch (e) {
                                                print(e);
                                              }
                                              
                                            },
                                            child: Container(
                                              width: width*0.65,
                                              height: width*0.65,
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(196, 114, 137, 0.8),
                                                
                                              ),
                                              alignment: Alignment.center,
                                              child: Builder(
                                                builder: (context) {
                                                  final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                                  return Text(
                                                      state.locale.uploadImage,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "NoirPro",
                                                        fontSize: 28,
                                                        fontWeight: FontWeight.w500
                                                      ),
                                                    );
                                                }
                                              ),
                                            ),
                                          );
                                        }
                                      ),
                                    ),
                                    if(photo!=null) 
                                    Positioned(
                                      right: 25,
                                      child: GestureDetector(
                                        onTap: () async{
                                          final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                              print(pickedFile!.path);
                                              print("///////");
                                              setState(() {
                                                photo=pickedFile;
                                              });
                                        },
                                        child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: SvgPicture.asset("assets/svg/pencil.svg",color:Color.fromRGBO(254, 222,181, 1),)
                                        ),
                                      )
                                    )
                                  ],
                                ),
                              
                           
                            SizedBox(height: 40,),
                            buttonSend()
                          ],
                        )
                      ],
                    ),
                  )
                ),
              ),
              if (modalView)
              PopScope(
                canPop: false,
                child: Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Builder(
                            builder: (context) {
                              final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                              String text=state.locale.error;
                              switch(widget.model.type){
                                case EChatPageType.referat:
                                  text=state.locale.sendReport; 
                                  break;
                                case EChatPageType.essay:
                                  text=state.locale.sendEssay; 
                                  break;
                                case EChatPageType.presentation:
                                  text=state.locale.sendPresentation; 
                                  break;
                                case EChatPageType.reduce:
                                  text=state.locale.sendReduction; 
                                  break;
                                case EChatPageType.parafrase:
                                  text=state.locale.sendParafrase; 
                                  break;
                                case EChatPageType.sovet:
                                  text=state.locale.sendSovet; 
                                  break;
                                case EChatPageType.generation:
                                text=state.locale.sendImage; 
                                  break;
                                default:
                                  text=state.locale.error;
                              }
                              return Text(
                                text,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "NoirPro",
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800
                                ),
                              );
                            }
                          ),
                          Builder(
                            builder: (context) {
                              final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                              String text = state.locale.error;
                              switch(state.locale.locale){
                                case "ar":
                                  text="؟"+"\"${_controller.text}\"";
                                  break;
                                case "en":
                                  text="\"${_controller.text}\"?";
                                  break;
                                case "ru":
                                  text="\"${_controller.text}\"?";
                                  break;
                              }
                              
                              return Text(
                              text,
                              style: TextStyle(
                                color: Color.fromRGBO(254, 222,181, 1),
                                fontFamily: "NoirPro",
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                              ),
                            );
                            }
                          ),
                          SizedBox(height: 30,),
                          !isLoading?Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async{
                                  
                                  sendRequest();
                                },
                                child: Container(
                                  width: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 111, 77, 77),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Builder(
                                    builder: (context) {
                                      final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                      return Text(
                                          state.locale.yes,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "NoirPro",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500
                                          ),
                                        );
                                    }
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    modalView=false;
                                  });
                                },
                                child: Container(
                                  width: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 111, 77, 77),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Builder(
                                    builder: (context) {
                                      final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                      return Text(
                                          state.locale.no,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "NoirPro",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500
                                          ),
                                        );
                                    }
                                  ),
                                ),
                              )
                            ],
                          ):CircularProgressIndicator(color: Color.fromRGBO(254, 222,181, 1),)
                        ],
                      )
                    ),
                  ),
                ),
              ),
              if(isErrorModal)
              PopScope(
                canPop: false,
                child: Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Builder(
                            builder: (context) {
                              
                              return Text(
                                "Непредвиденная ошибка",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "NoirPro",
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800
                                ),
                              );
                            }
                          ),
                          SizedBox(height: 30,),
                          GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isErrorModal=false;
                                  });
                                },
                                child: Container(
                                  width: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 111, 77, 77),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Builder(
                                    builder: (context) {
                                      final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                      return Text(
                                          "Ок",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "NoirPro",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500
                                          ),
                                        );
                                    }
                                  ),
                                ),
                              )
                        ],
                      )
                    ),
                  ),
                ),
              ),
        ],
      )
    );
  }

  

  Widget buttonSend(){
    
    return GestureDetector(
      onTap: () async{
        if(type=="keyboard"){
          setState(() {
            _focusNode.unfocus();
            modalView=true;
          });
        }else{
          sendRequest();
        }
        return;
        
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(196, 114, 137, 0.8),
          borderRadius: BorderRadius.circular(5)
        ),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
        child: Builder(
          builder: (context) {
            final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
            return Text(
              state.locale.sendRequest,
              style: TextStyle(
                color: Color.fromRGBO(254, 222,181, 1),
                fontFamily: "NoirPro",
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
            );
          }
        ),
      ),
    );
  }

  Widget input(TextEditingController controller,String hint){
    return SizedBox(
      height: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color.fromARGB(143, 102, 92, 92),
          borderRadius: BorderRadius.circular(10)
        ),
        child: TextField(
          focusNode: _focusNode,
          controller: controller,
          style: TextStyle(
              fontFamily: "NoirPro",
              color: const Color.fromARGB(123, 255, 255, 255),
              height: 1,
              fontWeight: FontWeight.w400,
              fontSize: 20
            ),
          decoration: InputDecoration(
            constraints: BoxConstraints(
              minHeight: 40,
              maxHeight: 40
            ),
            contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 7),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: "NoirPro",
              color: Color.fromARGB(122, 196, 182, 182),
              height: 1,
              fontWeight: FontWeight.w400,
              fontSize: 20
            ),
          ),
        ),
      ),
    );
  }
}


class StudiesElementWithouAnimation extends StatelessWidget {
  final StudiesModel model;

  const StudiesElementWithouAnimation({super.key,required this.model});

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return SizedBox(
                    height: 95,
                    width: width-40,
                    child:  Row(
                      children: [
                        Expanded(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(196, 114, 137, 0.8),
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                     Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        width: 70,
                                        height: 80,
                                        child: model.icon
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Builder(
                                      builder: (context) {
                                        final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                                        String title= state.locale.error;
                                        String  sub=state.locale.error;
                                        if(model.type.name=="reduce"){
                                           title= state.locale.shortcut;
                                           sub = state.locale.result_30s;
                                          }else if(model.type.name=="math"){
                                            title=state.locale.mathematics;
                                            sub = state.locale.result_20s;
                                          }else if(model.type.name=="referat"){
                                            title=state.locale.paper;
                                            sub = state.locale.result_30s;
                                            
                                          }
                                          else if(model.type.name=="essay"){
                                             title=state.locale.essay;
                                             sub = state.locale.result_3m;
                                          }
                                          
                                          else if(model.type.name=="parafrase"){
                                            title=state.locale.paraphrasing;
                                            sub = state.locale.result_30s;
                                          }
                                          else if(model.type.name=="generation"){
                                            title=state.locale.imageGeneration;
                                            sub = state.locale.result_30s;
                                          }
                                          else if(model.type.name=="sovet"){
                                            title=state.locale.adviseOn;
                                            sub = state.locale.result_20s;
                                          }
                                          else if(model.type.name=="presentation"){
                                            title=state.locale.presentation;
                                            sub = state.locale.result_5m;
                                          }
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                             StringTools.firstUpperOfString(title),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: "NoirPro",
                                              height: 1,
                                              color: Color.fromRGBO(254, 222,181, 1)
                                              ),
                                          ),
                                          const SizedBox(height: 5,),
                                          Text(
                                             StringTools.firstUpperOfString(sub),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "NoirPro",
                                              height: 1,
                                              color: Colors.white
                                              ),
                                          ),
                                          ],
                                        );
                                      }
                                    ),
                                    // Container(
                                    //     width: 140,
                                    //     height: 60,
                                    //     color: Colors.amber,
                                    //     alignment: Alignment.centerRight,
                                    //     child:  widget.model.icon,
                                    //   ),
                                    
                                   
                                  ],
                                ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                  );
  }
}
