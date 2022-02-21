import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttemons/detail_page.dart';
import 'package:flutter/material.dart';

import '../models/pokeapi_models.dart';

Widget pokeCard(int index, List pokemons) {
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 6,
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/card_bg.png'),
        ),
      ),
      alignment: Alignment.center,
      child: FutureBuilder<Pokemon>(
        future: pokemons[index],
        builder: (context, snapshot) {
          //print(snapshot.connectionState);
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            var pokeId = snapshot.data!.id;
            return GestureDetector(
              onTap: () {
                //inspect(snapshot.data);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                            futurePokemon: pokemons[index], pokeId: pokeId)));
              },
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: BorderedText(
                        strokeWidth: 3,
                        strokeColor: Colors.black,
                        child: Text(pokeId.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                    Flexible(
                        fit: FlexFit.tight,
                        flex: 2,
                        child: Hero(
                            tag: pokeId.toString(),
                            child: CachedNetworkImage(
                                key: UniqueKey(),
                                fit: BoxFit.cover,
                                imageUrl: snapshot.data!.sprites!.front_default
                                    .toString(),
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Center(
                                    child: Icon(Icons.error,
                                        color: Colors.red))))),
                    Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: BorderedText(
                          strokeWidth: 3,
                          strokeColor: Colors.black,
                          child: Text(
                              snapshot.data!.name.toString().toCamelCase(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ))
                  ]),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    ),
  );
}
