import 'dart:typed_data';

class Product {
  int? p_seq;
  int? cc_seq;
  int? gc_seq;
  int? sc_seq;
  int? kc_seq;
  int? m_seq;
  String p_name;
  int p_price;
  int p_stock;
  Uint8List p_image;

  Product(
    {
      this.p_seq,
      this.cc_seq,
      this.gc_seq,
      this.sc_seq,
      this.kc_seq,
      this.m_seq,
      required this.p_name,
      required this.p_price,
      required this.p_stock,
      required this.p_image
    }
  );

  Product.fromMap(Map<String, dynamic> res)
  : p_seq = res['p_seq'],
    cc_seq = res['cc_seq'],
    gc_seq = res['gc_seq'],
    sc_seq = res['sc_seq'],
    kc_seq = res['kc_seq'],
    m_seq = res['m_seq'],
    p_name = res['p_name'],
    p_price = res['p_price'],
    p_stock = res['p_stock'],
    p_image = res['p_image'];
}
