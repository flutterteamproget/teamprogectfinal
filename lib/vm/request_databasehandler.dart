import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RequestDatabasehandler {
/*
int? req_seq;
  String? req_date;
  String req_content;
  int req_quantity;
  String req_manappdate;
  String req_dirappdate;
  String s_superseq;
  int? s_seq;1
  int? q_seq;
  int? m_seq;

*/
Future<Database> initializeDB() async{
  String path = await getDatabasesPath();
  return openDatabase(
    join(path,'user.db'),
    onCreate: (db, version) async{
      await db.execute(
        """
        create table request
        (
        req_seq integer primary key autoincrement,
        req_date text,
        req_content text,
        req_quntity integer,
        req_manappdate text,
        req_dirappdate text,
        s_superseq text,
        s_seq interger,
        q_seq interger,
        m_seq interger
      
        
        
        )

        """
      );
    },
    version: 1,
  );
}


}