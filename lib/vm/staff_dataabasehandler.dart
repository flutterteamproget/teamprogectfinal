import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class StaffDataabasehandler {


  /*
  int? s_seq;
  String s_branch;
  String s_rank;
  String s_phone;
  Uint8List s_image;
  int s_superseq;
  String s_password;1

  */
Future<Database> initializeDB() async{
  String path = await getDatabasesPath();
  return openDatabase(
    join(path,'user.db'),
    onCreate: (db, version) async{
      await db.execute(
        """
        create table staff
        (
        s_seq integer primary key autoincrement,
        s_branch text,
        s_rank text,
        s_phone text,
        s_image blob,
        s_superseq integer,
        s_password text
    
        )

        """
      );
    },
    version: 1,
  );
}


}