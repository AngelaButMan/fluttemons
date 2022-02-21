import 'package:fluttemons/favorite_page.dart';
import 'package:fluttemons/pokemon_page.dart';
import 'package:fluttemons/settings_page.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  DateTime? lastPressed;

  Future<bool> onWillPop() {
    final now = DateTime.now();
    final messageDuration = Duration(seconds: 3);

    if (lastPressed == null || now.difference(lastPressed!) > messageDuration) {
      lastPressed = now;
      final snackBar = SnackBar(
          content: Text('Double tap to close'), duration: messageDuration);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);

      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Fluttemons'),
            centerTitle: true,
            backgroundColor: Colors.cyan,
            bottom:
                TabBar(indicatorColor: Colors.white, indicatorWeight: 5, tabs: [
              Tab(text: 'Pokemons', icon: Icon(Icons.list_outlined)),
              Tab(text: 'Favorites', icon: Icon(Icons.star)),
              Tab(text: 'Settings', icon: Icon(Icons.settings))
            ]),
          ),
          body: WillPopScope(
            onWillPop: onWillPop,
            child: TabBarView(
                children: [PokemonPage(), FavoritePage(), SettingsPage()]),
          )));
}
