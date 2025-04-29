import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_model.dart';
import 'book_provider.dart';
import 'routes.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late BookStatus _status;
  late String _genre;
  double _progress = 0.0;

  final List<String> _genres = [
    'Unknown',
    'Fiction',
    'Non-Fiction',
    'Mystery',
    'Fantasy',
    'Science Fiction',
    'Biography',
    'Self-Help',
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.author);
    _status = widget.book.status;
    _genre = widget.book.genre;
    _progress = widget.book.progress ?? 0.0;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  void _updateBook() async {
    final updatedBook = Book(
      id: widget.book.id,
      title: _titleController.text,
      author: _authorController.text,
      status: _status,
      genre: _genre,
      progress: _progress,
    );
    await Provider.of<BookProvider>(context, listen: false)
        .updateBook(widget.book.id, updatedBook);
    Navigator.pop(context);
  }

  void _deleteBook() async {
    await Provider.of<BookProvider>(context, listen: false)
        .removeBook(widget.book.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteBook,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(labelText: 'Author'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<BookStatus>(
              value: _status,
              decoration: const InputDecoration(labelText: 'Status'),
              items: BookStatus.values
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status.toString().split('.').last),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => _status = value!);
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _genre,
              decoration: const InputDecoration(labelText: 'Genre'),
              items: _genres
                  .map((genre) => DropdownMenuItem(
                        value: genre,
                        child: Text(genre),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => _genre = value!);
              },
            ),
            const SizedBox(height: 10),
            if (_status == BookStatus.currentlyReading)
              Slider(
                value: _progress,
                min: 0.0,
                max: 100.0,
                divisions: 100,
                label: '${_progress.round()}%',
                onChanged: (value) {
                  setState(() => _progress = value);
                },
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateBook,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Update Book'),
            ),
          ],
        ),
      ),
    );
  }
}
