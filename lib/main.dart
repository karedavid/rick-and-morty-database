import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_database/ui/list_characters.dart';
import 'package:rick_and_morty_database/ui/list_episodes.dart';
import 'package:rick_and_morty_database/ui/list_locations.dart';

import 'bloc/search_bloc.dart';

void main() async {
  runApp(const MyApp());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: false,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
    ),
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick & Morty Database',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.yellow,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light, // 2
        ),
      ),
      home: const MyHomePage(),
      routes: {
        "/characters": (context) => BlocProvider(
            create: (_) => SearchBloc()..add(SearchUpdateCharacterEvent("")),
            child: const ListCharactersPage()),
        "/locations": (context) => BlocProvider(
            create: (_) => SearchBloc()..add(SearchUpdateLocationEvent("")),
            child: const ListLocationsPage()),
        "/episodes": (context) => BlocProvider(
            create: (_) => SearchBloc()..add(SearchUpdateEpisodeEvent("")),
            child: const ListEpisodesPage()),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("graphics/background/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            const Image(
              image: AssetImage("graphics/logo/header.png"),
              width: double.infinity,
              height: 300,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 300, 0, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/characters",
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.yellow,
                        elevation: 10,
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          children: const [
                            Image(
                                height: 220,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "graphics/images/menu_characters.jpg")),
                            Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  "Characters",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(5,0,5,5),
                                child: Text(
                                    "Learn more about your favorite characters",style: TextStyle(
                                    fontSize: 18.0)))
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/locations",
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.yellow,
                        elevation: 10,
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          children: const [
                            Image(
                                height: 220,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "graphics/images/menu_locations.png")),
                            Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  "Locations",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(5,0,5,5),
                                child: Text("Planets, systems, dimensions and more",
                                  style: TextStyle(
                                      fontSize: 18.0),
                                ))
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/episodes",
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.yellow,
                        elevation: 10,
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          children: const [
                            Image(
                                height: 220,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "graphics/images/menu_episodes.png")),
                            Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  "Episodes",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(5,0,5,5),
                                child: Text(
                                  "List and learn more about the episodes", style: TextStyle(
                                    fontSize: 18
                                ),))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
