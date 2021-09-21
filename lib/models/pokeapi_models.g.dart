// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeapi_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokemon _$PokemonFromJson(Map<String, dynamic> json) {
  return Pokemon(
    id: json['id'] as int?,
    abilities: (json['abilities'] as List<dynamic>?)
        ?.map((e) => PokemonAbility.fromJson(e as Map<String, dynamic>))
        .toList(),
    baseExperience: json['base_experience'] as int?,
    height: json['height'] as int?,
    name: json['name'] as String?,
    sprites: json['sprites'] == null
        ? null
        : PokemonSprites.fromJson(json['sprites'] as Map<String, dynamic>),
    types: (json['types'] as List<dynamic>?)
        ?.map((e) => PokemonType.fromJson(e as Map<String, dynamic>))
        .toList(),
    weight: json['weight'] as int?,
  );
}

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'height': instance.height,
      'weight': instance.weight,
      'base_experience': instance.baseExperience,
      'abilities': instance.abilities,
      'types': instance.types,
      'sprites': instance.sprites,
    };

PokemonSprites _$PokemonSpritesFromJson(Map<String, dynamic> json) {
  return PokemonSprites(
    backFemale: json['back_female'] as String?,
    backShinyFemale: json['back_shiny_female'] as String?,
    backDefault: json['back_default'] as String?,
    frontFemale: json['front_female'] as String?,
    frontShinyFemale: json['front_shiny_female'] as String?,
    backShiny: json['back_shiny'] as String?,
    frontDefault: json['front_default'] as String?,
    frontShiny: json['front_shiny'] as String?,
  );
}

Map<String, dynamic> _$PokemonSpritesToJson(PokemonSprites instance) =>
    <String, dynamic>{
      'back_female': instance.backFemale,
      'back_shiny_female': instance.backShinyFemale,
      'back_default': instance.backDefault,
      'front_female': instance.frontFemale,
      'front_shiny_female': instance.frontShinyFemale,
      'back_shiny': instance.backShiny,
      'front_default': instance.frontDefault,
      'front_shiny': instance.frontShiny,
    };

PokemonAbility _$PokemonAbilityFromJson(Map<String, dynamic> json) {
  return PokemonAbility(
    isHidden: json['isHidden'] as bool?,
    slot: json['slot'] as int?,
    ability: json['ability'] == null
        ? null
        : NamedRes.fromJson(json['ability'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PokemonAbilityToJson(PokemonAbility instance) =>
    <String, dynamic>{
      'isHidden': instance.isHidden,
      'slot': instance.slot,
      'ability': instance.ability,
    };

PokemonType _$PokemonTypeFromJson(Map<String, dynamic> json) {
  return PokemonType(
    slot: json['slot'] as int?,
    ability: json['ability'] == null
        ? null
        : NamedRes.fromJson(json['ability'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PokemonTypeToJson(PokemonType instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'ability': instance.ability,
    };

NamedRes _$NamedResFromJson(Map<String, dynamic> json) {
  return NamedRes(
    name: json['name'] as String?,
    url: json['url'] as String?,
  );
}

Map<String, dynamic> _$NamedResToJson(NamedRes instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

ResourceList _$ResourceListFromJson(Map<String, dynamic> json) {
  return ResourceList(
    count: json['count'] as int?,
    next: json['next'] as String?,
    previous: json['previous'] as String?,
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => NamedRes.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ResourceListToJson(ResourceList instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
