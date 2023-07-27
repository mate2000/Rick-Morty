import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty/models/character.dart';
import 'package:rick_morty/providers/api_provider.dart';

import '../models/episodes.dart';

class DetailEpisode extends StatelessWidget {
  final Episode episode;
  const DetailEpisode({Key? key, required this.episode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(episode.name!),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.35,
              width: double.infinity,
              child: Hero(
                  tag: episode.id!,
                  child: const Image(
                    image: AssetImage('assets/images/rick_morty_poster.jpg'),
                    fit: BoxFit.cover,
                  )),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: size.height * 0.14,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  cardData("Air Date", episode.airDate!),
                  cardData("Episode", episode.episode!),
                ],
              ),
            ),
            const Text(
              'Characters in the episode',
              style: TextStyle(fontSize: 17),
            ),
            CharacterList(size: size, episode: episode)
          ],
        ),
      ),
    );
  }

  Widget cardData(String text1, String text2) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(text1),
        Text(
          text2,
          style: const TextStyle(overflow: TextOverflow.ellipsis),
        )
      ],
    ));
  }
}

class CharacterList extends StatefulWidget {
  const CharacterList({Key? key, required this.size, required this.episode})
      : super(key: key);

  final Size size;
  final Episode episode;

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getCharacterByEpisode(widget.episode);
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    return SizedBox(
      height: widget.size.height * 0.35,
      child: ListView.builder(
        itemCount: apiProvider.characters.length,
        itemBuilder: (context, index) {
          final character = apiProvider.characters[index];
          return ListTile(
            title: Text(character.name!),
            trailing: Text(character.status!),
          );
        },
      ),
    );
  }
}
