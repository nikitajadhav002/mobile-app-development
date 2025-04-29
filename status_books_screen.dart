import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'book_model.dart';
import 'book_provider.dart';
import 'book_card.dart';

class StatusBooksScreen extends StatefulWidget {
  final BookStatus status;
  final String title;

  const StatusBooksScreen(
      {required this.status, required this.title, super.key});

  @override
  _StatusBooksScreenState createState() => _StatusBooksScreenState();
}

class _StatusBooksScreenState extends State<StatusBooksScreen> {
  String _sortBy = 'title';
  bool _isAscending = true;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final filteredBooks = bookProvider.books
        .where((book) => book.status == widget.status)
        .toList();

    final searchedBooks = filteredBooks.where((book) {
      final query = _searchQuery.toLowerCase();
      return book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);
    }).toList();

    final sortedBooks = List<Book>.from(searchedBooks);
    if (_sortBy == 'title') {
      sortedBooks.sort((a, b) => _isAscending
          ? a.title.compareTo(b.title)
          : b.title.compareTo(a.title));
    } else if (_sortBy == 'progress') {
      sortedBooks.sort((a, b) => _isAscending
          ? a.progress.compareTo(b.progress)
          : b.progress.compareTo(a.progress));
    } else if (_sortBy == 'author') {
      sortedBooks.sort((a, b) => _isAscending
          ? a.author.compareTo(b.author)
          : b.author.compareTo(a.author));
    } else if (_sortBy == 'genre') {
      sortedBooks.sort((a, b) => _isAscending
          ? a.genre.compareTo(b.genre)
          : b.genre.compareTo(a.genre));
    } else if (_sortBy == 'dateAdded') {
      sortedBooks.sort((a, b) => _isAscending
          ? a.dateAdded.compareTo(b.dateAdded)
          : b.dateAdded.compareTo(a.dateAdded));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'toggleOrder') {
                setState(() {
                  _isAscending = !_isAscending;
                });
              } else {
                setState(() {
                  _sortBy = value;
                });
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'title', child: Text('Sort by Title')),
              const PopupMenuItem(
                  value: 'progress', child: Text('Sort by Progress')),
              const PopupMenuItem(
                  value: 'author', child: Text('Sort by Author')),
              const PopupMenuItem(value: 'genre', child: Text('Sort by Genre')),
              const PopupMenuItem(
                  value: 'dateAdded', child: Text('Sort by Date Added')),
              PopupMenuItem(
                value: 'toggleOrder',
                child:
                    Text(_isAscending ? 'Sort Descending' : 'Sort Ascending'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search by Title or Author',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: sortedBooks.isEmpty
                  ? Container(
                      color: Colors.grey[200], // Static background color
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bookmark_border,
                              size: 80,
                              color: Colors.grey[400],
                            ).animate().fadeIn(duration: 800.ms).scaleXY(
                                duration: 800.ms,
                                begin: 0.5,
                                end: 1.0), // Use scaleXY with doubles
                            const SizedBox(height: 16),
                            Text(
                              'No books in this category.',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 800.ms, delay: 200.ms)
                                .shake(),
                          ],
                        ),
                      ),
                    )
                      .animate()
                      .fadeIn(duration: 1000.ms) // Keep only valid animations
                  : ListView.builder(
                      itemCount: sortedBooks.length,
                      itemBuilder: (context, index) {
                        final book = sortedBooks[index];
                        return BookCard(book: book);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
