import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teamprogectfinal/model/buy.dart';


class Buydatabasehandler {
  

/*
  int? b_seq; 구매 번호
  int br_seq; 지점 번호
  int u_seq; 고객 번호
  int p_seq; 상품 번호
  String b_date; 구매 날짜
  int b_price; 구매 금액
  int b_quantity; 구매 수량

*/

Future<Database> initializeDB() async{
  String path = await getDatabasesPath();
  print("실제 DB 저장 위치: $path");
  return openDatabase(
    join(path, 'user.db'),
    onCreate: (db, version) async{
      await db.execute(
        """
        create table buy
        (
        b_seq integer primary key autoincrement,
        br_seq integer,
        u_seq integer,
        p_seq integer,
        b_date text,
        b_price int,
        b_quantity int
        )
        """
      );
    },
    version: 1,
  );
}
// 검색
  Future<List<Buy>> queryBuy() async{
    final Database db = await initializeDB();
    final List<Map<String,Object?>> queryResults = await db.rawQuery(
      """
      select * from buy
      """
    );
    return queryResults.map((e) => Buy.fromMap(e)).toList();
   }

// 입력
Future<int> insertBuy(Buy buy) async{
  int result = 0;
  final Database db = await initializeDB();
  result = await db.rawInsert(
    """
    insert into buy
    (br_seq, u_seq, p_seq, b_date, b_price, b_quantity)
    values
    (?,?,?,?,?,?)
    """,

    [
      buy.br_seq,
      buy.u_seq,
      buy.p_seq,
      buy.b_date,
      buy.b_price,
      buy.b_quantity
    ]
  );
  return result;
}


// 구매 날짜
// select b_date from buy
// where b_seq
Future<String?> queryBuyDate(int b_seq) async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery(
      """
      select b_date from buy
      where b_seq = ?
      """,
      [b_seq]
    ); 
    // queryResults = [{b_date : 2025-12-11}], [], ...
    if(queryResults.isNotEmpty){
      return queryResults[0]['b_date'].toString();
    }else{
      return null;
    }
  }

// 수령 지점
// select br_address
// from branch as br
// inner join buy as b
// on b.br_seq = br.br_seq
Future<String?> queryBranchAddress(int b_seq) async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery(
      """
      select br_address
      from branch as br
      inner join buy as b
      on b.br_seq = br.br_seq
      where b_seq = ?
      """,
      [b_seq]
    ); 
    // queryResults = [{b_date : 2025-12-11}], [], ...
    if(queryResults.isNotEmpty){
      return queryResults[0]['br_address'].toString();
    }else{
      return null;
    }
  }

// 구매 수량
// select b_quantity
// from buy
// where b_seq = ?
Future<String?> queryBuyQuantity(int b_seq) async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery(
      """
      select b_quantity from buy
      where b_seq = ?
      """,
      [b_seq]
    ); 
    // queryResults = [{b_date : 2025-12-11}], [], ...
    if(queryResults.isNotEmpty){
      return queryResults[0]['b_quantity'].toString();
    }else{
      return null;
    }
  }

// 구매 상품 보여주기
// select * from buy
// where b_seq = ?
Future<List<Buy>> queryBuyProduct(int b_seq) async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery(
      """
      select * from buy
      where b_seq = ?
      """,
      [b_seq]
    ); 
    // queryResults = [{b_date : 2025-12-11}], [], ...
      return queryResults.map((e) => Buy.fromMap(e)).toList();
    }

// 상품 금액
// select sum(p_price)
// from product as p
// inner join buy as b
// on b.p_seq = p.p_seq
// where b_seq = ?
Future<String?> queryProductPrice(int b_seq) async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery(
      """
      select sum(p_price)
      from product as p
      inner join buy as b
      on b.p_seq = p.p_seq
      where b_seq = ?
      """,
      [b_seq]
    ); 
    // queryResults = [{b_date : 2025-12-11}], [], ...
    if(queryResults.isNotEmpty){
      return queryResults[0]['sum(p_price)'].toString();
    }else{
      return null;
    }
  }


// 결제 금액
// select b_price from buy
// where b_seq = ?
Future<String?> queryBuyPrice(int b_seq) async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery(
      """
      select b_price from buy
      where b_seq = ?
      """,
      [b_seq]
    ); 
    // queryResults = [{b_date : 2025-12-11}], [], ...
    if(queryResults.isNotEmpty){
      return queryResults[0]['b_price'].toString();
    }else{
      return null;
    }
  }
}