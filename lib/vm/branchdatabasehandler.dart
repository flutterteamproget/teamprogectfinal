import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


/*
11
 int? br_seq;1
  String br_name;
  double br_lat;
  double br_lng;
  String br_address;
  String br_phone;


*/

class Branchdatabasehandler {


  Future<Database> initializeDB() async{
  String path = await getDatabasesPath();
  return openDatabase(
    join(path,'user.db'),
    onCreate: (db, version) async{
      await db.execute(
        """
        create table branch
        (
        br_seq integer primary key autoincrement,
        br_lat real,
        br_lng real,
        br_address text,
        br_phone text

        
        
        )

        """
      );
    },
    version: 1,
  );
}
}
