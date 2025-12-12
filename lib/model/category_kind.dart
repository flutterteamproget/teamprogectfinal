class CategoryKind {
  int? kc_seq;
  String kc_name;

  CategoryKind(
    {
      this.kc_seq,
      required this.kc_name
    }
  );

  CategoryKind.fromMap(Map<String, dynamic> res)
  : kc_seq = res['kc_seq'],
    kc_name = res['kc_name'];
}
