class ColorCategory {
  int? cc_seq;
  String cc_name;

  ColorCategory(
    {
      this.cc_seq,
      required this.cc_name
    }
  );

  ColorCategory.fromMap(Map<String, dynamic> res)
  : cc_seq = res['cc_seq'],
    cc_name = res['cc_name'];
}
