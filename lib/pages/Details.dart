import 'package:cryptotracker/models/Cryptocurrency.dart';
import 'package:cryptotracker/provider/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  const DetailsPage({super.key, required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String getPrice(double indianprice) {
    var nepaliPrice = indianprice * 1.6;
    return "Rs " + nepaliPrice.toStringAsFixed(3);
  }

  @override
  Widget build(BuildContext context) {
    Widget titleAndDetail(title, CrossAxisAlignment value, detail) {
      return Column(
        crossAxisAlignment: value,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          Text(
            detail.toString(),
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Consumer<MarketProvider>(
          builder: (context, provider, child) {
            Cryptocurrency currentCrypto = provider.fetchCryptoById(widget.id);
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  await provider.fetchData();
                },
                child: ListView(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage: NetworkImage(currentCrypto.image!),
                      ),
                      title: Text(currentCrypto.name! +
                          " (${currentCrypto.symbol!.toUpperCase()})"),
                      subtitle: Text(
                        getPrice(currentCrypto.currentPrice!),
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price Change(24h)",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Builder(builder: (context) {
                          double priceChange = currentCrypto.priceChange24!;
                          String NepaliPriceChange = getPrice(priceChange);
                          double priceChangePercentage =
                              currentCrypto.priceChangePercentage24!;
                          if (priceChange < 0) {
                            //negative
                            return Text(
                              "${priceChangePercentage.toStringAsFixed(2)}% (${NepaliPriceChange})",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            );
                          } else {
                            //positive
                            return Text(
                              "+${priceChangePercentage.toStringAsFixed(2)}%  (+${priceChange.toStringAsFixed(3)})",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 19,
                              ),
                            );
                          }
                        })
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail("Market Cap", CrossAxisAlignment.start,
                            getPrice(currentCrypto.marketCap!)),
                        titleAndDetail(
                          "Market Cap Rank",
                          CrossAxisAlignment.end,
                          "#" + currentCrypto.marketCapRank!.toStringAsFixed(0),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail("Low 24h", CrossAxisAlignment.start,
                            getPrice(currentCrypto.low24!)),
                        titleAndDetail(
                          "High 24h",
                          CrossAxisAlignment.end,
                          getPrice(currentCrypto.high24!),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail(
                            "Circulating Supply",
                            CrossAxisAlignment.start,
                            getPrice(currentCrypto.circulatingSupply!)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail("All time Low", CrossAxisAlignment.start,
                            getPrice(currentCrypto.atl!)),
                        titleAndDetail("All time High", CrossAxisAlignment.end,
                            getPrice(currentCrypto.ath!)),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
