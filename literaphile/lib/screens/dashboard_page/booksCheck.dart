import 'package:flutter/material.dart';
import 'package:literaphile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:literaphile/models/wishlist.dart';
import 'package:literaphile/screens/wishlist_page/addWishlist.dart';
import 'package:literaphile/models/books.dart';
import 'package:http/http.dart' as http;

class BooksCheckPage extends StatefulWidget {
  const BooksCheckPage({Key? key}) : super(key: key);

  @override
  State<BooksCheckPage> createState() => _BooksCheckPage();
}

class _BooksCheckPage extends State<BooksCheckPage> {
  final _formKey = GlobalKey<FormState>();
  final String _name = "";

  Future<List<Wishlist>> fetchProduct() async {
    final request = context.watch<CookieRequest>();
    final response = await request
        .get('https://literaphile-f07-tk.pbp.cs.ui.ac.id/wishlist/json/');

    List<Wishlist> list_book = [];
    for (var d in response) {
      if (d != null) {
        list_book.add(Wishlist.fromJson(d));
      }
    }
    return list_book;
  }

  Future<List<Book>> fetchProductBook() async {
    final request = context.watch<CookieRequest>();
    final response = await request.get(
        'https://literaphile-f07-tk.pbp.cs.ui.ac.id/user_profile_page/json-books/');

    List<Book> list_book = [];
    for (var d in response) {
      if (d != null) {
        list_book.add(Book.fromJson(d));
      }
    }
    return list_book;
  }

  void _deleteProduct(int productId) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://literaphile-f07-tk.pbp.cs.ui.ac.id/user_profile_page/return-book-flutter/$productId/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 204) {
        // Produk berhasil dihapus
        // Lakukan apa pun yang diperlukan, seperti memperbarui tampilan
        setState(() {});
      } else {
        // Gagal menghapus produk, tampilkan pesan kesalahan
        print('Failed to delete product: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during product deletion: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books Check'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<dynamic>>(
        // Combine the results of both fetchProductBook and fetchProduct
        future: Future.wait([fetchProductBook(), fetchProduct()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('No data available');
          } else {
            List<Book> listBook = snapshot.data![0];
            List<Wishlist> listWishlist = snapshot.data![1];

            return ListView.builder(
              itemCount:
                  listBook.length + listWishlist.length + 2, // +2 for headers
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Header for Borrowed Books
                  if (listBook.isEmpty) {
                    return ListTile(
                      title: Text('Borrowed Books (No Borrowed Books)',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    );
                  } else {
                    return ListTile(
                      title: Text('Borrowed Books',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    );
                  }
                } else if (index <= listBook.length) {
                  // Display Book data using ListTile
                  int bookIndex = index - 1;
                  return ListTile(
                    title: Text(listBook[bookIndex].fields.title),
                    subtitle: Text(listBook[bookIndex].fields.author),
                    leading: Image.network(listBook[bookIndex].fields.image),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Handle the "Kembalikan" button tap
                        _deleteProduct(listBook[bookIndex]
                            .pk); // Panggil fungsi hapus produk dengan ID tertentu

                        // Add your logic here
                      },
                      child: Text('Kembalikan'),
                    ),
                    // Other book properties can be displayed here
                  );
                } else if (index == listBook.length + 1) {
                  // Header for Wishlisted Books
                  if (listWishlist.isEmpty) {
                    return ListTile(
                      title: Text('Wishlisted Books (No Wishlisted Books)',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    );
                  } else {
                    return ListTile(
                      title: Text('Wishlisted Books',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    );
                  }
                } else {
                  // Display Wishlist data using ListTile
                  int wishlistIndex = index - listBook.length - 2;
                  return ListTile(
                    title: Text(listWishlist[wishlistIndex].fields.title),
                    subtitle: Text(listWishlist[wishlistIndex].fields.author),
                    leading:
                        Image.network(listWishlist[wishlistIndex].fields.image),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
