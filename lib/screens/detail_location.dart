import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty/models/character.dart';
import 'package:rick_morty/providers/api_provider.dart';
import '../models/locations.dart';

class DetailLocation extends StatelessWidget {
  final Location location;
  const DetailLocation({Key? key, required this.location}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(location.name!),
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
                  tag: location.id!,
                  child: const FadeInImage(
                      placeholder:
                          AssetImage('assets/images/portal-rick-and-morty.gif'),
                      image: AssetImage('assets/images/snake_planet.jpg'))),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: size.height * 0.14,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  cardData("Dimension", location.dimension!),
                  cardData("Type", location.type!),
                ],
              ),
            ),
            Text(
              'Residents',
              style: TextStyle(fontSize: 17),
            ),
            ResidentsList(size: size, location: location)
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

class ResidentsList extends StatefulWidget {
  const ResidentsList({Key? key, required this.size, required this.location})
      : super(key: key);

  final Size size;
  final Location location;

  @override
  State<ResidentsList> createState() => _ResidentsListState();
}

class _ResidentsListState extends State<ResidentsList> {
  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getCharacterByLocation(widget.location);
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
