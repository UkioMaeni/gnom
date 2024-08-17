import 'package:flutter/material.dart';

class LText{
   Locale locale=Locale('en','EN');
}

LText LocaleText = LText();

  abstract interface class LocaleLibrary{
    String get education;
    String get artSpace;
    String get changes;
    String get choose;
    String get mathematics;
    String get paper;
    String get essay;
    String get presentation;
    String get shortcut;
    String get paraphrasing;
    String get adviseOn;
    String get imageGeneration;
    String get areYouSure;
    String get yes;
    String get no;
    String get  promptIsSent;
    String get  error;
    String get  theQueryRequiresTime;
    String get  done;
    String get  inProgress;
    String get  notAvailableForTrial;
    String get  remainingPrompts;
    String get  logIn;
    String get  logOut;
    String get  subscriptionPlan;
    String get  month;
    String get  subscriptions;
    String get  language;
    String get  chatSupport;
    String get locale;
    String get result_20s;
    String get result_30s;
    String get result_5m;
    String get result_3m;
}


class RuLocale implements LocaleLibrary{
  @override
  String get adviseOn => "дай совет";

  @override
  String get areYouSure => "вы действительно хотите запросить";

  @override
  String get artSpace => "творчество";

  @override
  String get changes => "изменения";

  @override
  String get chatSupport => "чат с поддержкой";

  @override
  String get choose => "выбери";

  @override
  String get done => "выполнено";

  @override
  String get education => "учёба";

  @override
  String get error => "произошла ошибка";

  @override
  String get essay => "сочинение";

  @override
  String get imageGeneration => "генерация\nкартинки";

  @override
  String get inProgress => "в процессе";

  @override
  String get language => "смена языка";

  @override
  String get logIn => "войти";

  @override
  String get logOut => "выйти";

  @override
  String get mathematics => "математика";

  @override
  String get month => "месяц";

  @override
  String get no => "нет";

  @override
  String get notAvailableForTrial => "недоступно для гостевого режима";

  @override
  String get paper => "реферат";

  @override
  String get paraphrasing => "перефразирование";

  @override
  String get presentation => "презентация";

  @override
  String get promptIsSent => "запрос отправлен, ожидайте";

  @override
  String get remainingPrompts => "общий остаток запросов";

  @override
  String get shortcut => "сокращение";

  @override
  String get subscriptionPlan => "план подписок";

  @override
  String get subscriptions => "подписки";

  @override
  String get theQueryRequiresTime => "Запрос требует времени на обработку. следите за уведомлениями";

  @override
  String get yes => "да";
  
  @override
  String get locale => "ru";
  
  @override
  String get result_20s => "результат в течение 20 сек.";
  
  @override
  String get result_30s => "результат в течение 30 сек.";
  
  @override
  String get result_3m => "результат в течение 3 минут";
  
  @override
  String get result_5m => "результат в течение 5 минут";
}

class EnLocale implements LocaleLibrary{
  @override
  String get adviseOn => "advise on";

  @override
  String get areYouSure => "Are you sure you want to input a query";

  @override
  String get artSpace => "art space";

  @override
  String get changes => "changes";

  @override
  String get chatSupport => "chatSupport";

  @override
  String get choose => "choose";

  @override
  String get done => "done";

  @override
  String get education => "education";

  @override
  String get error => "error";

  @override
  String get essay => "essay";

  @override
  String get imageGeneration => "Image\ngeneration";

  @override
  String get inProgress => "in progress";

  @override
  String get language => "language";

  @override
  String get logIn => "log in";

  @override
  String get logOut => "log out";

  @override
  String get mathematics => "mathematics";

  @override
  String get month => "month";

  @override
  String get no => "no";

  @override
  String get notAvailableForTrial => "not available for trial version";

  @override
  String get paper => "paper";

  @override
  String get paraphrasing => "paraphrasing";

  @override
  String get presentation => "presentation";

  @override
  String get promptIsSent => "prompt is sent, please wait";

  @override
  String get remainingPrompts => "remaining prompts";

  @override
  String get shortcut => "shortcut";

  @override
  String get subscriptionPlan => "subscription plan";

  @override
  String get subscriptions => "subscriptions";

  @override
  String get theQueryRequiresTime => "The query requires time to process, check the notifications";

  @override
  String get yes => "yes";
  
  @override
  String get locale => "en";
  
  @override
  // TODO: implement result_20s
  String get result_20s => "The result in 20 seconds";
  
  @override
  // TODO: implement result_30s
  String get result_30s => "The result in 30 seconds";
  
  @override
  // TODO: implement result_3m
  String get result_3m => "The result in 3 minutes";
  
  @override
  // TODO: implement result_5m
  String get result_5m => "The result in 5 minutes";
}

class ArLocale implements LocaleLibrary{
  @override
  String get adviseOn => "قدم نصيحة";

  @override
  String get areYouSure => "هل أنت متأكد من أنك تريد إرسال طلب";

  @override
  String get artSpace => "مساحة فنية";

  @override
  String get changes => "تغييرات";

  @override
  String get chatSupport => "خدمة العملاء المباشرة";

  @override
  String get choose => "اختر";

  @override
  String get done => "تم";

  @override
  String get education => "تعليم";

  @override
  String get error => "حدث خطأ";

  @override
  String get essay => "مقال";

  @override
  String get imageGeneration => "توليد الصور";

  @override
  String get inProgress => "قيد التنفيذ";

  @override
  String get language => "تغيير اللغة";

  @override
  String get logIn => "تسجيل الدخول";

  @override
  String get logOut => "تسجيل الخروج";

  @override
  String get mathematics => "رياضيات";

  @override
  String get month => "شهر";

  @override
  String get no => "لا";

  @override
  String get notAvailableForTrial => "غير متاح للوضع التجريبي";

  @override
  String get paper => "بحث";

  @override
  String get paraphrasing => "إعادة صياغة";

  @override
  String get presentation => "عرض تقديمي";

  @override
  String get promptIsSent => "تم إرسال الطلب، الرجاء الانتظار";

  @override
  String get remainingPrompts => "الطلبات المتبقية";

  @override
  String get shortcut => "اختصار";

  @override
  String get subscriptionPlan => "أنواع الاشتراكات";

  @override
  String get subscriptions => "الاشتراكات";

  @override
  String get theQueryRequiresTime => "يستغرق الطلب وقتا للمعالجة. راقب الإشعارات";

  @override
  String get yes => "نعم";
  
  @override
  String get locale => "ar";
  
  @override
  // TODO: implement result_20s
  String get result_20s => "النتيجة خلال ٢٠ ثانية";
  
  @override
  // TODO: implement result_30s
  String get result_30s =>"النتيجة خلال ٣٠ ثانية";
  
  @override
  // TODO: implement result_3m
  String get result_3m => "النتيجة خلال ٣ دقائق";
  
  @override
  // TODO: implement result_5m
  String get result_5m => "النتيجة خلال ٥ دقائق";
 
}