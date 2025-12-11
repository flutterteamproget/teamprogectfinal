class Maker {
  int? m_seq;
  String m_phone;
  String m_address;
  String m_name;

  Maker(
    {
      this.m_seq,
      required this.m_phone,
      required this.m_address,
      required this.m_name
    }
  );

  Maker.fromMap(Map<String, dynamic> res)
  : m_seq = res['m_seq'],
    m_phone = res['m_phone'],
    m_address = res['m_address'],
    m_name = res['m_name'];
}
