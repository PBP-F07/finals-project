import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:literaphile/models/wishlist.dart';
import 'dart:convert';
import 'package:literaphile/widgets/admin_drawer.dart';


class WishlistRequest extends StatefulWidget {
    const WishlistRequest({Key? key}) : super(key: key);

    @override
    State<WishlistRequest> createState() => _WishlistRequestState();
}

class _WishlistRequestState extends State<WishlistRequest> {
  List<Wishlist> wishlistItems = [];
  bool isPressed = false;

  Future<void> fetchWishlistItems() async {
    final response = await http.get(Uri.parse('http://localhost:8000/administrator/get-wishlist-mobile/'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final String wishlistJson = jsonData['wishlist'];

      final List<dynamic> wishlistData = jsonDecode(wishlistJson);

      setState(() {
        wishlistItems = wishlistFromJson(jsonEncode(wishlistData));
      });

    } else {
      print('Failed to fetch wishlist items: ${response.statusCode}');
    }
  }

  Future<void> rejectWishlistItem(int id) async {
    final url = Uri.parse('http://localhost:8000/administrator/reject-wishlist/$id');
    
    try {
      final response = await http.delete(url);
      
      if (response.statusCode == 200) {
        // debugPrint('Wishlist item rejected successfully');
        await fetchWishlistItems();
      } else {
        print('Failed to reject wishlist item: ${response.statusCode}');
      }
    } catch (error) {
      print('Error rejecting wishlist item: $error');
    }
  }

  Future<void> addToCatalog(int id) async {
    final url = Uri.parse('http://localhost:8000/administrator/add-catalog/$id');

    try {
      final response = await http.post(url);
      
      if (response.statusCode != 200) {
        print('Failed to reject wishlist item: ${response.statusCode}');
      }
    } catch (error) {
      print('Error rejecting wishlist item: $error');
    }

    rejectWishlistItem(id);
  }

  @override
  void initState() {
    fetchWishlistItems();
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
        )
      ),

      body: wishlistItems.isEmpty
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
                    'Tidak ada buku di dalam wishlist . . .',
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
                  itemCount: wishlistItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    final currentWishlist = wishlistItems[index];

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
                                // Handle first button action
                                addToCatalog(currentWishlist.pk);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Request buku "${currentWishlist.fields.title}" telah diterima!'),
                                    duration: const Duration(seconds: 3), // Duration to display the SnackBar
                                    behavior: SnackBarBehavior.floating, // Make the SnackBar floating
                                    margin: const EdgeInsets.all(16.0), // Adjust margin as needed
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0), // Optional: customize SnackBar shape
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.check_circle),
                            ),
                            IconButton(
                              onPressed: () {
                                // Handle second button action
                                rejectWishlistItem(currentWishlist.pk);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Request buku "${currentWishlist.fields.title}" telah dihapus!'),
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