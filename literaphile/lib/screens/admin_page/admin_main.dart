import 'package:flutter/material.dart';
import 'package:literaphile/widgets/admin_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:literaphile/models/books.dart';

class AdminPage extends StatefulWidget {
    const AdminPage({Key? key}) : super(key: key);

    @override
    State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  Future<List<Book>> fetchBooks() async {
    final request = context.watch<CookieRequest>();
    var response = await request.get('https://literaphile-f07-tk.pbp.cs.ui.ac.id/get_books/');
    var books = response;

    List<Book> listBooks = [];
    for (var b in books) {
      if (b != null) {
        listBooks.add(Book.fromJson(b));
      }
    }
    return listBooks;
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
                  tween: IntTween(begin: 0, end: 100),
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
                          color: Colors.black.withOpacity(0.5), // Dark shade overlay
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'The database has',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white,
                                  ),
                                ),

                                const SizedBox(height: 10), // Spacer between texts

                                Text(
                                  '$value Books',
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
                padding: const EdgeInsets.all(16.0),
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                children: [

                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for the first button
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_search,
                          size: 32.0,
                        ),

                        SizedBox(width: 5.0),

                        Text(
                          'See Users',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for the second button
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bookmark_add,
                          size: 32.0,
                        ),

                        SizedBox(width: 5.0),

                        Text(
                          'Wishlist Requests',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for the third button
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.library_books,
                          size: 32.0,
                        ),

                        SizedBox(width: 5.0),

                        Text(
                          'Manage Books',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for the fourth button
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notes,
                          size: 32.0,
                        ),

                        SizedBox(width: 5.0),

                        Text(
                          'User Notes',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  
                ],
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