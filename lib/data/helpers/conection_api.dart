import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/dados_nasa.dart';
import 'package:http/http.dart' as http;

class API extends ChangeNotifier {

  Future<DadosNasa> resgataDados(String data) async {
    final response = await http.get('https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=$data');

    if (response.statusCode == 200) {
      return DadosNasa.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao carregar dados da Nasa');
    }
  }

}

