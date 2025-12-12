import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Buydatabasehandler {

/*11
 int? b_seq;
  int br_seq;
  int u_seq;
  int p_seq;
  String b_date;
  int b_price;
  int b_quantity;

*/
  
   Future<Database> initializeDB() async{
  String path = await getDatabasesPath();
  return openDatabase(
    join(path,'user.db'),
    onCreate: (db, version) async{
      await db.execute(
        """
        create table buy
        (
        b_seq integer primary key autoincrement,
        br_seq integer,
        u_seq integer,
        p_seq integer,
        b_data text,
        b_price integer,
        b_quantity integer
        
        
        )

        """
      );
    },
    version: 1,
  );
}
}