import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Genderdatabasehandler {
/*

  int? gc_seq;
  String gc_name;1


*/


  Future<Database> initializeDB() async{
  String path = await getDatabasesPath();
  return openDatabase(
    join(path,'user.db'),
    onCreate: (db, version) async{
      await db.execute(
        """
        create table gender_category
        (
        gc_seq integer primary key autoincrement,
        gc_name text
                
        
        )

        """
      );
    },
    version: 1,
  );
}
}