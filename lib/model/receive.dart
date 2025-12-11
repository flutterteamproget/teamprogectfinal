class Receive {
  int? rec_seq;
  int rec_quantity;
  String? rec_date;
  int? s_seq;
  int? p_seq;
  int? m_seq;

  Receive(
    {
      this.rec_seq,
      required this.rec_quantity,
      this.rec_date,
      this.m_seq,
      this.p_seq,
      this.s_seq
    }
  );

  Receive.fromMap(Map<String, dynamic> res)
  : rec_seq = res['rec_seq'],
    rec_quantity = res['rec_quantity'],
    rec_date = res['rec_date'],
    m_seq = res['m_seq'],
    p_seq = res['p_seq'],
    s_seq = res['s_seq'];
}