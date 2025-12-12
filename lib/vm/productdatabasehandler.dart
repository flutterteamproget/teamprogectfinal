import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teamprogectfinal/model/product.dart';

class Productdatabasehandler {

/*
 int? p_seq;
  int cc_seq;
  int gc_seq;
  int sc_seq;
  int kc_seq;
  int m_seq;
  String p_name;
  int p_price;
  int p_stock;
  Uint8List p_image;1


*/


Future<Database> initializeDB() async{
  String path = await getDatabasesPath();
  return openDatabase(
    join(path,'user.db'),
    onCreate: (db, version) async{
      await db.execute(
        """
        create table product
        (
        p_seq integer primary key autoincrement,
        cc_seq integer,
        gc_seq integer,
        sc_seq integer,
        kc_seq integer,
        m_seq integer,
        p_name text,
        p_price interger,
        p_stock interger,
        p_image blob
        
        
        )

        """
      );
    },
    version: 1,
  );
}

Future<List<Product>> queryProduct()async{
    final Database db =await initializeDB();
    final List<Map<String,Object?>> result =await db.rawQuery(
      """
      select *from
      from product
      

      """,
      
    );
    return result.map((e) => Product.fromMap(e)).toList(); //한묶음 하나
   }


Future<int> insertProduct(Product product)  async{  
    int result=0; //판단
    final Database db= await initializeDB();
   result= await db.rawInsert(
      """
      insert into product
      ()
      values
      (?,?,?,?,?)

      """,
      [
       

      ]
    );
    return result;
  }

}