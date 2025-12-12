import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class KindCategoryDatabasehandler {
/*

int? kc_seq;
String kc_name;


*/

Future<Database> initializeDB() async{
  String path = await getDatabasesPath();
  return openDatabase(
    join(path,'user.db'),
    onCreate: (db, version) async{
      await db.execute(
        """
        create table kind_category
        (
        kc_seq integer primary key autoincrement,
        kc_name text
                
        
        )

        """
      );
    },
    version: 1,
  );
}

}