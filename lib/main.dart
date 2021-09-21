import 'package:fluttemons/api/pokeapi.dart';
import 'package:fluttemons/models/pokeapi_models.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

Future<Pokemon>? pokemon;
List<Future<Pokemon>> pokemons = <Future<Pokemon>>[];

class ImageLoader {
  static getPokeData(int num) async {
    // var pokeJson = await PokeAPI().getPokemon(num);
    // var pokeMap = json.decode(pokeJson);

    return pokemon;

    print('from getPokeData');
    //print(pokemon..frontDefault);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 1;

  String _imageURL =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png';

  void getPokemons() {
    for (var i = 0; i < 20; i++) {
      pokemons.add(PokeAPI().getPokemon(i + 1));
      print(pokemons[i].toString());
    }
  }

  @override
  void initState() {
    super.initState();
    //pokemon = PokeAPI().getPokemon(_counter);
    getPokemons();
    print('from init');
  }

  void _incrementCounter() {
    _counter++;
    print('tap');

    setState(() {
      pokemon = PokeAPI().getPokemon(_counter);
    });
  }

  Widget appBarImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/pokemon_background.png'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            //title: Text('SliverAppBar'),
            backgroundColor: Colors.cyan,
            expandedHeight: 200.0,
            floating: false,
            //snap: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: appBarImage(),

              // Image.asset('assets/images/pokemon_background.png',
              //     height: 200.0, width: 500),
              title: Text(
                'Fluttemons',
                style: TextStyle(
                    color: Colors.black, backgroundColor: Colors.cyan),
              ),
              centerTitle: true,
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                  child: pokeCard(index),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}

Widget pokeCard(int index) {
  return Container(
    alignment: Alignment.center,
    child: FutureBuilder<Pokemon>(
      future: pokemons[index],
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        if (snapshot.hasData &&
            snapshot.connectionState.toString() == 'ConnectionState.done') {
          return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.network(snapshot.data!.sprites!.frontDefault.toString()),
                Text(snapshot.data!.name.toString().toUpperCase())
              ]);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    ),
  );
}
