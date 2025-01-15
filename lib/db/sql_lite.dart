import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gnom/pages/chat_page/store/chat_store.dart';
import 'package:gnom/pages/main_page/tabs/history_tab/history_tab.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLLite{
  String path="";

  Future getPath()async{
       String newPath= join(await getDatabasesPath(), 'my_database.db');
      path=newPath;
  }
  Future<bool> createDB() async {
    print("create");
    try {
     Database db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version)async {
        print("proccessing");
        await db.execute(
          '''
          CREATE TABLE IF NOT EXISTS
          messages(
            id TEXT, 
            text TEXT, 
            status TEXT, 
            sender TEXT, 
            name TEXT, 
            link TEXT,
            type TEXT,
            fileBuffer TEXT
            )
          ''',
        );
        await db.execute(
          '''
          CREATE TABLE IF NOT EXISTS
          favorite(
            id INTEGER PRIMARY KEY,
            qpath TEXT,
            apath TEXT,
            qisDocument TEXT,
            aisDocument TEXT,
            question TEXT, 
            favorite TEXT, 
            type TEXT, 
            progress TEXT, 
            messageId TEXT, 
            answer TEXT,
            fileBuffer TEXT, 
            answerBuffer TEXT, 
            answerMessageId TEXT
            )
          ''',
        );
      },
    );
    print("created");
    return true;
    } catch (e) {
      print(e);
      return false;
    }
    
  } 
  addMessage(SubjectTypedMessage message)async{
    final Database db = await openDatabase(path);
    await db.insert(
          "messages",
          message.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
  }
  Future<List<SubjectTypedMessage>> getMessages()async{
    final Database db = await openDatabase(path);
    final List<Map<String, dynamic>> messages = await db.query('messages');
    List<SubjectTypedMessage> mess=[];
    for(var element in messages){
      final Message message=Message(id: element["id"],link: element["link"], status: element["status"], text: element["text"], sender: element["sender"],fileBuffer: element["fileBuffer"]);
      mess.add(SubjectTypedMessage(subjectType: element["type"],message: message));
    }
    return mess;
  }
  Future<List<HistoryModel>> getHistory()async{
    final Database db = await openDatabase(path);
    final List<Map<String, dynamic>> historyesFromDb = await db.query('favorite');
    List<HistoryModel> historyes=[];
    
    for(var element in historyesFromDb){
      print(element["favorite"]);
      print("///");
      final HistoryModel his=HistoryModel(
        answer: element["answer"],
        answerMessageId: element["answerMessageId"], 
        favorite: element["favorite"]=="true"?true:false, 
        icon: SizedBox.shrink(), 
        messageId: element["messageId"],
        progress: element["progress"],
        question: element["question"],
        AisDocument: element["aisDocument"]=="true"?true:false,
        QisDocument: element["qisDocument"]=="true"?true:false,
        Apath: element["apath"],
        Qpath: element["qpath"],
        answerBuffer:element["answerBuffer"],
        type: element["type"]
        );
      historyes.add(his);
    }
    return historyes;
  }
  Future<bool> updateStatusForDownloadFile(String id,String pathFile)async{
    try {
      final Database db = await openDatabase(path);
      db.update(
        "messages", 
        {
          "link":pathFile,
          "text":"file"
        },
        where: 'id = ?',
        whereArgs: [id]
      );
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> addHistory(HistoryModel model)async{
    try {
      final Database db = await openDatabase(path);
      await db.insert(
          "favorite",
          model.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> updateHistoryProgress(String messageId,String progress)async{
    try {
      final Database db = await openDatabase(path);
      await db.update(
          "favorite",
          {
            "progress":progress,
            
          },
          where: 'messageId = ?',
          whereArgs: [messageId],
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> updateHistoryAnswer(String messageId,String answer)async{
    try {
      final Database db = await openDatabase(path);
      await db.update(
          "favorite",
          {
            "answer":answer,
            
          },
          where: 'messageId = ?',
          whereArgs: [messageId],
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> updateHistoryAnswerInDocument(String messageId,String documentPath,String documentType,Uint8List buffer)async{
    try {
      final Database db = await openDatabase(path);
      await db.update(
          "favorite",
          {
            "aisDocument":"true",
            "apath":documentPath,
            "answer":documentType,
            "answerBuffer":buffer
          },
          where: 'messageId = ?',
          whereArgs: [messageId],
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> updateHistoryFavorite(String id,bool favorite)async{
    try {
      final Database db = await openDatabase(path);
      print(favorite.toString());
      print("+");
      db.update(
        "favorite", 
        {
          "favorite":favorite.toString(),
        },
        where: 'messageId = ?',
        whereArgs: [id]
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> dropDatabase() async {
   
    
    await deleteDatabase(path);
  }
}

SQLLite instanceDb=SQLLite();