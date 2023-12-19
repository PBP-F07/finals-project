import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:literaphile/models/admin_books.dart';
import 'dart:convert';
import 'package:literaphile/widgets/admin_drawer.dart';

class ManageBooks extends StatefulWidget {
    const ManageBooks({Key? key}) : super(key: key);

    @override
    State<ManageBooks> createState() => _ManageBooksState();
}

class _ManageBooksState extends State<ManageBooks> {
  List<Book> books = [];
  bool isPressed = false;
  TextEditingController searchController = TextEditingController();

  Future<void> fetchBooks() async {
    final response = await http.get(Uri.parse('https://literaphile-f07-tk.pbp.cs.ui.ac.id/administrator/get-allbooks-mobile/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final String booksJson = jsonData['books'];

      final List<dynamic> booksData = jsonDecode(booksJson);

      setState(() {
        books = bookFromJson(jsonEncode(booksData));
      });

    } else {
      print('Failed to fetch wishlist items: ${response.statusCode}');
    }
  }

  Future<void> deleteBook(int id) async {
    final url = Uri.parse('https://literaphile-f07-tk.pbp.cs.ui.ac.id/administrator/managebooks/delete-book/$id');
    
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        // debugPrint('Wishlist item rejected successfully');
        await fetchBooks();
      } else {
        print('Failed to reject wishlist item: ${response.statusCode}');
      }
    } catch (error) {
      print('Error rejecting wishlist item: $error');
    }
  }

  Future<void> searchBooks(String? query) async {
    final response = await http.get(
      Uri.parse('https://literaphile-f07-tk.pbp.cs.ui.ac.id/administrator/get-search-title-mobile/?title=$query'),
    );

    // debugPrint('$query IS THE QUERY');

    if (response.statusCode == 200) {

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final String searchJson = jsonData['books'];

      final List<dynamic> searchData = jsonDecode(searchJson);
      
      // debugPrint(searchBooks.toString());

      setState(() {
        books = bookFromJson(jsonEncode(searchData));
      });

      // await fetchBooks();
    } else {
      print('Error searching books: ${response.statusCode}');
    }

  }

  @override
  void initState() {
    fetchBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Wishlist Items'),
      // ),

      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0.0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(width: 10.0),

            Icon(
              Icons.settings,
              size: 32.0,
            ),

            SizedBox(width: 10.0),

            Text(
              'LiteraPhile Admin',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by title',
                suffixIcon: IconButton(
                  onPressed: () {
                    String title = searchController.text.trim();
                    if (title.isNotEmpty) {
                      searchBooks(title);
                    } else {
                      print('Search query is empty!');
                    }
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
              onSubmitted: (value) {
                searchBooks(value);
              },
            ),
          ),

          Expanded(
            child: books.isEmpty
            ? Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox_rounded,
                        size: 64.0,
                        color: Colors.grey,
                      ),
                      Text(
                        'Tidak ada buku di database . . .',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: books.length,
                    itemBuilder: (BuildContext context, int index) {
                      final currentWishlist = books[index];

                      return SizedBox(
                        child: ListTile(
                          leading: SizedBox(
                            child: Image.network(
                              currentWishlist.fields.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            currentWishlist.fields.title,
                            style: const TextStyle(
                              fontSize: 18.0, // Adjust font size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${currentWishlist.fields.author} (${currentWishlist.fields.yearOfRelease})',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  deleteBook(currentWishlist.pk);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Buku "${currentWishlist.fields.title}" telah dihapus!'),
                                      duration: const Duration(seconds: 3), // Duration to display the SnackBar
                                      behavior: SnackBarBehavior.floating, // Make the SnackBar floating
                                      margin: const EdgeInsets.all(16.0), // Adjust margin as needed
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0), // Optional: customize SnackBar shape
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],  
              ),
            ),
          )
        ]
      ),
      

      // DRAWER BUTTON
      floatingActionButton: GestureDetector(
        onTapDown: (_) {
          setState(() {
            isPressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            isPressed = false;
          });
        },

        child: AnimatedOpacity(
          opacity: isPressed ? 1.0 : 0.5,
          duration: const Duration(milliseconds: 300),
          child: Ink(
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: CircleBorder(),
            ),
            child: FloatingActionButton(
              onPressed: () {

                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const AdminDrawer();
                  },
                );

                Future.delayed(const Duration(milliseconds: 200), () {
                  setState(() {
                    isPressed = false;
                  });
                });
              },

              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Icon(Icons.arrow_upward),
            ),
          )
            
        ),
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const SizedBox(
        height: 50.0,
      ),

    );
  }
}