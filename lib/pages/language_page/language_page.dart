import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gnom/UIKit/UIChevron.dart';
import 'package:gnom/core/app_localization.dart';
import 'package:gnom/pages/main_page/main_page.dart';
import 'package:gnom/repositories/locale_storage.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  late final PageController _pageController;
  @override
  void initState() {
    _pageController=PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void leftClick(){
    if(page<=0) return;
    _pageController.animateToPage(page-1, duration: const Duration(milliseconds: 200), curve: Curves.linear);

  }
  void rightClick(){
    if(page>=AppLocalization.localeCount()-1) return;
    _pageController.animateToPage(page+1, duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  int page=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/jpg/app_bg.jpg"),
                  fit: BoxFit.cover
                )
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const SizedBox(height: 80,),
                    Text(
                      AppLocalization.getLocaleDescription(AppLocalization.listlocations[page]),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        fontFamily: "NoirPro",
                        height: 1,
                        letterSpacing: 1,
                        color: Color.fromRGBO(254, 222,181, 1)
                        ),
                    ),
                    const SizedBox(height: 100,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        UIChevron(
                          type: EChevronType.left,
                          onClick: leftClick,
                        ),
                        SizedBox(
                          width: 250,
                          height: 40,
                          child:PageView.builder(
                            controller: _pageController,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (value) {
                              setState(() {
                                page=value;
                              });
                            },
                            itemCount: AppLocalization.localeCount(),
                            itemBuilder: (context, index) {
                              final locale=AppLocalization.listlocations[index];
                              AppLocalization.currentLocale=AppLocalization.listlocations[index];
                              return Text(
                                        AppLocalization.getLocaleName(locale),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w800,
                                          fontFamily: "NoirPro",
                                          height: 1,
                                          letterSpacing: 1,
                                          color: Colors.white
                                          ),
                                      );
                            },
                          ) 
                        ),
                        UIChevron(
                          type: EChevronType.right,
                          onClick: rightClick,
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    setLanguageButton(),
                    const SizedBox(height: 80,)
                  ],
                ),
              ),
            ),
    );
  }
Widget setLanguageButton(){
  return GestureDetector(
    onTap: () async{
      print(AppLocalization.currentLocale.toString());
       await localeStorage.saveAppLanguage(AppLocalization.currentLocale.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage(),));
    },
    child: SizedBox(
      width: 140,
      height: 46,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(199, 117, 117, 0.322),
          borderRadius: BorderRadius.circular(17)
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
                    AppLocalization.getLocaleButtonStart(AppLocalization.listlocations[page]),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontFamily: "NoirPro",
                      height: 1,
                      letterSpacing: 1,
                      color: Color.fromRGBO(254, 222,181, 1)
                      ),
                  ),
        ),
      ),
    ),
  );
}

}

