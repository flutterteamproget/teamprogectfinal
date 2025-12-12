class CategoryGender {
  int? gc_seq;
  String gc_name;

  CategoryGender(
    {
      this.gc_seq,
      required this.gc_name
    }
  );

  CategoryGender.fromMap(Map<String, dynamic> res)
  : gc_seq = res['gc_seq'],
    gc_name = res['gc_name'];
}
