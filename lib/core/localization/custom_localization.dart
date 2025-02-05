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
    String get today;
    String get yesterday;
    String get deleteAccount;
    String get delete;
    String get cancel;
    String get deleteAccountWarning;
    //policy
    String get h1_title;
    String get h1_body;
    String get h2_title;
    String get h2_body;
    String get h3_title;
    String get h3_body;
    String get h4_title;
    String get h4_body;
    String get h5_title;
    String get h5_body;
    String get h6_title;
    String get h6_body;
    String get support;
    String get mailCompany;
    String get agree;
    String get valuta;
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
  
  @override
  // TODO: implement today
  String get today => "Сегодня";
  
  @override
  // TODO: implement yesterday
  String get yesterday => "Вчера";
  
  @override
  // TODO: implement cancel
  String get cancel => "отмена";
  
  @override
  // TODO: implement delete
  String get delete => "удалить";
  
  @override
  // TODO: implement deleteAccount
  String get deleteAccount => "удалить аккаунт";
  
  @override
  // TODO: implement deleteAccountWarning
  String get deleteAccountWarning =>
  '''Мы будем скучать по вам! Если у вас есть предложения, как мы можем улучшить наше приложение, чтобы оно стало для вас полезнее, напишите нам перед удалением.

Если вы всё же решили уйти, помните, что вы всегда можете вернуться – двери Гнома всегда открыты!

Ваши данные будут полностью удалены и не подлежат восстановлению.
Нажмите “Удалить”, если уверены в своём решении.''';

  @override
  // TODO: implement h1_body
  String get h1_body => "Политика конфиденциальности мобильного приложения «Gnom Helper»";

  @override
  // TODO: implement h1_title
  String get h1_title =>"Администрация мобильного приложения «Gnom Helper» обязуется сохранять вашу конфиденциальность в Интернете. Мы уделяем большое значение охране предоставленных вами данных. Наша политика конфиденциальности основана на требованиях Общего регламента о защите персональных данных Европейского Союза (GDPR). Мы собираем персональные данные в целях: улучшения работы нашего сервиса.";

  @override
  // TODO: implement h2_body
  String get h2_body => "Сбор и использование персональных данных";

  @override
  // TODO: implement h2_title
  String get h2_title => "Мы собираем и используем ваши персональные данные только в случае вашего добровольного согласия. При согласии с этим вы разрешаете нам собирать и использовать следующие данные: имя и фамилия, электронная почта.. Сбор и обработка ваших данных проводится соответствии с законами, действующими на территории Европейского Союза и в Российской Федерации.";

  @override
  // TODO: implement h3_body
  String get h3_body => "Хранение данных, изменение и удаление";

  @override
  // TODO: implement h3_title
  String get h3_title => "Пользователь, предоставивший свои персональные данные мобильному приложению «Gnom Helper» Пользователь имеет право на их изменение и удаление, а так же на отзыв своего согласия с их использованием. Ваши персональные данные будут хранится в течении времени, необходимого для использования данных для основной деятельности приложения, при завершении использования ваших данных администрация приложения удаляет их. Для доступа к своим персональным данным вы можете связаться с администрацией приложения «Gnom Helper» по вопросам, связанным с политикой конфиденциальности, можно с помощью формы обратной связи, указанной в разделе «Поддержка». Мы можем передавать ваши личные данные третьей стороне только с вашего добровольного согласия, если они были переданы, то изменение данных в других организациях, не связанных с нами, мы осуществить не можем.";

  @override
  // TODO: implement h4_body
  String get h4_body => "Предоставление информации детям";

  @override
  // TODO: implement h4_title
  String get h4_title => "Если Вы являетесь родителем или опекуном, и вы знаете, что ваши дети предоставили нам свои личные данные без вашего согласия, то свяжитесь с нами. В нашем приложении запрещено оставлять личные данные несовершеннолетних, без согласия родителей или опекунов.";

  @override
  // TODO: implement h5_body
  String get h5_body => "Изменения в политике конфиденциальности";

  @override
  // TODO: implement h5_title
  String get h5_title => "В нашем приложении может обновляться политика конфиденциальности время от времени. Мы сообщаем о любых изменениях, разместив новую политику конфиденциальности в телеграм канале https://t.me/+DAWR9qopOeAwMGVi или в самом приложении в разделе обновления. Мы отслеживаем изменения законодательства, касающегося персональных данных в Европейском Союзе и в Российской Федерации. Если вы оставили персональные данные у нас, то мы оповестим вас об изменении в политике конфиденциальности. Если ваши персональные данные были введены не корректно, то мы не сможем с вами связаться.";

  @override
  // TODO: implement h6_body
  String get h6_body => "Обратная связь, заключительные положения";

  @override
  // TODO: implement h6_title
  String get h6_title => "Если у вас есть вопросы по поводу политики конфиденциальности, вы можете связаться с администрацией приложения «Gnom Helper» через форму обратной связи, размещенную в разделе «Поддержка». В случае несогласия с данной политикой, пожалуйста, воздержитесь от использования нашего приложения и его услуг.";

  @override
  // TODO: implement mailCompany
  String get mailCompany => "Поддержка";

  @override
  // TODO: implement support
  String get support => "gnom2024@gnom-pomoshnik.com";
  
  @override
  // TODO: implement agree
  String get agree => "ПРИНЯТЬ";
  
  @override
  // TODO: implement valuta
  String get valuta => "₽";
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
  
  @override
  // TODO: implement today
  String get today => "Today";
  
  @override
  // TODO: implement yesterday
  String get yesterday => "Yesterday";
  
  @override
  // TODO: implement cancel
  String get cancel => "cancel";
  
  @override
  // TODO: implement delete
  String get delete => "delete";
  
  @override
  // TODO: implement deleteAccount
  String get deleteAccount => "delete account";
  
  @override
  // TODO: implement deleteAccountWarning
  String get deleteAccountWarning => '''We will miss you! If you have any suggestions on how we can improve our app to make it more useful for you, please let us know before deleting your account.

If you still decide to leave, remember that you can always come back – the Gnome doors are always open!

Your data will be completely deleted and cannot be recovered.
Click “Delete” if you’re sure about your decision.''';

  @override
  // TODO: implement h1_body
  String get h1_body => "Privacy Policy for the mobile application «Gnom Helper»";

  @override
  // TODO: implement h1_title
  String get h1_title => "The administration of the mobile application «Gnom Helper» is committed to preserving your privacy on the Internet. We place a high priority on protecting the data you provide to us. Our privacy policy is based on the requirements of the General Data Protection Regulation (GDPR) of the European Union. We collect personal data for the purpose of improving our service.";

  @override
  // TODO: implement h2_body
  String get h2_body => "Collection and use of personal data";

  @override
  // TODO: implement h2_title
  String get h2_title => "We collect and use your personal data only with your voluntary consent. By agreeing to this, you allow us to collect and use the following data: name and surname, email address. The collection and processing of your data is carried out in accordance with the laws in force in the European Union and the Russian Federation.";

  @override
  // TODO: implement h3_body
  String get h3_body => "Data storage, modification, and deletion";

  @override
  // TODO: implement h3_title
  String get h3_title => "The user who has provided their personal data to the mobile application «Gnom Helper» has the right to modify and delete them, as well as to withdraw their consent to their use. Your personal data will be stored for the period necessary to use the data for the main activities of the application. After the use of your data is completed, the application administration will delete them. To access your personal data, you can contact the administration of the «Gnom Helper» application through the feedback form provided in the «Support» section. We can transfer your personal data to a third party only with your voluntary consent. If they are transferred, we cannot modify the data in other organizations not associated with us.";

  @override
  // TODO: implement h4_body
  String get h4_body => "Providing information to children";

  @override
  // TODO: implement h4_title
  String get h4_title => "If you are a parent or guardian and you know that your children have provided us with their personal data without your consent, please contact us. It is prohibited in our application to leave personal data of minors without the consent of parents or guardians.";

  @override
  // TODO: implement h5_body
  String get h5_body => "Changes to the privacy policy";

  @override
  // TODO: implement h5_title
  String get h5_title => "Our application may update the privacy policy from time to time. We will notify you of any changes by posting the new privacy policy in the Telegram channel https://t.me/+DAWR9qopOeAwMGVi or in the application itself in the «Updates» section. We monitor changes in legislation regarding personal data in the European Union and the Russian Federation. If you have provided us with personal data, we will notify you of changes to the privacy policy. If your personal data has been entered incorrectly, we will not be able to contact you.";

  @override
  // TODO: implement h6_body
  String get h6_body => "Feedback and final provisions";

  @override
  // TODO: implement h6_title
  String get h6_title => "If you have any questions regarding the privacy policy, you can contact the administration of the «Gnom Helper» application through the feedback form located in the «Support» section. If you do not agree with this privacy policy, please refrain from using our application and its services.";

  @override
  // TODO: implement mailCompany
  String get mailCompany => "gnom2024@gnom-pomoshnik.com";

  @override
  // TODO: implement support
  String get support => "Support";
  
  @override
  // TODO: implement agree
  String get agree => "AGREE";
  
  @override
  // TODO: implement valuta
  String get valuta => "\$";
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
  
  @override
  // TODO: implement today
  String get today => "اليوم";
  
  @override
  // TODO: implement yesterday
  String get yesterday => "أمس";
  
  @override
  // TODO: implement cancel
  String get cancel => "إلغاء";
  
  @override
  // TODO: implement delete
  String get delete => "يمسح";
  
  @override
  // TODO: implement deleteAccount
  String get deleteAccount =>" حذف الحساب";
  
  @override
  // TODO: implement deleteAccountWarning
  String get deleteAccountWarning => '''سنفتقدك! إذا كانت لديك أي اقتراحات حول كيفية تحسين تطبيقنا ليكون أكثر فائدة لك، يرجى إخبارنا قبل حذف حسابك.

إذا قررت المغادرة، تذكر أنك دائمًا مرحب بك للعودة – أبواب القزم مفتوحة دائمًا!

سيتم حذف بياناتك بالكامل ولن يمكن استعادتها.
اضغط على “حذف” إذا كنت متأكدًا من قرارك.''';

  @override
  // TODO: implement h1_body
  String get h1_body => "سياسة الخصوصية لتطبيق «Gnom Helper»";

  @override
  // TODO: implement h1_title
  String get h1_title => "تلتزم إدارة تطبيق «Gnom Helper» بالحفاظ على خصوصيتك على الإنترنت. نحن نولي أهمية كبيرة لحماية البيانات التي تقدمها لنا. تعتمد سياسة الخصوصية لدينا على متطلبات اللائحة العامة لحماية البيانات (GDPR) الخاصة بالاتحاد الأوروبي. نحن نجمع البيانات الشخصية بهدف تحسين خدماتنا.";

  @override
  // TODO: implement h2_body
  String get h2_body => "جمع واستخدام البيانات الشخصية";

  @override
  // TODO: implement h2_title
  String get h2_title => "قوم بجمع واستخدام بياناتك الشخصية فقط بموافقتك الطوعية. عند الموافقة على ذلك، فإنك تسمح لنا بجمع واستخدام البيانات التالية: الاسم واللقب، البريد الإلكتروني. يتم جمع ومعالجة بياناتك وفقًا للقوانين المعمول بها في الاتحاد الأوروبي والاتحاد الروسي.";

  @override
  // TODO: implement h3_body
  String get h3_body => "تخزين البيانات وتغييرها وحذفها";

  @override
  // TODO: implement h3_title
  String get h3_title => "للمستخدم الذي قدم بياناته الشخصية لتطبيق «Gnom Helper» الحق في تغييرها وحذفها وكذلك سحب موافقته على استخدامها. سيتم تخزين بياناتك الشخصية خلال الفترة الزمنية اللازمة لاستخدامها في الأنشطة الرئيسية للتطبيق. عند الانتهاء من استخدام بياناتك، ستقوم إدارة التطبيق بحذفها. للوصول إلى بياناتك الشخصية، يمكنك الاتصال بإدارة التطبيق «Gnom Helper» عبر نموذج الاتصال الموجود في قسم «الدعم». يمكننا نقل بياناتك الشخصية إلى طرف ثالث فقط بموافقتك الطوعية. إذا تم نقلها، لا يمكننا تعديل البيانات في المنظمات الأخرى غير المرتبطة بنا.";

  @override
  // TODO: implement h4_body
  String get h4_body => "توفير المعلومات للأطفال";

  @override
  // TODO: implement h4_title
  String get h4_title => "إذا كنت أحد الوالدين أو الوصي وتعلم أن أطفالك قدموا لنا بياناتهم الشخصية دون موافقتك، يرجى الاتصال بنا. في تطبيقنا، يُحظر تقديم البيانات الشخصية للقُصر دون موافقة الوالدين أو الأوصياء.";

  @override
  // TODO: implement h5_body
  String get h5_body => "تغييرات في سياسة الخصوصية";

  @override
  // TODO: implement h5_title
  String get h5_title => "قد يتم تحديث سياسة الخصوصية في تطبيقنا من وقت لآخر. سنعلمك بأي تغييرات من خلال نشر سياسة الخصوصية الجديدة في قناة التلغرام https://t.me/+DAWR9qopOeAwMGVi أو في التطبيق نفسه في قسم التحديثات. نحن نتابع التغييرات في التشريعات المتعلقة بالبيانات الشخصية في الاتحاد الأوروبي والاتحاد الروسي. إذا كنت قد قدمت بياناتك الشخصية لنا، فسنبلغك بتغييرات في سياسة الخصوصية. إذا تم إدخال بياناتك الشخصية بشكل غير صحيح، فلن نتمكن من الاتصال بك.";

  @override
  // TODO: implement h6_body
  String get h6_body => "الاتصال وإخلاء المسؤولية";

  @override
  // TODO: implement h6_title
  String get h6_title => "إذا كانت لديك أي أسئلة بخصوص سياسة الخصوصية، يمكنك الاتصال بإدارة تطبيق «Gnom Helper» من خلال نموذج الاتصال الموجود في قسم «الدعم». في حالة عدم موافقتك على هذه السياسة، يُرجى الامتناع عن استخدام تطبيقنا وخدماته.";

  @override
  // TODO: implement mailCompany
  String get mailCompany => "gnom2024@gnom-pomoshnik.com";

  @override
  // TODO: implement support
  String get support => "الدعم";
  
  @override
  // TODO: implement agree
  String get agree => "يوافق";
  
  @override
  // TODO: implement valuta
  String get valuta => "\$";
 
}