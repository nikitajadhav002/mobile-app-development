import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_provider.dart';
import 'stats_provider.dart';
import 'stats_card.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final statsProvider = Provider.of<StatsProvider>(context);
    statsProvider.fetchStats(bookProvider.books);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StatsCard(
              title: 'Books Finished',
              value: statsProvider.stats['finishedBooks']?.toString() ?? '0',
            ),
            StatsCard(
              title: 'Favorite Genre',
              value: statsProvider.stats['favoriteGenre'] ?? 'Unknown',
            ),
          ],
        ),
      ),
    );
  }
}
