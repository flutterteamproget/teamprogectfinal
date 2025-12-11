class GenderCategory {
  int? gc_seq;
  String gc_name;

  GenderCategory(
    {
      this.gc_seq,
      required this.gc_name
    }
  );

  GenderCategory.fromMap(Map<String, dynamic> res)
  : gc_seq = res['gc_seq'],
    gc_name = res['gc_name'];
}
