import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_database/bloc/details_request_bloc.dart';
import 'package:rick_and_morty_database/data/data_model.dart';

import 'detailed_characters.dart';

class DetailedEpisodePage extends StatelessWidget {
  final Episode episode;

  const DetailedEpisodePage({Key? key, required this.episode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return DetailsBloc()..add(EpisodeInfoRequestEvent(episode.id));
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          scrolledUnderElevation: 0,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("graphics/background/background.jpg"),
                fit: BoxFit.cover),
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.yellow,
            elevation: 10,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    episode.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Episode: ${episode.episode}",
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Air date: ${episode.air_date}",
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Characters in this episode:",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                BlocConsumer<DetailsBloc, DetailsRequestState>(
                    listenWhen: (_, state) =>
                    state is DetailsRequestErrorState,
                    listener: (context, state) {
                      if (state is DetailsRequestErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)));
                      }
                    },
                    buildWhen: (_, state) =>
                    state is EpisodeInfoResultState,
                    builder: (context, state) {
                      if (state is EpisodeInfoResultState) {

                        if (state.episode.characters.isEmpty) {
                          return const Expanded(
                              child: Center(
                                child: Text(
                                    "There aren't any known characters in this episode",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                    textAlign: TextAlign.center),
                              ));
                        }

                        return Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(10),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 100,
                              crossAxisCount: 3,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              childAspectRatio: 1 / 1,
                            ),
                            itemBuilder: (context, index) {
                              var character = state.episode.characters[index];
                              //return Image.network(item.image, width: 90);
                              return GridTile(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Hero(
                                          tag: character.id,
                                          child: Image.network(
                                            character.image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    FocusManager.instance.primaryFocus?.unfocus();
                                                    return DetailedCharacterPage(character: character);},
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: state.episode.characters.length,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}