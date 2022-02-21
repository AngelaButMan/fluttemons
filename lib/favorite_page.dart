import 'package:flutter/material.dart';
import 'package:state_set/state_set.dart';
import 'datastrore/pokemon_firestore.dart';
import 'datastrore/pokemon_local_store.dart';
import 'pokemon_page.dart';
import 'widgets/pokecard_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  void stateFavoriteMark() {
    final _FavoritePageState? state = StateSet.to<_FavoritePageState>();
    state?.setState(() {});
  }

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with StateSet {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: favoriteList.length,
          itemBuilder: (_, index) {
            return Stack(
              children: [
                pokeCard(index, favoriteList),
                GestureDetector(
                  onTap: () async {
                    var pokemon = await favoriteList[index];
                    var id = pokemon.id;
                    setState(() {
                      favoriteList.remove(favoriteList[index]);
                      favMarks.remove(id.toString());
                    });
                    await PokemonLocalStore.setLocalFavMarks(favMarks);
                    PokemonFireStore.updateUserData(userData);
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(right: 10, top: 10),
                    child: Icon(
                      Icons.highlight_remove_outlined,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
