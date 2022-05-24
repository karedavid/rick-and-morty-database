import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_database/bloc/search_bloc.dart';
import 'package:rick_and_morty_database/ui/detailed_characters.dart';
import '../bloc/search_bloc.dart';

class ListCharactersPage extends StatelessWidget {
  const ListCharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,

        title: TextField(
          cursorColor: Colors.white,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 20),
          decoration: const InputDecoration(
            hintText: "Search",
            suffixIcon: Icon(Icons.search,
            color: Colors.white,),
            suffixIconColor: Colors.white,
            hintStyle: TextStyle(
                color: Colors.white,
            ),
            enabledBorder: InputBorder.none,
            border: InputBorder.none,

          ),
          onChanged: (text) {
            context.read<SearchBloc>().add(SearchUpdateCharacterEvent(text));
          },
        ),
        centerTitle: false,

      ),
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + kToolbarHeight),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("graphics/background/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: BlocConsumer<SearchBloc, SearchState>(
            listenWhen: (_, state) => (state is SearchErrorEventState) || (state is SearchResultListState),
            listener: (context, state) {
              if (state is SearchErrorEventState) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }

              if (state is SearchResultListState) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("${state.results.length} characters loaded")));

              }
            },
            buildWhen: (_, state) => ((state is SearchResultListState) || (state is SearchLoadingState)),
            builder: (context, state) {
              if (state is SearchResultListState) {
                return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                  itemBuilder: (context, index) {
                    var character = state.results[index];
                    return SizedBox(
                      height: 120,
                      child: GestureDetector(
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
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.yellow,
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Row(
                              children: [
                                Hero(
                                  tag: character.id,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: SizedBox(
                                      width: 112,
                                      child: Image.network(
                                        character.image
                                      ),
                                    ),
                                  ),
                                ),

                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      character.name,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: state.results.length,
                );
              } else if(state is SearchLoadingState){
                  return const Center(
                    child: CircularProgressIndicator(
                      value: null,
                    ),
                  );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
