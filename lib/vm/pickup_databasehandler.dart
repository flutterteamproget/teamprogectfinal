import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PickupDatabasehandler {

/*
 int? pic_seq;
  String? pic_date;
  int? b_seq;1

*/
  Future<Database> initializeDB() async{
  String path = await getDatabasesPath();
  return openDatabase(
    join(path,'user.db'),
    onCreate: (db, version) async{
      await db.execute(
        """
        create table pickup
        (
        pic_seq integer primary key autoincrement,
        pic_date text,
        b_seq integer
       

        
        
        )

        """
      );
    },
    version: 1,
  );
}

}