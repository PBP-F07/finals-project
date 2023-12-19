import 'package:flutter/material.dart';
import 'package:literaphile/models/books.dart';
import 'package:literaphile/models/wishlist.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:literaphile/widgets/left_drawer.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  String username = '';
  String bio = '';

  Future<void> getUserInfo() async {
    final request = context.read<CookieRequest>();
    final response = await request.get(
        'https://literaphile-f07-tk.pbp.cs.ui.ac.id/user_profile_page/get-user-info/');

    setState(() {
      username = response['username'];
      bio = response['bio'];
    });
  }

  Future<List<Wishlist>> fetchProduct() async {
    final request = context.read<CookieRequest>();
    final response = await request
        .get('https://literaphile-f07-tk.pbp.cs.ui.ac.id/wishlist/json/');

    List<Wishlist> listWishlist = [];
    for (var d in response) {
      if (d != null) {
        listWishlist.add(Wishlist.fromJson(d));
      }
    }
    return listWishlist;
  }

  Future<List<Book>> fetchProductBook() async {
    final request = context.read<CookieRequest>();
    final response = await request.get(
        'https://literaphile-f07-tk.pbp.cs.ui.ac.id/user_profile_page/json-books/');

    List<Book> listBook = [];
    for (var d in response) {
      if (d != null) {
        listBook.add(Book.fromJson(d));
      }
    }
    return listBook;
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LeftDrawer(),
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<dynamic>>(
          future: Future.wait([fetchProductBook(), fetchProduct()]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No data available'));
            } else {
              List<Book> listBook = snapshot.data![0];
              List<Wishlist> listWishlist = snapshot.data![1];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Username    : $username'),
                  Divider(color: Colors.black),
                  Text('Bio             : $bio'),
                  Divider(color: Colors.black),
                  Text('Member of Literaphile'),
                  SizedBox(height: 20),

                  Expanded(
                    child: ListView.builder(
                      itemCount: listBook.length + listWishlist.length + 2,
                      itemBuilder: (context, index) {
                        if (index == 0) {
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
                          int bookIndex = index - 1;
                          return ListTile(
                            title: Text(listBook[bookIndex].fields.title),
                            subtitle: Text(listBook[bookIndex].fields.author),
                            leading: Image.network(listBook[bookIndex].fields.image),
                            trailing: ElevatedButton(
                              onPressed: () {
                                _deleteProduct(listBook[bookIndex].pk);
                              },
                              child: Text('Kembalikan'),
                            ),
                          );
                        } else if (index == listBook.length + 1) {
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
                          int wishlistIndex = index - listBook.length - 2;
                          return ListTile(
                            title: Text(listWishlist[wishlistIndex].fields.title),
                            subtitle: Text(listWishlist[wishlistIndex].fields.author),
                            leading: Image.network(listWishlist[wishlistIndex].fields.image),
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
