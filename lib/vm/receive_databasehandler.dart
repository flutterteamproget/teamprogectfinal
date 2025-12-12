import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ReceiveDatabasehandler {

/*
  int? rec_seq;
  int rec_quantity;
  String? rec_date;
  int? s_seq;
  int? p_seq;
  int? m_seq;1



*/

Future<Database> initializeDB() async{
  String path = await getDatabasesPath();
  return openDatabase(
    join(path,'user.db'),
    onCreate: (db, version) async{
      await db.execute(
        """
        create table receive
        (
        rec_seq integer primary key autoincrement,
        rec_quantity integer,
        rec_date text,
        s_seq integer,
        p_seq integer,
        b_seq integer
      
        
        
        )

        """
      );
    },
    version: 1,
  );
}



  
}