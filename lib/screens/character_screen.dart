import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty/providers/api_provider.dart';
import 'package:rick_morty/screens/episodes_screen.dart';
import 'package:rick_morty/screens/location_screen.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key? key}) : super(key: key);
  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  final scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getCharacter(page);
    apiProvider.getLocations(page);
    apiProvider.getEpisodes(page);
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        page++;
        await apiProvider.getCharacter(page);
        await apiProvider.getLocations(page);
        await apiProvider.getEpisodes(page);
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    final screens = [
      CharacterList(
        apiProvider: apiProvider,
        isLoading: isLoading,
        scrollController: scrollController,
      ),
      EpisodeList(
          apiProvider: apiProvider,
          scrollController: scrollController,
          isLoading: isLoading),
      LocationList(
          apiProvider: apiProvider,
          scrollController: scrollController,
          isLoading: isLoading)
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rick and Morty',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: apiProvider.characters.isNotEmpty
            ? screens[selectedIndex]
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.man_2_rounded),
              activeIcon: Icon(Icons.man),
              label: 'Character',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              activeIcon: Icon(Icons.list_alt_sharp),
              label: 'Episodes',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.filter_hdr_rounded),
                activeIcon: Icon(Icons.filter_hdr_sharp),
                label: 'Locations'),
          ]),
    );
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList(
      {super.key,
      required this.apiProvider,
      required this.scrollController,
      required this.isLoading});

  final ApiProvider apiProvider;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.87,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemCount: isLoading
          ? apiProvider.characters.length + 2
          : apiProvider.characters.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index < apiProvider.characters.length) {
          final character = apiProvider.characters[index];
          return GestureDetector(
            onTap: () {
              context.go('/character', extra: character);
            },
            child: Card(
                child: Column(
              children: [
                Hero(
                  tag: character.id!,
                  child: FadeInImage(
                      placeholder: const AssetImage(
                          'assets/images/portal-rick-and-morty.gif'),
                      image: NetworkImage(character.image!)),
                ),
                Text(
                  "${character.name!} - ${character.status}",
                  style: const TextStyle(
                      fontSize: 16, overflow: TextOverflow.ellipsis),
                )
              ],
            )),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
