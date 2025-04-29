import 'package:flutter/material.dart';
import 'book_model.dart';

class BookProvider with ChangeNotifier {
  final List<Book> _books = [];

  List<Book> get books => _books;

  void addBook(Book book) {
    _books.add(book);
    notifyListeners();
  }

  void updateBook(String id, Book updatedBook) {
    final index = _books.indexWhere((book) => book.id == id);
    if (index != -1) {
      _books[index] = updatedBook;
      notifyListeners();
    }
  }

  void removeBook(String id) {
    _books.removeWhere((book) => book.id == id);
    notifyListeners();
  }

  List<String> getFavoriteGenres() {
    final genreCount = <String, int>{};
    for (var book in _books) {
      genreCount[book.genre] = (genreCount[book.genre] ?? 0) + 1;
    }
    return genreCount.entries
        .where((entry) => entry.value > 0)
        .map((entry) => entry.key)
        .toList();
  }
}
