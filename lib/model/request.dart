class Request {
  int? req_seq;
  String? req_date;
  String req_content;
  int req_quantity;
  String req_manappdate;
  String req_dirappdate;
  String? s_superseq;
  int? s_seq;
  int? q_seq;
  int? m_seq;

  Request(
    {
      this.req_seq,
      this.req_date,
      required this.req_content,
      required this.req_quantity,
      required this.req_manappdate,
      required this.req_dirappdate,
      this.s_superseq,
      this.s_seq,
      this.q_seq,
      this.m_seq,
    }
  );

  Request.fromMap(Map<String, dynamic> res)
  : req_seq = res['req_seq'],
    req_date = res['req_date'],
    req_content = res['req_content'],
    req_quantity = res['req_quantity'],
    req_manappdate = res['req_manappdate'],
    req_dirappdate = res['req_dirappdate'],
    s_superseq = res['s_superseq'],
    s_seq = res['s_seq'],
    q_seq = res['q_seq'],
    m_seq = res['m_seq'];
}