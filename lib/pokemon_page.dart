import 'dart:developer';

import 'package:fluttemons/datastrore/pokemon_local_store.dart';
import 'package:fluttemons/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttemons/api/pokeapi.dart';
import 'package:fluttemons/models/pokeapi_models.dart';
import 'package:state_set/state_set.dart';
import 'datastrore/pokemon_firestore.dart';
import 'widgets/pokecard_widget.dart';

List<Future<Pokemon>> pokemonList = [];
List<Future<Pokemon>> favoriteList = [];
List<String> favMarks = [];
bool hasLocalData = false;

UserData userData = UserData(favoritePokemons: favMarks);

setFavoritePokemonsList() async {
  for (var i = 0; i < pokemonList.length; i++) {
    if (favMarks.contains((i + 1).toString()) &&
        !favoriteList.contains(pokemonList[i]))
      favoriteList.add(pokemonList[i]);
    else if (!favMarks.contains((i + 1).toString()))
      favoriteList.remove(pokemonList[i]);
  }
}

class PokemonPage extends StatefulWidget {
  const PokemonPage({Key? key}) : super(key: key);

  void stateFavoriteMark() {
    final _PokemonPageState? state = StateSet.to<_PokemonPageState>();
    state?.setState(() {});
  }

  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> with StateSet {
  int _page = 0;
  int _limit = 15;

  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;

  getPokemons() async {
    for (var i = _page * _limit; i < (_page + 1) * _limit; i++) {
      pokemonList.add(PokeAPI().getPokemon(i + 1));
    }
    //await PokemonLocalStore.setLocalPokemon(pokemonList, _keyAllPokemons);
  }

  List toListFutures(List staticInput) {
    List<Future<Pokemon>> futureList = [];
    for (var item in staticInput) {
      futureList.add(Future.value(item));
    }
    hasLocalData = true;
    return futureList;
  }

  Widget _showSnackBar() {
    final message = 'All data fetched';
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: "Ok",
        onPressed: () {},
      ),
    );
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    });
    return Container();
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      setState(() {
        if (pokemonList.length == 0) getPokemons();
      });
      userData = await PokemonFireStore.getUserData();
      favMarks = userData.favoritePokemons;
    } catch (err) {
      print('Something went wrong');
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      _page += 1;
      try {
        if (_page < 10) {
          setState(() {
            if (pokemonList.length <= _page * _limit) getPokemons();
          });
          await PokemonLocalStore.setLocalPokemon(pokemonList);
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    if (!hasLocalData) {
      favMarks = PokemonLocalStore.getLocalFavMArks() ?? [];
      print('List localstore: ${favMarks.toString()}');
      pokemonList = toListFutures(PokemonLocalStore.getLocalPokemon())
          as List<Future<Pokemon>>;
    }
    _firstLoad();
    setFavoritePokemonsList();
    //
    print('List: ${favMarks.toString()}');
    print('Object ${userData.favoritePokemons.toString()}');
    inspect(favoriteList);
    //print(favoriteList.toString());

    _controller = new ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: _isFirstLoadRunning
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      controller: _controller,
                      itemCount: pokemonList.length,
                      itemBuilder: (_, index) {
                        bool _isFavorite =
                            //favoriteList.contains(pokemonList[index]);
                            favMarks.contains((index + 1).toString());
                        //print('alo ${_isFavorite.toString()}');
                        return Stack(
                          children: [
                            pokeCard(index, pokemonList),
                            GestureDetector(
                              onTap: () async {
                                var pokemon = await pokemonList[index];
                                var id = pokemon.id;

                                setState(() {
                                  _isFavorite
                                      ? favMarks.remove(id.toString())
                                      : favMarks.add(id.toString());
                                });
                                setFavoritePokemonsList();
                                await PokemonLocalStore.setLocalFavMarks(
                                    favMarks);
                                print(userData.favoritePokemons.toString());
                                PokemonFireStore.updateUserData(userData);
                                //inspect(favoriteList);
                              },
                              child: Container(
                                alignment: Alignment.topRight,
                                padding:
                                    const EdgeInsets.only(right: 10, top: 10),
                                child: Icon(
                                  _isFavorite ? Icons.star : Icons.star_border,
                                  color: Colors.yellow,
                                  size: 36,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                if (_isLoadMoreRunning == true)
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (_hasNextPage == false) _showSnackBar()
              ],
            ),
    );
  }
}
