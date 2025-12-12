class Refund {
  int? ref_seq;
  int? s_seq;
  int? u_seq;
  int? pic_seq;
  String ref_date;
  String ref_reason;

  Refund(
    {
      this.ref_seq,
      this.s_seq,
      this.u_seq,
      this.pic_seq,
      required this.ref_date,
      required this.ref_reason,
    }
  );

    Refund.fromMap(Map<String, dynamic> res)
    : ref_seq = res['ref_seq'],
      s_seq = res['s_seq'],
      u_seq = res['u_seq'],
      pic_seq = res['pic_seq'],
      ref_date = res['ref_date'],
      ref_reason = res['ref_reason'];
}
