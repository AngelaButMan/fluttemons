import 'package:json_annotation/json_annotation.dart';
part 'pokeapi_models.g.dart';

@JsonSerializable()
class Pokemon {
  int? id;
  String? name;
  int? height;
  int? weight;
  int? baseExperience;
  List<PokemonAbility>? abilities;
  List<PokemonType>? types;
  PokemonSprites? sprites;

  Pokemon(
      {this.id,
      this.abilities,
      this.baseExperience,
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
  String? backFemale;
  String? backShinyFemale;
  String? backDefault;
  String? frontFemale;
  String? frontShinyFemale;
  String? backShiny;
  String? frontDefault;
  String? frontShiny;

  PokemonSprites(
      {this.backFemale,
      this.backShinyFemale,
      this.backDefault,
      this.frontFemale,
      this.frontShinyFemale,
      this.backShiny,
      this.frontDefault,
      this.frontShiny});

  factory PokemonSprites.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpritesFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonSpritesToJson(this);
}

@JsonSerializable()
class PokemonAbility {
  bool? isHidden;
  int? slot;
  NamedRes? ability;

  PokemonAbility({this.isHidden, this.slot, this.ability});

  factory PokemonAbility.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilityFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonAbilityToJson(this);
}

@JsonSerializable()
class PokemonType {
  int? slot;
  NamedRes? ability;

  PokemonType({this.slot, this.ability});

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
