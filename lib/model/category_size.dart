class CategorySize {
  int? sc_seq;
  String sc_name;

  CategorySize(
    {
      this.sc_seq,
      required this.sc_name
    }
  );

  CategorySize.fromMap(Map<String, dynamic> res)
  : sc_seq = res['sc_seq'],
    sc_name = res['sc_name'];
}
