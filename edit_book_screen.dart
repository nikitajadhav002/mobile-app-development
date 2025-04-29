import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_model.dart';
import 'book_provider.dart';

class EditBookScreen extends StatefulWidget {
  final Book? book;

  const EditBookScreen({required this.book, super.key});

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Book _book;
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late BookStatus _status;
  late String _genre;

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
    _book = widget.book ??
        Book(
          id: DateTime.now().toString(),
          title: '',
          author: '',
          status: BookStatus.wantToRead,
        );
    _titleController = TextEditingController(text: _book.title);
    _authorController = TextEditingController(text: _book.author);
    _status = _book.status;
    _genre = _book.genre;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  void _saveBook() {
    if (_formKey.currentState!.validate()) {
      _book = _book.copyWith(
        title: _titleController.text,
        author: _authorController.text,
        status: _status,
        genre: _genre,
      );
      Provider.of<BookProvider>(context, listen: false)
          .updateBook(_book.id, _book);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Book'),
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
              ElevatedButton(
                onPressed: _saveBook,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
