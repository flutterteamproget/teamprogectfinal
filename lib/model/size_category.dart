class SizeCategory {
  int? sc_seq;
  String sc_name;

  SizeCategory(
    {
      this.sc_seq,
      required this.sc_name
    }
  );

  SizeCategory.fromMap(Map<String, dynamic> res)
  : sc_seq = res['sc_seq'],
    sc_name = res['sc_name'];
}
