import 'dart:typed_data';

class Product {
  int? p_seq;
  int? cc_seq;
  String? cc_name;
  int? gc_seq;
  String? gc_name;
  int? sc_seq;
  String? sc_name;
  int? kc_seq;
  String? kc_name;
  int? m_seq;
  String? m_name;
  String p_name;
  int p_price;
  int p_stock;
  Uint8List p_image;

  Product(
    {
      this.p_seq,
      this.cc_seq,
      this.cc_name,
      this.gc_seq,
      this.gc_name,
      this.sc_seq,
      this.sc_name,
      this.kc_seq,
      this.kc_name,
      this.m_seq,
      this.m_name,
      required this.p_name,
      required this.p_price,
      required this.p_stock,
      required this.p_image
    }
  );

  Product.fromMap(Map<String, dynamic> res)
  : p_seq = res['p_seq'],
    cc_seq = res['cc_seq'],
    cc_name = res['cc_name'],
    gc_seq = res['gc_seq'],
    gc_name = res['gc_name'],
    sc_seq = res['sc_seq'],
    sc_name = res['sc_name'],
    kc_seq = res['kc_seq'],
    kc_name = res['kc_name'],
    m_seq = res['m_seq'],
    m_name = res['m_name'],
    p_name = res['p_name'],
    p_price = res['p_price'],
    p_stock = res['p_stock'],
    p_image = res['p_image'];
}
