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
    String get  remainingPrompts_1;
    String get  remainingPrompts_2;
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
    String get miniGame;
    String get answer;
    String get download;
    String get open;
    String get notifications;
    String get writeAMessage;
    String get settings;
    String get topic;
    String get sendPresentation;
    String get sendSovet;
    String get sendEssay;
    String get sendReport;
    String get sendImage;
    String get sendReduction;
    String get sendParafrase;
    String get sendRequest;
    String get uploadImage;
    String get mathError;
    String get essayError;
    String get reportError;
    String get presentationError;
    String get back;
    String get question;
    String get copy;
    String get saveToGalery;
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
  String get done => "готово";

  @override
  String get education => "учёба";

  @override
  String get error => "ошибка";

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
  String get remainingPrompts_1 => "общий";

  @override
  String get remainingPrompts_2 => "остаток запросов";

  @override
  String get shortcut => "сокращение";

  @override
  String get subscriptionPlan => "план подписок";

  @override
  String get subscriptions => "подписки";

  @override
  String get theQueryRequiresTime => "Запрос требует времени на обработку. Следите за уведомлениями";

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
  
  @override
  // TODO: implement answer
  String get answer => "ответ";
  
  @override
  // TODO: implement download
  String get download => "скачать";
  
  @override
  // TODO: implement miniGame
  String get miniGame => "мини игра";
  
  @override
  // TODO: implement notifications
  String get notifications => "уведомления";
  
  @override
  // TODO: implement open
  String get open => "открыть";
  
  @override
  // TODO: implement settings
  String get settings => "настройки";
  
  @override
  // TODO: implement writeAMessage
  String get writeAMessage => "Напишите сообщение";
  
  @override
  // TODO: implement topic
  String get topic => "Тема";
  
  @override
  // TODO: implement sendEssay
  String get sendEssay => "Написать сочинение на тему";
  
  @override
  // TODO: implement sendImage
  String get sendImage => "Сгенерировать картинку по запросу";
  
  @override
  // TODO: implement sendPresentation
  String get sendPresentation => "Создать презентацию на тему";
  
  @override
  // TODO: implement sendReport
  String get sendReport => "Написать реферат на тему";
  
  @override
  // TODO: implement sendSovet
  String get sendSovet => "Помочь советом по теме";
  
  @override
  // TODO: implement sendParafrase
  String get sendParafrase => "Убедитесь, что в исходном тексте нет ошибок, так как они могут повлиять на качество итогового результата после сокращения.";
  
  @override
  // TODO: implement sendReduction
  String get sendReduction => "Убедитесь, что в исходном тексте нет ошибок, так как они могут повлиять на качество итогового результата после перефразирования.";
  
  @override
  // TODO: implement sendRequest
  String get sendRequest => "Отправить запрос";
  
  @override
  // TODO: implement uploadImage
  String get uploadImage => "Загрузите изображение";
  
  @override
  // TODO: implement essayError
  String get essayError => "Ошибка при генерации сочинения";
  
  @override
  // TODO: implement mathError
  String get mathError => "Ошибка при вычислениях";
  
  @override
  // TODO: implement presentationError
  String get presentationError => "Ошибка в генерации презентации";
  
  @override
  // TODO: implement reportError
  String get reportError => "Ошибка в генерации реферата";
  @override
  // TODO: implement reportError
  String get back => "Назад";
  
  @override
  // TODO: implement qustion
  String get question => "Вопрос";
  
  @override
  // TODO: implement copy
  String get copy => "Скопировать";
  
  @override
  // TODO: implement saveToGalery
  String get saveToGalery => "Сохранить в галерею";
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
  String get remainingPrompts_1 => "remaining";

  @override
  String get remainingPrompts_2 => "prompts";

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
  
  @override
  // TODO: implement answer
  String get answer => "answer";
  
  @override
  // TODO: implement download
  String get download => "download";
  
  @override
  // TODO: implement miniGame
  String get miniGame => "mini пame";
  
  @override
  // TODO: implement notifications
  String get notifications => "notifications";
  
  @override
  // TODO: implement open
  String get open => "open";
  
  @override
  // TODO: implement settings
  String get settings => "settings";
  
  @override
  // TODO: implement writeAMessage
  String get writeAMessage => "write a message";
  
  @override
  // TODO: implement topic
  String get topic => "Topic";
  
  @override
  // TODO: implement sendEssay
  String get sendEssay => "Write an essay on the topic";
  
  @override
  // TODO: implement sendImage
  String get sendImage => "Generate a picture upon request";
  
  @override
  // TODO: implement sendPresentation
  String get sendPresentation => "Create a presentation on the topic";
  
  @override
  // TODO: implement sendReport
  String get sendReport => "Write a report on the topic";
  
  @override
  // TODO: implement sendSovet
  String get sendSovet => "Help with advice on the topic";
  
  @override
  // TODO: implement sendParafrase
  String get sendParafrase => "Make sure there are no mistakes in the original text, as they may affect the quality of the final result after summarization.";
  
  @override
  // TODO: implement sendReduction
  String get sendReduction => "Make sure there are no mistakes in the original text, as they may affect the quality of the final result after paraphrasing.";
  
  @override
  // TODO: implement sendRequest
  String get sendRequest => "Send request";
  
  @override
  // TODO: implement uploadImage
  String get uploadImage => "Upload an image";
  
  @override
  // TODO: implement essayError
  String get essayError => "Error during essay generation";
  
  @override
  // TODO: implement mathError
  String get mathError => "Calculation error";
  
  @override
  // TODO: implement presentationError
  String get presentationError => "Error in presentation generation";
  
  @override
  // TODO: implement reportError
  String get reportError => "Error in report generation";
  @override
  // TODO: implement reportError
  String get back => "Back";
  
  @override
  // TODO: implement qustion
  String get question => "Question";
  
  @override
  // TODO: implement copy
  String get copy => "Copy";
  
  @override
  // TODO: implement saveToGalery
  String get saveToGalery => "Save to galery";
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
  String get remainingPrompts_1 => "الطلبات";

  @override
  String get remainingPrompts_2 => "المتبقية";

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
  
  @override
  // TODO: implement answer
  String get answer => "جواب";
  
  @override
  // TODO: implement download
  String get download => "تحميل";
  
  @override
  // TODO: implement miniGame
  String get miniGame => "لعبة مصغرة";
  
  @override
  // TODO: implement notifications
  String get notifications => "إشعارات";
  
  @override
  // TODO: implement open
  String get open => "افتح";
  
  @override
  // TODO: implement settings
  String get settings => "الإعدادات";
  
  @override
  // TODO: implement writeAMessage
  String get writeAMessage => "اكتب رسالة";
  
  @override
  // TODO: implement topic
  String get topic => "موضوع";
  
  @override
  // TODO: implement sendEssay
  String get sendEssay => "كتابة مقالة حول الموضوع";
  
  @override
  // TODO: implement sendImage
  String get sendImage => "إنشاء صورة بناءً على الطلب";
  
  @override
  // TODO: implement sendPresentation
  String get sendPresentation => "إنشاء عرض تقديمي حول الموضوع";
  
  @override
  // TODO: implement sendReport
  String get sendReport => "كتابة تقرير حول الموضوع";
  
  @override
  // TODO: implement sendSovet
  String get sendSovet => "المساعدة بنصيحة حول الموضوع";
  
  @override
  // TODO: implement sendParafrase
  String get sendParafrase => "تأكد من عدم وجود أخطاء في النص الأصلي، لأنها قد تؤثر على جودة النتيجة النهائية بعد التلخيص.";
  
  @override
  // TODO: implement sendReduction
  String get sendReduction => "تأكد من عدم وجود أخطاء في النص الأصلي، لأنها قد تؤثر على جودة النتيجة النهائية بعد إعادة الصياغة.";
  
  @override
  // TODO: implement sendRequest
  String get sendRequest =>"إرسال طلب";
  
  @override
  // TODO: implement uploadImage
  String get uploadImage => "تحميل صورة";
  @override
  // TODO: implement essayError
  String get essayError => "خطأ أثناء توليد المقال";
  
  @override
  // TODO: implement mathError
  String get mathError => "خطأ في الحسابات";
  
  @override
  // TODO: implement presentationError
  String get presentationError => "خطأ في توليد العرض التقديمي";
  
  @override
  // TODO: implement reportError
  String get reportError => "خطأ في توليد التقرير";
  @override
  // TODO: implement reportError
  String get back => "خلف";
  @override
  // TODO: implement reportError
  String get question => "سؤال";
  
  @override
  // TODO: implement copy
  String get copy => "ينسخ";
  
  @override
  // TODO: implement saveToGalery
  String get saveToGalery => "حفظ في المعرض";
 
}