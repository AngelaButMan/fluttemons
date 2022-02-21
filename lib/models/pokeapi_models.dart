import 'package:json_annotation/json_annotation.dart';
part 'pokeapi_models.g.dart';

@JsonSerializable()
class Pokemon {
  int? id;
  String? name;
  int? height;
  int? weight;
  int? base_experience;
  List<PokemonAbility>? abilities;
  List<PokemonType>? types;
  PokemonSprites? sprites;

  Pokemon(
      {this.id,
      this.abilities,
      this.base_experience,
      this.height,
      this.name,
      this.sprites,
      this.types,
      this.weight});

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}

@JsonSerializable()
class PokemonSprites {
  String? back_female;
  String? back_shiny_female;
  String? back_default;
  String? front_female;
  String? front_shiny_female;
  String? back_shiny;
  String? front_default;
  String? front_shiny;

  PokemonSprites(
      {this.back_female,
      this.back_shiny_female,
      this.back_default,
      this.front_female,
      this.front_shiny_female,
      this.back_shiny,
      this.front_default,
      this.front_shiny});

  factory PokemonSprites.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpritesFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonSpritesToJson(this);
}

@JsonSerializable()
class PokemonAbility {
  bool? is_hidden;
  int? slot;
  NamedRes? ability;

  PokemonAbility({this.is_hidden, this.slot, this.ability});

  factory PokemonAbility.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilityFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonAbilityToJson(this);
}

@JsonSerializable()
class PokemonType {
  int? slot;
  NamedRes? type;

  PokemonType({this.slot, this.type});

  factory PokemonType.fromJson(Map<String, dynamic> json) =>
      _$PokemonTypeFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonTypeToJson(this);
}

@JsonSerializable()
class NamedRes {
  String? name;
  String? url;

  NamedRes({this.name, this.url});

  factory NamedRes.fromJson(Map<String, dynamic> json) =>
      _$NamedResFromJson(json);
  Map<String, dynamic> toJson() => _$NamedResToJson(this);
}

@JsonSerializable()
class ResourceList {
  int? count;
  String? next;
  String? previous;
  List<NamedRes>? results;

  ResourceList({this.count, this.next, this.previous, this.results});

  factory ResourceList.fromJson(Map<String, dynamic> json) =>
      _$ResourceListFromJson(json);
  Map<String, dynamic> toJson() => _$ResourceListToJson(this);
}
