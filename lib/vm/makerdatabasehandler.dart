import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Makerdatabasehandler {
/*
int? m_seq;
  String m_phone;
  String m_address;
  String m_name;

  */

  


  Future<Database> initializeDB() async{
  String path = await getDatabasesPath();
  return openDatabase(
    join(path,'user.db'),
    onCreate: (db, version) async{
      await db.execute(
        """
        create table maker
        (
        m_seq integer primary key autoincrement,
        m_phone text,
        m_name text,
       

        
        
        )

        """
      );
    },
    version: 1,
  );
}


}