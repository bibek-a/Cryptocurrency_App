import 'package:cryptotracker/Widgets/CryptoListTile.dart';
import 'package:cryptotracker/models/Cryptocurrency.dart';
import 'package:cryptotracker/pages/Details.dart';
import 'package:cryptotracker/provider/market_provider.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(builder: ((context, provider, child) {
      if (provider.isLoading == true) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (provider.markets.length > 0) {
          return RefreshIndicator(
            onRefresh: () async {
              await provider.fetchData();
            },
            child: ListView.builder(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: provider.markets.length,
              itemBuilder: (context, index) {
                Cryptocurrency currentCrypto = provider.markets[index];
                return CryptoListTile(currentCrypto: currentCrypto);
              },
            ),
          );
        } else {
          return Text("Data Not found");
        }
      }
    }));
  }
}
