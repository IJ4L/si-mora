import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simor/models/cek_mahasiswa.dart';

import '../config/core.dart';

class PembimbingRepository {
  final http.Client client;
  final SharedPreferences sharedPreferences;
  final String _userTokenKey = 'user_token';
  PembimbingRepository({required this.sharedPreferences, required this.client});

  Future<Either<String, List<CekMhs>>> getMhs() async {
    try {
      final token = await getUserToken();

      final response = await client.get(
        Uri.parse('$baseUrl/pembimbing-lapangan/onboarding'),
        headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> mhs = data['data']['mahasiswa'];
        List<CekMhs> cleanDataList = [];

        for (var i = 0; i < mhs.length; i++) {
          if (mhs[i]['datang'].length != 0) {
            String keteranganDatang = '';
            if (mhs[i]['datang'][0]['keterangan'] == 'hadir') {
              keteranganDatang = 'hadir';
            }

            String keteranganPulang = '';
            if (mhs[i]['pulang'].length != 0 &&
                mhs[i]['pulang'][0]['keterangan'] == 'hadir') {
              keteranganPulang = 'hadir';
            }

            CekMhs cleanData = CekMhs(
              nim: mhs[i]['nim'],
              gambar: mhs[i]['gambar'],
              nama: mhs[i]['nama'],
              keteranganDatang: keteranganDatang,
              keteranganPulang: keteranganPulang,
            );
            cleanDataList.add(cleanData);
          } else {
            CekMhs cleanData = CekMhs(
              nim: mhs[i]['nim'],
              gambar: mhs[i]['gambar'],
              nama: mhs[i]['nama'],
              keteranganDatang: '',
              keteranganPulang: '',
            );
            cleanDataList.add(cleanData);
          }
        }

        return Right(cleanDataList);
      }
      return Left(
        'Gagal mengambil data mahasiswa. Status code: ${response.statusCode}',
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> konfirmasiDatang(String nim) async {
    try {
      final token = await getUserToken();

      final response = await client.post(
        Uri.parse('$baseUrl/pembimbing-lapangan/konfirmasi_presensi_datang'),
        headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: {'nim': nim},
      );

      if (response.statusCode == 200) {
        return const Right(null);
      }

      return Left(
        'Gagal Konfimasi absensi mahasiswa. Status code: ${response.statusCode}',
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> konfirmasiPulang(String nim) async {
    try {
      final token = await getUserToken();

      final response = await client.post(
        Uri.parse('$baseUrl/pembimbing-lapangan/konfirmasi_presensi_pulang'),
        headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: {'nim': nim},
      );

      if (response.statusCode == 200) {
        return const Right(null);
      }

      return Left(
        'Gagal Konfimasi absensi mahasiswa. Status code: ${response.statusCode}',
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CekMhs>> cekMahasiswa(String nim) async {
    try {
      final token = await getUserToken();

      final response = await client.get(
        Uri.parse(
          '$baseUrl/pembimbing-lapangan/check_presensi_datang?nim=$nim',
        ),
        headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        CekMhs cleanData = CekMhs(
          nim: data['data']['nim'],
          gambar: data['data']['gambar'],
          nama: data['data']['nama'],
          keteranganDatang: '',
          keteranganPulang: '',
        );
        return Right(cleanData);
      }

      return const Left('Kamu tidak terdaftar pada pembimbing ini');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(_userTokenKey) ?? '';
  }
}
