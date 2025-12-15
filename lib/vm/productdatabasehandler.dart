import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teamprogectfinal/model/category_size.dart';
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

  Future<List<Product>> queryProduct(String order)async{

    //정렬
    String str = "";
    if(order == "이름순"){
      str = "product.p_name asc";
    }else if(order == "가격 높은순"){
      str = "product.p_price desc";
    }else if(order == "가격 낮은순"){
      str = "product.p_price asc";
    }else if(order == "브랜드순"){
      str = "maker.m_name asc";
    }else{ // 구매순
      str = "buy_count DESC";
    }
    
    final Database db =await initializeDB();
    final List<Map<String,Object?>> result =await db.rawQuery(
      """
      select     
        product.*,
        maker.*,
        color_category.*,
        gender_category.*,
        kind_category.*,
        size_category.*,
        SUM(buy.b_quantity) AS buy_count

      from product 

      inner join maker
      on product.m_seq = maker.m_seq
      inner join color_category
      on product.cc_seq = color_category.cc_seq
      inner join gender_category
      on product.gc_seq = gender_category.gc_seq
      inner join kind_category
      on product.kc_seq = kind_category.kc_seq
      inner join size_category
      on product.sc_seq = size_category.sc_seq
      LEFT JOIN buy
      ON product.p_seq = buy.p_seq

      GROUP BY product.p_seq

      order by $str

      """,
      
    );
    return result.map((e) => Product.fromMap(e)).toList(); //한묶음 하나
  }

  //카테고리 컬럼명과 시퀀스로 제품목록 검색
  Future<List<Product>> queryProductCategory(String whatseq, int num, String order)async{

    //정렬
    String str = "";
    if(order == "이름순"){
      str = "product.p_name asc";
    }else if(order == "가격 높은순"){
      str = "product.p_price desc";
    }else if(order == "가격 낮은순"){
      str = "product.p_price asc";
    }else if(order == "브랜드순"){
      str = "maker.m_name asc";
    }else{ // 구매순
      str = "buy_count DESC";
    }
    final Database db =await initializeDB();
    final List<Map<String,Object?>> result =await db.rawQuery(
      """
      select     
        product.*,
        maker.*,
        color_category.*,
        gender_category.*,
        kind_category.*,
        size_category.*,
        SUM(buy.b_quantity) AS buy_count

      from product

      inner join maker
      on product.m_seq = maker.m_seq
      inner join color_category
      on product.cc_seq = color_category.cc_seq
      inner join gender_category
      on product.gc_seq = gender_category.gc_seq
      inner join kind_category
      on product.kc_seq = kind_category.kc_seq
      inner join size_category
      on product.sc_seq = size_category.sc_seq
      LEFT JOIN buy
      ON product.p_seq = buy.p_seq

      where product.$whatseq = ?

      GROUP BY product.p_seq

      order by $str

      """,
      [num]
      
    );
    return result.map((e) => Product.fromMap(e)).toList(); //한묶음 하나
  }

  //카테고리 컬럼명과 시퀀스로 제품목록 검색
  Future<List<Product>> queryProductCategoryTwo(String whatseq1, int num1, String whatSeq2, int num2, String order)async{

    //정렬
    String str = "";
    if(order == "이름순"){
      str = "product.p_name asc";
    }else if(order == "가격 높은순"){
      str = "product.p_price desc";
    }else if(order == "가격 낮은순"){
      str = "product.p_price asc";
    }else if(order == "브랜드순"){
      str = "maker.m_name asc";
    }else{ // 구매순
      str = "buy_count DESC";
    }
    final Database db =await initializeDB();
    final List<Map<String,Object?>> result =await db.rawQuery(
      """
      select     
        product.*,
        maker.*,
        color_category.*,
        gender_category.*,
        kind_category.*,
        size_category.*,
        SUM(buy.b_quantity) AS buy_count

      from product

      inner join maker
      on product.m_seq = maker.m_seq
      inner join color_category
      on product.cc_seq = color_category.cc_seq
      inner join gender_category
      on product.gc_seq = gender_category.gc_seq
      inner join kind_category
      on product.kc_seq = kind_category.kc_seq
      inner join size_category
      on product.sc_seq = size_category.sc_seq
      LEFT JOIN buy
      ON product.p_seq = buy.p_seq

      where product.$whatseq1 = ? and product.$whatSeq2 = ?

      GROUP BY product.p_seq

      order by $str

      """,
      [num1, num2]
      
    );
    return result.map((e) => Product.fromMap(e)).toList(); //한묶음 하나
  }

  //브랜드와 신발명 검색 기능
  Future<List<Product>> queryProductSearch(String string, String order)async{

    //정렬
    String str = "";
    if(order == "이름순"){
      str = "product.p_name asc";
    }else if(order == "가격 높은순"){
      str = "product.p_price desc";
    }else if(order == "가격 낮은순"){
      str = "product.p_price asc";
    }else if(order == "브랜드순"){
      str = "maker.m_name asc";
    }else{ // 구매순
      str = "buy_count DESC";
    }

    final Database db =await initializeDB();
    final List<Map<String,Object?>> result =await db.rawQuery(
      """
      select     
        product.*,
        maker.*,
        color_category.*,
        gender_category.*,
        kind_category.*,
        size_category.*,
        SUM(buy.b_quantity) AS buy_count

      from product

      inner join maker
      on product.m_seq = maker.m_seq
      inner join color_category
      on product.cc_seq = color_category.cc_seq
      inner join gender_category
      on product.gc_seq = gender_category.gc_seq
      inner join kind_category
      on product.kc_seq = kind_category.kc_seq
      inner join size_category
      on product.sc_seq = size_category.sc_seq
      LEFT JOIN buy
      ON product.p_seq = buy.p_seq

      where product.p_name like ? or maker.m_name like ?

      GROUP BY product.p_seq

      order by $str

      """,
      ["%$string%", "%$string%"]
      
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






//제조사별로 신발 분류

Future<List<Product>> queryProductByMaker() async {
  final Database db = await initializeDB();
  final result = await db.rawQuery(
    '''
    SELECT *
    FROM product p
    INNER JOIN maker m
    ON p.m_seq = m.m_seq
    GROUP BY m.m_name


    '''
  );

  return result.map((e) => Product.fromMap(e)).toList();
}


}