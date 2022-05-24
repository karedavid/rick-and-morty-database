import 'package:flutter/material.dart';
import 'package:rick_and_morty_database/data/data_model.dart';

class DetailedCharacterPage extends StatelessWidget{

  final Character character;
  const DetailedCharacterPage({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(

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
                Hero(
                  tag: character.id,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        character.image,
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(character.name.toUpperCase(), style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text("Species: ${character.species}",
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text("Type: ${(character.type == "")?"not specified":character.type}",
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text("Gender: ${character.gender}",
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,10),
                  child: Text("Status: ${character.status}",
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }



}