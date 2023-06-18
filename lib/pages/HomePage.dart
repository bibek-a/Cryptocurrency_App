import 'package:cryptotracker/constants/themes.dart';
import 'package:cryptotracker/models/Cryptocurrency.dart';
import 'package:cryptotracker/pages/Details.dart';
import 'package:cryptotracker/pages/Favourites.dart';
import 'package:cryptotracker/pages/Market.dart';
import 'package:cryptotracker/provider/market_provider.dart';
import 'package:cryptotracker/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController viewController;
  @override
  void initState() {
    // TODO: implement initState
    viewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 20, left: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Crypto Today",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<themeProvider>(context, listen: false)
                          .toggleTheme();
                    },
                    icon: Provider.of<themeProvider>(context, listen: false)
                                .themeMode ==
                            ThemeMode.light
                        ? Icon(Icons.dark_mode)
                        : Icon(Icons.light_mode),
                    padding: EdgeInsets.all(0),
                    iconSize: 40,
                  ),
                ],
              ),
              SizedBox(height: 10),
              TabBar(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                controller: viewController,
                tabs: [
                  Tab(
                    child: Text(
                      "Markets",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Favorites",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: viewController,
                  children: [
                    Market(),
                    Favorites(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
