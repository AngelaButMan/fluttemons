import 'dart:convert';

import 'package:fluttemons/models/pokeapi_models.dart';

import 'network.dart';

const String API_URL = 'https://pokeapi.co/api/v2/';

class PokeAPI {
  Future<Pokemon> getPokemon(int num) async {
    int pokeNum = num;

    Network network = Network('${API_URL}pokemon/$pokeNum');
    var data = await network.getData();

    var pokeMap = json.decode(data);

    return Pokemon.fromJson(pokeMap);

    //return data;
  }
}
