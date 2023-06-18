import 'package:cryptotracker/Widgets/CryptoListTile.dart';
import 'package:cryptotracker/models/Cryptocurrency.dart';
import 'package:cryptotracker/provider/market_provider.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(builder: (context, provider, child) {
      List<Cryptocurrency> favorites = provider.markets
          .where((element) => element.isFavorite == true)
          .toList();
      if (favorites.length > 0) {
        return ListView.builder(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              Cryptocurrency currentCrypto = favorites[index];
              return CryptoListTile(currentCrypto: currentCrypto);
            });
      } else {
        return Center(
            child: Text(
          "No favorites yet",
          style: TextStyle(fontSize: 17),
        ));
      }
    });
  }
}
