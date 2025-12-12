import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teamprogectfinal/model/category_kind.dart';

class KindCategoryDatabasehandler {
/*

int? kc_seq;
String kc_name;


*/

  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path,'user.db'),
      onCreate: (db, version) async{
        await db.execute(
          """
          create table kind_category
          (
          kc_seq integer primary key autoincrement,
          kc_name text
                  
          
          )

          """
        );
      },
      version: 1,
    );
  }

  Future<List<CategoryKind>> queryKind() async{
    final Database db =await initializeDB();
    final List<Map<String,Object?>> result = await db.rawQuery(
      """
        select * 
        from kind_category
      """
    );
    return result.map((e) => CategoryKind.fromMap(e)).toList();
  }

}