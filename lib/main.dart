import 'package:cryptotracker/constants/themes.dart';
import 'package:cryptotracker/pages/HomePage.dart';
import 'package:cryptotracker/provider/market_provider.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'provider/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MarketProvider>(
            create: (context) {
              return MarketProvider();
            },
          ),
          ChangeNotifierProvider<themeProvider>(
            create: (context) {
              return themeProvider();
            },
          ),
          //
        ],
        child: Consumer<themeProvider>(
          builder: (context, provider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: provider.themeMode,
              theme: lightTheme,
              darkTheme: darkTheme,
              home: HomePage(),
            );
          },
        ));
  }
}
