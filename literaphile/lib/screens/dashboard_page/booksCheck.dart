import 'package:flutter/material.dart';
import 'package:literaphile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class BooksCheckPage extends StatefulWidget {
  const BooksCheckPage({Key? key}) : super(key: key);

  @override
  State<BooksCheckPage> createState() => _BooksCheckPage();
}

class _BooksCheckPage extends State<BooksCheckPage> {
  final _formKey = GlobalKey<FormState>();
  final String _name = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Literaphile'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Books',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Add Borrowed Books Section
              _buildBooksSection('Borrowed Books', '{list of borrowed books}'),
              // Add Wishlisted Books Section
              _buildBooksSection(
                  'Wishlisted Books', '{list of wishlisted books}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBooksSection(String title, String booksList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const Divider(),
        _buildBooksList(booksList),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBooksList(String booksList) {
    List<String> books = booksList.split(',');

    return Column(
      children: books.map((book) {
        return ListTile(
          title: Text(book.trim(), textAlign: TextAlign.center),
        );
      }).toList(),
    );
  }
}
