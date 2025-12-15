import 'dart:typed_data';

import 'package:flutter/material.dart';
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


// 구매내역 
Future<List> queryBuy2(int u_seq) async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery(
      """
      select * from product as p
      inner join buy as b
      on p.p_seq = b.p_seq
      inner join user as u
      on b.u_seq = u.u_seq
      where u.u_seq = ?
      """,
      [u_seq]
    ); 
    print(queryResults);
    // queryResults = [{b_date : 2025-12-11}], [], ...
    return queryResults;
  }







// 수령 지점
Future<Map?> queryBranchAddress(int b_seq) async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery(
      """
      select br_address, br_name
      from branch as br
      inner join buy as b
      on b.br_seq = br.br_seq
      where b_seq = ?
      """,
      [b_seq]
    ); 
    // queryResults = [{b_date : 2025-12-11}], [], ...
    if(queryResults.isNotEmpty){
      return queryResults[0];
    }else{
      return null;
    }
  }





// 상품 금액
Future<String?> queryProductPrice(int u_seq, int b_seq) async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery(
      """
      select p_price * b_quantity
      from product as p
      inner join buy as b
      on b.p_seq = p.p_seq
      where b_seq = ?
      """,
      [u_seq, b_seq]
    ); 
    // queryResults = [{b_date : 2025-12-11}], [], ...
    if(queryResults.isNotEmpty){
      return queryResults[0]['p_price * b_quantity'].toString();
    }else{
      return null;
    }
  }

// 지점별 구매액
Future<Map?> queryBranchPrice() async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery(
      """
      select br_name, sum(b_price) from branch as br
      inner join buy as b
      on br.br_seq = b.br_seq
	    inner join user as u
	    on b.u_seq = u.u_seq
      group by b.br_seq
      order by sum(b_price) desc
      """,
    ); 
    // queryResults = [{b_date : 2025-12-11}], [], ...
    if(queryResults.isNotEmpty){
      return queryResults[0];
    }else{
      return null;
    }
  }

  // 가장 많이 방문한 지점, 방문 횟수
  Future<Map?> queryBranchVisit() async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery(
      """
      select br_name, count(b.br_seq) from branch as br
      inner join buy as b
      on b.br_seq = br.br_seq
      group by b.br_seq
      order by count(b.br_seq) desc
      """,
    ); 
    // queryResults = [{b_date : 2025-12-11}], [], ...
    if(queryResults.isNotEmpty){
      return queryResults[0];
    }else{
      return null;
    }
  }

  // 자주 이용한 브랜드
  Future<List<Map<String, Object?>>?> queryFavoriteMaker() async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery(
      """
      select m_name, count(m.m_seq) from maker as m
      inner join product as p
      on m.m_seq = p.m_seq
      inner join buy as b
      on b.p_seq = p.p_seq
      group by m.m_seq
      order by count(m.m_seq) DESC
      """,
    ); 
    // queryResults = [{b_date : 2025-12-11}], [], ...
    if(queryResults.isNotEmpty){
      return queryResults;
    }else{
      return null;
    }
  }


}