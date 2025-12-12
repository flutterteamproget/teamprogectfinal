import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teamprogectfinal/model/maker.dart';

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
        m_name text
       

        
        
        )

        """
      );
    },
    version: 1,
  );
}

 Future<List<Maker>> queryMaker() async{
    final Database db =await initializeDB();
    final List<Map<String,Object?>> result = await db.rawQuery(
      """
        select * 
        from maker
      """
    );
    return result.map((e) => Maker.fromMap(e)).toList();
  }
}