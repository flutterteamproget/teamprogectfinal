class Buy {
  int? b_seq;
  int br_seq;
  int u_seq;
  int p_seq;
  String b_date;
  String b_price;

  Buy(
    {
      this.b_seq,
      required this.br_seq,
      required this.u_seq,
      required this.p_seq,
      required this.b_date,
      required this.b_price
    }
  );

  Buy.fromMap(Map<String, dynamic> res)
  : b_seq = res['b_seq'],
    br_seq = res['br_seq'],
    u_seq = res['u_seq'],
    p_seq = res['p_seq'],
    b_date = res['b_date'],
    b_price = res['b_price'];
}
