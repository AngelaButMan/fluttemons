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
    base_experience: json['base_experience'] as int?,
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
      'base_experience': instance.base_experience,
      'abilities': instance.abilities,
      'types': instance.types,
      'sprites': instance.sprites,
    };

PokemonSprites _$PokemonSpritesFromJson(Map<String, dynamic> json) {
  return PokemonSprites(
    back_female: json['back_female'] as String?,
    back_shiny_female: json['back_shiny_female'] as String?,
    back_default: json['back_default'] as String?,
    front_female: json['front_female'] as String?,
    front_shiny_female: json['front_shiny_female'] as String?,
    back_shiny: json['back_shiny'] as String?,
    front_default: json['front_default'] as String?,
    front_shiny: json['front_shiny'] as String?,
  );
}

Map<String, dynamic> _$PokemonSpritesToJson(PokemonSprites instance) =>
    <String, dynamic>{
      'back_female': instance.back_female,
      'back_shiny_female': instance.back_shiny_female,
      'back_default': instance.back_default,
      'front_female': instance.front_female,
      'front_shiny_female': instance.front_shiny_female,
      'back_shiny': instance.back_shiny,
      'front_default': instance.front_default,
      'front_shiny': instance.front_shiny,
    };

PokemonAbility _$PokemonAbilityFromJson(Map<String, dynamic> json) {
  return PokemonAbility(
    is_hidden: json['is_hidden'] as bool?,
    slot: json['slot'] as int?,
    ability: json['ability'] == null
        ? null
        : NamedRes.fromJson(json['ability'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PokemonAbilityToJson(PokemonAbility instance) =>
    <String, dynamic>{
      'is_hidden': instance.is_hidden,
      'slot': instance.slot,
      'ability': instance.ability,
    };

PokemonType _$PokemonTypeFromJson(Map<String, dynamic> json) {
  return PokemonType(
    slot: json['slot'] as int?,
    type: json['type'] == null
        ? null
        : NamedRes.fromJson(json['type'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PokemonTypeToJson(PokemonType instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'type': instance.type,
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
