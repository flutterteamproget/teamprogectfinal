class KindCategory {
  int? kc_seq;
  String kc_name;

  KindCategory(
    {
      this.kc_seq,
      required this.kc_name
    }
  );

  KindCategory.fromMap(Map<String, dynamic> res)
  : kc_seq = res['kc_seq'],
    kc_name = res['kc_name'];
}
