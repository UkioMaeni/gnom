import 'package:gnom/pages/chat_page/store/chat_store.dart';
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
          push(
            id INTEGER PRIMARY KEY, 
            type TEXT
            )
          ''',
        );
        // await db.execute(
        //   '''
        //   CREATE TABLE IF NOT EXIST
        //   favorite(
        //     id INTEGER PRIMARY KEY, 
        //     name TEXT, 
        //     razdel TEXT, 
        //     category TEXT, 
        //     subcategory TEXT, 
        //     type TEXT, 
        //     price TEXT, 
        //     article TEXT, 
        //     img TEXT
        //     )
        //   ''',
        // );
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
  Future<void> dropDatabase() async {
   
    
    await deleteDatabase(path);
  }
}

SQLLite instanceDb=SQLLite();