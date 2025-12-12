import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SizeCategoryDatabasehandler {


/*

int? sc_seq;
  String sc_name;1
*/
Future<Database> initializeDB() async{
  String path = await getDatabasesPath();
  return openDatabase(
    join(path,'user.db'),
    onCreate: (db, version) async{
      await db.execute(
        """
        create table size_category
        (
        sc_seq integer primary key autoincrement,
        sc_name text
                
        
        )

        """
      );
    },
    version: 1,
  );
}
}