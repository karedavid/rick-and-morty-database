import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_database/bloc/details_request_bloc.dart';
import 'package:rick_and_morty_database/data/data_model.dart';

import 'detailed_characters.dart';

class DetailedLocationPage extends StatelessWidget {
  final Location location;

  const DetailedLocationPage({Key? key, required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return DetailsBloc()..add(LocationInfoRequestEvent(location.id));
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
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + kToolbarHeight),
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
                    location.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Dimension: ${location.dimension}",
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Type: ${(location.type == "") ? "not specified" : location.type}",
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Residents:",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                BlocConsumer<DetailsBloc, DetailsRequestState>(
                    listenWhen: (_, state) => state is DetailsRequestErrorState,
                    listener: (context, state) {
                      if (state is DetailsRequestErrorState) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    buildWhen: (_, state) =>
                        (state is LocationInfoResultState) ||
                        (state is DetailsRequestLoadingState),
                    builder: (context, state) {
                      if (state is LocationInfoResultState) {
                        if (state.location.residents.isEmpty) {
                          return const Expanded(
                              child: Center(
                            child: Text(
                                "There aren't any known residents at this location",
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
                              var item = state.location.residents[index];
                              return GridTile(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Hero(
                                          tag: item.id,
                                          child: Image.network(
                                            item.image,
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
                                                    FocusManager
                                                        .instance.primaryFocus
                                                        ?.unfocus();
                                                    return DetailedCharacterPage(
                                                        character: item);
                                                  },
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
                            itemCount: state.location.residents.length,
                          ),
                        );
                      } else if (state is DetailsRequestLoadingState) {
                        return const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.deepPurple,
                              value: null,
                            ),
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
