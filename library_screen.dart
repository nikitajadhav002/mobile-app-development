import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_provider.dart';
import 'book_card.dart';
import 'routes.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          final books = bookProvider.books;
          if (books.isEmpty) {
            return const Center(child: Text('No books added yet.'));
          }
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              return BookCard(book: books[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addBook);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
