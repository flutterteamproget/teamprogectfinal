import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teamprogectfinal/model/branch.dart';


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
        br_name text,
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




 Future<List<Branch>> queryBranch() async{
    final Database db =await initializeDB();
    final List<Map<String,Object?>> result = await db.rawQuery(
      """
        select * 
        from branch
      """
    );
    return result.map((e) => Branch.fromMap(e)).toList();
  }



}
