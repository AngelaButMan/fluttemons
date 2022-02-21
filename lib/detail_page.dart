import 'dart:developer';

import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'datastrore/pokemon_firestore.dart';
import 'datastrore/pokemon_local_store.dart';
import 'favorite_page.dart';
import 'pokemon_page.dart';
import 'models/pokeapi_models.dart';

class DetailPage extends StatefulWidget {
  final futurePokemon;
  final pokeId;
  const DetailPage({Key? key, required this.futurePokemon, this.pokeId})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final PokemonPage pokemonsPage = PokemonPage();
  final FavoritePage favoritePage = FavoritePage();
  @override
  Widget build(BuildContext context) {
    bool _isFavorite = favMarks.contains(widget.pokeId.toString());
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan,
        title: Text("Pokemon detail"),
        centerTitle: true,
      ),
      body: FutureBuilder<Pokemon>(
          future: widget.futurePokemon,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: <Widget>[
                  Positioned(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width - 20,
                    left: 10.0,
                    top: MediaQuery.of(context).size.height * 0.2,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Stack(
                        children: [
                          new Align(
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                                'assets/images/pokeball_logo3.png',
                                height: 360,
                                width: 190),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      _isFavorite
                                          ? favMarks
                                              .remove(widget.pokeId.toString())
                                          : favMarks
                                              .add(widget.pokeId.toString());
                                    });
                                    setFavoritePokemonsList();
                                    await PokemonLocalStore.setLocalFavMarks(
                                        favMarks);
                                    PokemonFireStore.updateUserData(userData);
                                    pokemonsPage.stateFavoriteMark();
                                    favoritePage.stateFavoriteMark();
                                    //inspect(favoriteList);
                                  },
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      _isFavorite
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.yellow,
                                      size: 36,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                new Align(
                                  alignment: Alignment.topCenter,
                                  child: BorderedText(
                                    strokeWidth: 3,
                                    strokeColor: Colors.black,
                                    child: Text(
                                      snapshot.data!.name
                                          .toString()
                                          .toCamelCase(),
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50.0,
                                ),
                                Text("Height: ${snapshot.data!.height}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start),
                                Text("Weight: ${snapshot.data!.weight}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  "Types:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  alignment: WrapAlignment.start,
                                  spacing: 5,
                                  children: snapshot.data!.types!
                                      .map((t) => FilterChip(
                                          backgroundColor: Colors.deepPurple,
                                          shape:
                                              StadiumBorder(side: BorderSide()),
                                          label: Text(
                                            t.type!.name.toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onSelected: (b) {
                                            setState(() {});
                                          }))
                                      .toList(),
                                ),
                                Text("Abilities:",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Wrap(
                                  alignment: WrapAlignment.start,
                                  spacing: 5,
                                  children: snapshot.data!.abilities!
                                      .map((t) => FilterChip(
                                          backgroundColor: Colors.red,
                                          shape:
                                              StadiumBorder(side: BorderSide()),
                                          label: Text(
                                            t.ability!.name.toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onSelected: (b) {
                                            //inspect(widget.pokemon.types);
                                          }))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new Align(
                      alignment: Alignment.topCenter,
                      child: Hero(
                        tag: widget.pokeId.toString(),
                        child: CachedNetworkImage(
                            key: UniqueKey(),
                            height: 250.0,
                            width: 250.0,
                            fit: BoxFit.cover,
                            imageUrl: snapshot.data!.sprites!.front_default
                                .toString(),
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Center(
                                child: Icon(Icons.error, color: Colors.red))),
                      )),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}

extension StringExtension on String {
  String toCamelCase() =>
      "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
}
