import 'book_model.dart';

class StatsService {
  Future<Map<String, dynamic>> getStats(List<Book> books) async {
    final finishedBooks =
        books.where((book) => book.status == BookStatus.finished).length;
    final genres = books.map((book) => book.genre).toSet().toList();
    return {
      'finishedBooks': finishedBooks,
      'favoriteGenre': genres.isNotEmpty ? genres.first : 'Unknown',
    };
  }
}
