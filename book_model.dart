enum BookStatus { wantToRead, currentlyReading, read }

class Book {
  final String id;
  final String title;
  final String author;
  final BookStatus status;
  final String genre;
  final double? progress;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.status,
    required this.genre,
    this.progress,
  });
}
