import 'dart:convert';
import 'package:appadsgp1/model/feriado_model.dart';
import 'package:http/http.dart' as http;

class FeriadosRepository {
  final Uri url = Uri.parse('https://brasilapi.com.br/api/feriados/v1/2024');

  Future<List<FeriadoEntity>> getAll() async {
    List<FeriadoEntity> feriadoList = [];
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      for (var feriado in json) {
        feriadoList.add(FeriadoEntity.fromJson(feriado));
      }
    }
    return feriadoList;
  }
}