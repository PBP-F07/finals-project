import 'package:flutter/material.dart';
import 'package:literaphile/models/wishlist.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:literaphile/models/product.dart';
// import 'package:shopping_list/widgets/left_drawer.dart';

class WishlistPage extends StatefulWidget {
    const WishlistPage({Key? key}) : super(key: key);

    @override
    _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
Future<List<Wishlist>> fetchProduct() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    // print("test");
    var url = Uri.parse(
        'http://localhost:8000/wishlist/json/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );
    // print("atets");

    // // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    // print(data);

    // // melakukan konversi data json menjadi object Product
    List<Wishlist> listWishlist = [];
    for (var d in data) {
        if (d != null) {
            listWishlist.add(Wishlist.fromJson(d));
        }
    }
    // print(list_product);
    return listWishlist;
}

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Your Wishlist'),
        ),
        // drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
        //       print(snapshot.data);
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return const Column(
                        children: [
                        Text(
                            "Tidak ada data produk.",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
                } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                    "${snapshot.data![index].fields.title}",
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text("${snapshot.data![index].fields.author}"),
                                    const SizedBox(height: 10),
                                    Text(
                                        "${snapshot.data![index].fields.description}")
                                ],
                                ),
                            ));
                    }
                }
            })
        );
    }
}
