import 'dart:typed_data';

class Staff {
  int? s_seq;
  int? br_seq;
  String s_rank;
  String s_phone;
  Uint8List s_image;
  int s_superseq;
  String s_password;

  Staff(
    {
      this.s_seq,
      this.br_seq,
      required this.s_rank,
      required this.s_phone,
      required this.s_image,
      required this.s_superseq,
      required this.s_password
    }
  );

  Staff.fromMap(Map<String, dynamic> res)
  : s_seq = res['s_seq'],
    br_seq = res['br_seq'],
    s_rank = res['s_rank'],
    s_phone = res['s_phone'],
    s_image = res['s_image'],
    s_superseq = res['s_superseq'],
    s_password = res['s_password'];
}
