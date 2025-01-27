import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnom/core/localization/localization_bloc.dart';
import 'package:gnom/core/tools/string_tool.dart';
import 'package:gnom/pages/main_page/tabs/profile_tab/components/plaining_subcribtion/animations_planings.dart';
import 'package:gnom/pages/main_page/tabs/profile_tab/profile_tab.dart';

List options=[
  [10,10,10,10,10,10,10,10],
  [30,30,30,30,30,30,30,30],
  [20,20,20,20,20,20,20,20]
];




class PlaneInfo extends StatefulWidget {
  final Function(bool) setOpen;
  final int openTypeIndex;
  final double price;
  const PlaneInfo({super.key,required this.setOpen,required this.openTypeIndex,required this.price});

  @override
  State<PlaneInfo> createState() => _PlaneInfoState();
}

class _PlaneInfoState extends State<PlaneInfo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              widget.setOpen(false);
            },
            onVerticalDragUpdate: (details) {
              
            },
          ),
        ),
        Positioned(
          top: 80,
          left: 30,
          right: 30,
          child: Container(
            width: 200,
            
            constraints: BoxConstraints(
              minHeight: 440
            ),
            decoration: BoxDecoration(
              color:widget.openTypeIndex==1?Colors.red: Colors.white,
              image:widget.openTypeIndex==1? DecorationImage(
                  image: AssetImage("assets/png/app_bg.png"),
                  fit: BoxFit.cover
                ):null,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text(
                  widget.openTypeIndex==0?"BRONZE": widget.openTypeIndex==1?"GOLD":"SILVER",
                  style: TextStyle(
                    fontFamily: "NoirPro",
                    color:widget.openTypeIndex==1?Colors.white: Color.fromARGB(255, 82, 81, 81),
                    height: 1,
                    fontWeight: FontWeight.w700,
                    fontSize: 35
                  ),
                ),
                SizedBox(height: 10,),
                Builder(
                  builder: (context) {
                    final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                    return Text(
                      "1 "+StringTools.firstUpperOfString(state.locale.month),
                      style: TextStyle(
                        fontFamily: "NoirPro",
                        color:widget.openTypeIndex==1?Colors.white: Color.fromARGB(255, 82, 81, 81),
                        height: 1,
                        fontWeight: FontWeight.w700,
                        fontSize: 15
                      ),
                    );
                  }
                ),
                SizedBox(height: 10,),
                Stack(
                  alignment: Alignment.center,
                    children: [
                      SizedBox(height: 30,),
                      Container(
                        width: double.infinity,
                        height: 5,
                        color: Color.fromARGB(255, 218, 217, 217),
                      ),
                      Positioned(
                        left: -15,
                        top: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 218, 217, 217),
                            borderRadius: BorderRadius.circular(15)
                          ),
                        )
                      ),
                      Positioned(
                        right: -15,
                        top: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 218, 217, 217),
                            borderRadius: BorderRadius.circular(15)
                          ),
                        )
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${widget.price.toInt()}Р",
                        style: TextStyle(
                          fontFamily: "NoirPro",
                          color:widget.openTypeIndex==1?Colors.white: Color.fromARGB(255, 82, 81, 81),
                          height: 1,
                          fontWeight: FontWeight.w700,
                          fontSize: 35
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                          return Text(
                            "/${StringTools.firstUpperOfString(state.locale.month)}",
                            style: TextStyle(
                              fontFamily: "NoirPro",
                              color:widget.openTypeIndex==1?Colors.white: Color.fromARGB(255, 82, 81, 81),
                              height: 1,
                              fontWeight: FontWeight.w700,
                              fontSize: 17
                            ),
                          );
                        }
                      ),
                      
                    ],
                  ),
                  SizedBox(height: 30,),
                  Builder(
                    builder: (context) {
                      final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState);
                      return Column(
                        children: [
                          punkt("${StringTools.firstUpperOfString(state.locale.mathematics)} - ${options[widget.openTypeIndex%3][0]}"),
                          punkt("${StringTools.firstUpperOfString(state.locale.essay)} - ${options[widget.openTypeIndex%3][1]}"),
                          punkt("${StringTools.firstUpperOfString(state.locale.presentation)} - ${options[widget.openTypeIndex%3][2]}"),
                          punkt("${StringTools.firstUpperOfString(state.locale.adviseOn)} - ${options[widget.openTypeIndex%3][3]}"),
                          punkt("${StringTools.firstUpperOfString(state.locale.shortcut)} - ${options[widget.openTypeIndex%3][4]}"),
                          punkt("${StringTools.firstUpperOfString(state.locale.paper)} - ${options[widget.openTypeIndex%3][5]}"),
                          punkt("${StringTools.firstUpperOfString(state.locale.paraphrasing)} - ${options[widget.openTypeIndex%3][6]}"),
                          punkt("${StringTools.firstUpperOfString(state.locale.imageGeneration)} - ${options[widget.openTypeIndex%3][7]}"),
                          // punkt("СОЧИНЕНИЕ - 80"),
                          // punkt("ПЕРЕЗЕНТАЦИИ - 80"),
                          // punkt("ДАЙ СОВЕТ - 80"),
                          // punkt("СОКРАЩЕНИЕ - 80"),
                          // punkt("РЕФЕРАТ - 80"),
                          // punkt("ПЕРЕФРАЗИРОВАНИЕ - 80"),
                        ],
                      );
                    }
                  )
                  
              ],
            ),
          ),
        ),
        Builder(
          builder: (context) {
            print(widget.openTypeIndex);
            if(widget.openTypeIndex==0){
              return Positioned(
                bottom: 92,
                left: 40,
                child: FirstElementPlaning(onTap: (_){},color: Colors.amber,scaleView: 1,price: prices[0])

              );
            }
            if(widget.openTypeIndex==1){
              return Positioned(
                bottom: 83,
                child: FirstElementPlaning(onTap: (_){},color: Colors.amber,scaleView: 1.3,price: prices[1])

              );
            }
            if(widget.openTypeIndex==2){
              return Positioned(
                bottom: 92,
                right: 40,
                child: FirstElementPlaning(onTap: (_){},color: Colors.amber,scaleView: 1,price: prices[2])

              );
            }
            return SizedBox.shrink();
          },
        )
        
        // Positioned(
        //   bottom: 86,
        //   left: 20,
        //   child: FirstElementPlaning(onTap: (_){},)
        // )
      ],
    );
  }

  Widget punkt(String title){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        child: Row(
          children: [
            SizedBox(width: 20,),
            SizedBox(
              width: 10,
              height: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color:widget.openTypeIndex==1?Colors.white: Color.fromARGB(255, 82, 81, 81)
                )
              )
            ),
            SizedBox(width: 10,),
            Text(
              title,
              style: TextStyle(
                fontFamily: "NoirPro",
                color:widget.openTypeIndex==1?Colors.white: Color.fromARGB(255, 82, 81, 81),
                height: 1,
                fontWeight: FontWeight.w700,
                fontSize: 17
              ),
            ),
          ],
        ),
      ),
    );
  }

}