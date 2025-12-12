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
        p_price integer,
        p_stock integer,
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
      select *
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
      (p_name,p_price,p_stock,p_image,sc_seq,gc_seq,cc_seq,m_seq,kc_seq)
      values
      (?,?,?,?,?,?,?,?,?)

      """,
      [
        product.p_name,
        product.p_price,
        product.p_stock,
        product.p_image,
        product.sc_seq,
        product.gc_seq,
        product.cc_seq,
        product.m_seq,
        product.kc_seq
      ]
    );
    return result;
  }

}