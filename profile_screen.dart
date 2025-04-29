import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import 'routes.dart';
import 'book_provider.dart';
import 'book_model.dart'; // Added import for BookStatus

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    final bookProvider = Provider.of<BookProvider>(context);
    final readBooks = bookProvider.books
        .where((book) => book.status == BookStatus.read)
        .length;

    return Scaffold(
      appBar: AppBar(
        // Removed the erroneous '-'
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.logout();
              Navigator.pushReplacementNamed(context, Routes.welcome);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username: ${user?.username ?? 'Guest'}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Reading Streak',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('7 days'), // Placeholder for streak
            const SizedBox(height: 20),
            const Text(
              'Books Read',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('$readBooks books completed'),
            const SizedBox(height: 20),
            const Text(
              'Favorite Genres',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: bookProvider.getFavoriteGenres().map((genre) {
                return Chip(label: Text(genre));
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
