class Branch {
  int? br_seq;
  String br_name;
  double br_lat;
  double br_lng;
  String br_address;
  String br_phone;

  Branch(
    {
      this.br_seq,
      required this.br_name,
      required this.br_lat,
      required this.br_lng,
      required this.br_address,
      required this.br_phone
    }
  );

  Branch.fromMap(Map<String, dynamic> res)
  : br_seq = res['br_seq'],
    br_name = res['br_name'],
    br_lat = res['br_lat'],
    br_lng = res['br_lng'],
    br_address = res['br_address'],
    br_phone = res['br_phone'];
}
