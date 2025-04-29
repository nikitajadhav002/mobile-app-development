import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_model.dart';
import 'book_provider.dart';
import 'routes.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({required this.book, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.book),
        title: Text(book.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.author),
            const SizedBox(height: 4),
            Text(
              'Status: ${book.status.toString().split('.').last}',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Genre: ${book.genre}',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: book.progress,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            Text(
              '${(book.progress * 100).round()}% Read',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove, size: 16),
              onPressed: () {
                _showProgressDialog(context, book.progress - 0.1);
              },
            ),
            SizedBox(
              width: 80,
              child: Slider(
                value: book.progress,
                min: 0.0,
                max: 1.0,
                divisions: 100,
                label: '${(book.progress * 100).round()}%',
                onChanged: (value) {
                  _showProgressDialog(context, value);
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add, size: 16),
              onPressed: () {
                _showProgressDialog(context, book.progress + 0.1);
              },
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.bookDetails,
            arguments: book,
          );
        },
      ),
    );
  }

  void _showProgressDialog(BuildContext context, double newProgress) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Progress'),
        content: Text(
          'Set progress to ${(newProgress * 100).round()}%?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final clampedProgress = newProgress.clamp(0.0, 1.0);
              final updatedBook = book.copyWith(progress: clampedProgress);
              Provider.of<BookProvider>(context, listen: false)
                  .updateBook(book.id, updatedBook);
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
