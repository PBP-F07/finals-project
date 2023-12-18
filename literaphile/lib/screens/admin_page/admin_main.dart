import 'package:flutter/material.dart';
import 'package:literaphile/screens/admin_page/manage_books.dart';
import 'package:literaphile/screens/admin_page/see_users.dart';
import 'package:literaphile/screens/admin_page/wish_req.dart';
import 'package:literaphile/widgets/admin_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AdminPage extends StatefulWidget {
    const AdminPage({Key? key}) : super(key: key);

    @override
    State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int numberOfBooks = 0;

  Future<void> fetchBooks() async {
    final response = await http.get(Uri.parse('https://literaphile-f07-tk.pbp.cs.ui.ac.id/administrator/get-allbooks-mobile/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> booksList = jsonDecode(jsonData['books']);

      // Get the number of books
      setState(() {
        numberOfBooks = booksList.length;
      });

      // debugPrint('Number of books: $numberOfBooks');

    } else {
      print('Failed to fetch books. Error: ${response.statusCode}');
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
        )
      ),

      body: Container(
        margin: const EdgeInsets.only(top: 15.0),
        child: Center(
          child: Column(
            children: <Widget>[
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: TweenAnimationBuilder<int>(
                  duration: const Duration(milliseconds: 500),
                  tween: IntTween(begin: 0, end: numberOfBooks),
                  builder: (BuildContext context, int value, Widget? child) {
                    return Stack(
                      children: [

                        Container(
                          width: double.infinity,
                          height: 200.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://img-cdn.inc.com/image/upload/w_1024,h_576,c_fill/images/panoramic/GettyImages-900301626_437925_t2i3bm.jpg',
                                // Replace with your image path
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Container(
                          width: double.infinity,
                          height: 200.0,
                          color: Colors.black.withOpacity(0.75), // Dark shade overlay
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Database memiliki',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                  ),
                                ),

                                const SizedBox(height: 10), // Spacer between texts

                                Text(
                                  '$value Buku',
                                  style: const TextStyle(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              const Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'What do you want to do?',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                padding: const EdgeInsets.all(16.0),
                children: [

                  ElevatedButton(
                    onPressed: () {
                      // Functionality for 'See Users' button
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const UsersPage()),
                        (route) => false
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      backgroundColor: const Color(0xFFB0BEC5)
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_search,
                          size: 32.0,
                          color: Colors.black,
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'See Users',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      // Functionality for 'Wishlist Requests' button
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const WishlistRequest()),
                        (route) => false
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      backgroundColor: const Color(0xFFB0BEC5)
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bookmark_add,
                          size: 32.0,
                          color: Colors.black,
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Wishlist Requests',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                ],
              ),

              ElevatedButton(
                onPressed: () {
                  // Functionality for 'Manage Books' button
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const ManageBooks()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.only(
                    top: 65.0,
                    bottom: 65.0,
                    left: 35.0,
                    right: 35.0
                  ),
                  backgroundColor: const Color(0xFFB0BEC5)
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.library_books,
                      size: 32.0,
                      color: Colors.black,
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Manage Books',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      
      // DRAWER BUTTON
      floatingActionButton: Ink(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const SizedBox(
        height: 50.0,
      ),
    
    );
  }
}