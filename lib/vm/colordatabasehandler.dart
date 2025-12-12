import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teamprogectfinal/model/category_color.dart';

class Colordatabasehandler {
  /*
  int? cc_seq;
  String cc_name;
111

  */

  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path,'user.db'),
      onCreate: (db, version) async{
        await db.execute(
          """
          create table color_category
          (
          cc_seq integer primary key autoincrement,
          cc_name text
          

          
          
          )

          """
        );
      },
      version: 1,
    );
  }

  Future<List<CategoryColor>> queryColor() async{
    final Database db =await initializeDB();
    final List<Map<String,Object?>> result = await db.rawQuery(
      """
        select * 
        from color_category
      """
    );
    return result.map((e) => CategoryColor.fromMap(e)).toList();
  }



}