import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeroDatabase extends StatefulWidget {
  const HeroDatabase({super.key});

  @override
  State createState() => _HeroDatabaseState();
}

class _HeroDatabaseState extends State<HeroDatabase> {
  List<String> heroes = [
    'Iron Man',
    'Captain America',
    'Thor',
    'Black Widow',
    'Hulk',
    'Hawkeye',
    'ShangChi',
    'Black Panther',
    'Wolverine',
    'Deadpool'
  ];
  List<String> favoriteHeroes = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteHeroes = prefs.getStringList('favoriteHeroes') ?? [];
    });
  }

  _toggleFavorite(String hero) async {
    setState(() {
      if (favoriteHeroes.contains(hero)) {
        favoriteHeroes.remove(hero);
      } else {
        favoriteHeroes.add(hero);
      }
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteHeroes', favoriteHeroes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        foregroundColor: Colors.white,
        title: const Text('List Heroes Marvel'),
      ),
      body: ListView.builder(
        itemCount: heroes.length,
        itemBuilder: (context, index) {
          final hero = heroes[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            child: ListTile(
              title: Text(
                hero,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: Icon(
                  favoriteHeroes.contains(hero)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: favoriteHeroes.contains(hero) ? Colors.red : null,
                ),
                onPressed: () => _toggleFavorite(hero),
              ),
            ),
          );
        },
      ),
    );
  }
}
