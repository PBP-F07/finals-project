 import 'package:flutter/material.dart';
import 'package:literaphile/screens/menu.dart';
import 'package:literaphile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:literaphile/models/wishlist.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/searchwishlist.dart';

class AddWishlistPage extends StatefulWidget {
  const AddWishlistPage({super.key});

  @override
  State<AddWishlistPage> createState() => _AddWishlistPageState();
}

class _AddWishlistPageState extends State<AddWishlistPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _input = '';
  String _author = '';
  String _description = '';
  String _selectedBookTitle = '';
  List<String> _bookTitles = [];
  List<String> list_img = [];
  Map<SearchWishlist, String> _wishlistToImageUrlMap = {};

  Future<List<SearchWishlist>> searchBooks(String searchQuery) async {
  String GOOGLE_BOOKS_API_KEY = 'AIzaSyDX3PLT7tAjUA0-ZLaSsfKVi1yS_CRp4PI';
  String apiUrl =
      'https://www.googleapis.com/books/v1/volumes?q=$searchQuery&key=$GOOGLE_BOOKS_API_KEY&maxResults=10';

  var response = await http.get(Uri.parse(apiUrl));
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  List<SearchWishlist> list_product = [];
  List<String> list_imgTemp = [];
  

  // Check if data is a list and not empty
  if (data['items'] != null) {
    for (var d in data['items']) {
      if (d != null) {
         if (!_bookTitles.contains(d['volumeInfo']['title'])) {
         SearchWishlist wishlistItemOption = SearchWishlist.fromJson(d);
        list_product.add(wishlistItemOption);
        // Add image URL to the list_img if available
      String imageUrl;
      if (d['volumeInfo'] != null && d['volumeInfo']['imageLinks'] != null) {
  imageUrl = d['volumeInfo']['imageLinks']['thumbnail'] ?? '';
} else {
  // Default image URL if 'imageLinks' or 'thumbnail' is not available
  imageUrl = 'https://s3.amazonaws.com/media.muckrack.com/profile/images/317132/loudmouthjulia.jpeg.256x256_q100_crop-smart.jpg';
}
      list_imgTemp.add(imageUrl);
      // Add to the map if both title and imageUrl exist
      
         }
        if (list_product.length >= 15){
          break;
        }
      }
    }
  }
  list_img = list_imgTemp;
  print(list_product);
  return list_product;
}

TextEditingController _searchController = TextEditingController();
  List<SearchWishlist> _searchResults = [];

  Future<void> _searchBooks() async {
    String searchQuery = _searchController.text;
    List<SearchWishlist> results = await searchBooks(searchQuery);
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search books',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchBooks,
                ),
              ),
            ),
            SizedBox(height: 20),
             Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_searchResults[index].volumeInfo.title),
                    subtitle: Text(_searchResults[index].volumeInfo.authors.join(', ')),
                    trailing: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () async {
  final response = await request.postJson(
    "https://literaphile-f07-tk.pbp.cs.ui.ac.id/wishlist/create-flutter/",
    jsonEncode(<String, String>{
      'title': _searchResults[index].volumeInfo.title,
      'author': _searchResults[index].volumeInfo.authors.join(','),
      'description': "",
      'image': list_img[index],
      'year_of_release': "",
      // TODO: Sesuaikan field data sesuai dengan aplikasimu
    }),
  );
  
  if (response['status'] == 'success') {
    // _searchResults.remove(_searchResults[index-1]);
    // list_img.remove(list_img[index-1]);
    _bookTitles.add(_searchResults[index].volumeInfo.title);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      
      content: Text("Produk baru berhasil disimpan!"),
    ));

    // Hapus produk dari _searchResults
    setState(() {
      _searchBooks();
      // _searchResults.removeAt(index);
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Terdapat kesalahan, silakan coba lagi."),
    ));
  }
},

                                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  }
