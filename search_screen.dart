import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_model.dart';
import 'book_provider.dart';
import 'book_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final filteredBooks = bookProvider.books
        .where((book) =>
            book.title.toLowerCase().contains(_query.toLowerCase()) ||
            book.author.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Books'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by title or author',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
          ),
          Expanded(
            child: filteredBooks.isEmpty
                ? const Center(child: Text('No books found.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: filteredBooks.length,
                    itemBuilder: (context, index) {
                      return BookCard(book: filteredBooks[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
