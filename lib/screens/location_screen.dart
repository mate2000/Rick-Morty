import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../providers/api_provider.dart';

class LocationList extends StatelessWidget {
  const LocationList(
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
          childAspectRatio: 1,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5),
      itemCount: isLoading
          ? apiProvider.locations.length + 2
          : apiProvider.locations.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index < apiProvider.locations.length) {
          final location = apiProvider.locations[index];
          return GestureDetector(
            onTap: () {
              context.go('/location', extra: location);
            },
            child: Card(
                child: Column(
              children: [
                Expanded(
                    child: Hero(
                  tag: location.id!,
                  child: const Image(
                      image: AssetImage('assets/images/snake_planet.jpg')),
                )),
                Text(
                  "${location.name!} - ${location.type}",
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
