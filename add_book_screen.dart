import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_model.dart';
import 'book_provider.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  BookStatus _status = BookStatus.wantToRead;
  String _genre = 'Unknown';
  bool _isLoading = false;

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
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  void _addBook() async {
    if (_formKey.currentState!.validate() && !_isLoading) {
      setState(() {
        _isLoading = true;
      });
      final book = Book(
        id: DateTime.now().toString(),
        title: _titleController.text,
        author: _authorController.text,
        status: _status,
        genre: _genre,
      );
      print('Adding book: ${book.title}, Status: ${book.status}');
      Provider.of<BookProvider>(context, listen: false)
          .addBook(book); // Removed await
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Author'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the author';
                  }
                  return null;
                },
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
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _addBook,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Add Book'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
