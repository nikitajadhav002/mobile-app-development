import 'book_model.dart';

class BookService {
  final List<Book> _books = [];

  Future<List<Book>> getBooks() async {
    return _books;
  }

  Future<void> addBook(Book book) async {
    print(
        'BookService: Adding book - ${book.title}, ID: ${book.id}'); // Debug print
    _books.add(book);
  }

  Future<void> updateBook(String id, Book updatedBook) async {
    final index = _books.indexWhere((book) => book.id == id);
    if (index != -1) {
      _books[index] = updatedBook;
    }
  }

  Future<void> deleteBook(String id) async {
    _books.removeWhere((book) => book.id == id);
  }
}
