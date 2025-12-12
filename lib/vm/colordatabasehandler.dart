import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Colordatabasehandler {
  /*
  int? cc_seq;
  String cc_name;
111

  */

Future<Database> initializeDB() async{
  String path = await getDatabasesPath();
  return openDatabase(
    join(path,'user.db'),
    onCreate: (db, version) async{
      await db.execute(
        """
        create table color_category
        (
        cc_seq integer primary key autoincrement,
        cc_name text
        

        
        
        )

        """
      );
    },
    version: 1,
  );
}



}