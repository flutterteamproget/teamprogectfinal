class CategoryColor {
  int? cc_seq;
  String cc_name;

  CategoryColor(
    {
      this.cc_seq,
      required this.cc_name
    }
  );

  CategoryColor.fromMap(Map<String, dynamic> res)
  : cc_seq = res['cc_seq'],
    cc_name = res['cc_name'];
}
