import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teamprogectfinal/model/category_size.dart';

class SizeCategoryDatabasehandler {


/*

int? sc_seq;
  String sc_name;1
*/
  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path,'user.db'),
      onCreate: (db, version) async{
        await db.execute(
          """
          create table size_category
          (
          sc_seq integer primary key autoincrement,
          sc_name text
                  
          
          )

          """
        );
      },
      version: 1,
    );
  }

  Future<List<CategorySize>> querySize() async{
    final Database db =await initializeDB();
    final List<Map<String,Object?>> result = await db.rawQuery(
      """
        select * 
        from size_category
      """
    );
    return result.map((e) => CategorySize.fromMap(e)).toList();
  }
//해당 상품에  존재하는 사이즈만
Future<List<CategorySize>> querySizeByProduct(String productName) async {
    final Database db = await initializeDB();

    final List<Map<String, Object?>> result = await db.rawQuery(
      '''
      SELECT DISTINCT
        sc.sc_seq,
        sc.sc_name
      FROM product p
      INNER JOIN size_category sc
        ON p.sc_seq = sc.sc_seq
      WHERE p.p_name = ?
      ORDER BY sc.sc_seq
      ''',
      [productName],
    );

    return result.map((e) => CategorySize.fromMap(e)).toList();
  }

  
}