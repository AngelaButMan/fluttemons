import 'dart:convert';
import 'dart:developer';

import 'package:fluttemons/models/pokeapi_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonLocalStore {
  static late SharedPreferences _prefs;

  static const _keyPokemon = 'pokemon';
  static const _keyMarks = 'favMarks';

  static init() async => _prefs = await SharedPreferences.getInstance();

  static clear() => _prefs.clear();

  static setLocalPokemon(List<Future<Pokemon>> futurePokemons) async {
    List pokemons = [];
    for (var item in futurePokemons) {
      var pokemon = await item;
      pokemons.add(pokemon);
    }
    String json = jsonEncode(pokemons);
    await _prefs.setString(_keyPokemon, json);
    print('store pokemons');
  }

  static List<Pokemon> getLocalPokemon() {
    List<Pokemon> pokemons = [];
    if (_prefs.getString(_keyPokemon) != null) {
      var pokeMap = jsonDecode(_prefs.getString(_keyPokemon)!) as List;
      pokemons = pokeMap.map((e) => Pokemon.fromJson(e)).toList();
    }
    print('get pokemons from storage');
    inspect(pokemons);
    return pokemons;
  }

  static setLocalFavMarks(List<String> index) async =>
      await _prefs.setStringList(_keyMarks, index);

  static getLocalFavMArks() => _prefs.getStringList(_keyMarks);
}
