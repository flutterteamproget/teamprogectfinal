import 'dart:typed_data';

class User {
  int? u_seq;
  String u_id;
  String? u_name;
  String u_password;
  String? u_phone;
  Uint8List? u_image;

  User(
    {
    this.u_seq,
    required this.u_id,
    this.u_name,
    required this.u_password,
    this.u_phone,
    this.u_image
  
  
  
    } 


  
  );
User.fromMap(Map<String,dynamic>res)
  :u_seq =res['u_seq'],
  u_id=res['u_id'],
  u_name=res['u_name'],
  u_password =res['u_password'],
  u_phone =res['u_phone'],
  u_image =res['u_image'];




}
