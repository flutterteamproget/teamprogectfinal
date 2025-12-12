import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RefundDatabasehandler {


  /*
int? ref_seq;
  int s_seq;
  int u_seq;
  int pic_seq;
  String ref_date;
  String ref_reason;1

  */
Future<Database> initializeDB() async{
  String path = await getDatabasesPath();
  return openDatabase(
    join(path,'user.db'),
    onCreate: (db, version) async{
      await db.execute(
        """
        create table refund
        (
        ref_seq integer primary key autoincrement,
        s_seq integer,
        u_seq integer,
        pic_seq integer,
        ref_date text,
        ref_reason text,
      
        
        
        )

        """
      );
    },
    version: 1,
  );
}


}