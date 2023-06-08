import 'dart:convert';

CekMhs cekMhsFromJson(String str) => CekMhs.fromJson(json.decode(str));

class CekMhs {
  final String nama;
  final String nim;
  final String gambar;
  final String keteranganDatang;
  final String keteranganPulang;

  CekMhs({
    required this.nama,
    required this.nim,
    required this.gambar,
    required this.keteranganDatang,
    required this.keteranganPulang,
  });

  factory CekMhs.fromJson(Map<String, dynamic> json) => CekMhs(
        nama: json["nama"],
        nim: json["nim"],
        gambar: json["gambar"],
        keteranganDatang: json["keteranganDatang"],
        keteranganPulang: json["keteranganPulang"],
      );
}
