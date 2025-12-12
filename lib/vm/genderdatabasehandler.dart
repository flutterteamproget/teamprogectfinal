import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teamprogectfinal/model/category_gender.dart';

class Genderdatabasehandler {
/*

  int? gc_seq;
  String gc_name;1


*/


  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path,'user.db'),
      onCreate: (db, version) async{
        await db.execute(
          """
          create table gender_category
          (
          gc_seq integer primary key autoincrement,
          gc_name text
                  
          
          )

          """
        );
      },
      version: 1,
    );
  }

  Future<List<CategoryGender>> queryGender() async{
    final Database db =await initializeDB();
    final List<Map<String,Object?>> result = await db.rawQuery(
      """
        select * 
        from gender_category
      """
    );
    return result.map((e) => CategoryGender.fromMap(e)).toList();
  }
}