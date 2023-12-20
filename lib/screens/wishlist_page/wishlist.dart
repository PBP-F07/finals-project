import 'package:flutter/material.dart';
import 'package:literaphile/screens/wishlist_page/addWishlist.dart';
import 'package:literaphile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:literaphile/models/wishlist.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";

  Future<List<Wishlist>> fetchProduct() async {
    final request = context.watch<CookieRequest>();
    final response =
        await request.get('https://literaphile-f07-tk.pbp.cs.ui.ac.id/wishlist/json/');

    List<Wishlist> list_wishlist = [];
    List<String> list_imgwishlist = [];
    for (var d in response) {
      if (d != null) {
        list_wishlist.add(Wishlist.fromJson(d));
        // list_imgwishlist.add()
      }
    }
    return list_wishlist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Literaphile'),
        backgroundColor: Colors.indigo,
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      drawer: const LeftDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddWishlistPage(),
                ),
              );
            },
            child: Text('+Tambahkan Wishlist+'),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchProduct(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data == null || snapshot.data.isEmpty) {
                  return Center(
                    child: Text(
                      'Anda belum memiliki wishlist',
                      style: TextStyle(color: Colors.indigo, fontSize: 20),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${snapshot.data![index].fields.title}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center, // Center the text
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${snapshot.data![index].fields.author}",
                              textAlign: TextAlign.center, // Center the text
                            ),
                            const SizedBox(height: 10),
                            Image.network(
                              "${snapshot.data![index].fields.image}",
                            ),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.description}"),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
