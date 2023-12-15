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

  void _deleteProduct(int productId) async {
  try {
    final response = await http.delete(
      Uri.parse('https://literaphile-f07-tk.pbp.cs.ui.ac.id/wishlist/delete-flutter/$productId/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

   if (response.statusCode == 204) {
      // Produk berhasil dihapus
      // Lakukan apa pun yang diperlukan, seperti memperbarui tampilan
      setState(() {});} else {
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
        title: const Text('Literaphile'),
        backgroundColor: const Color.fromARGB(255, 181, 63, 126),
        foregroundColor: Color.fromARGB(255, 131, 15, 15),
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
            child: Text('Tambahkan Wishlist'),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchProduct(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return const Column(
                      children: [
                        Text(
                          "Tidak ada data produk.",
                          style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
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
          // Menambahkan gambar dari URL
          Image.network(
            "${snapshot.data![index].fields.image}",
            // width: 100, // Atur lebar gambar sesuai kebutuhan
            // height: 100, // Atur tinggi gambar sesuai kebutuhan
            // fit: BoxFit.cover, // Sesuaikan metode penyesuaian gambar
          ),
          const SizedBox(height: 10),
          Text("${snapshot.data![index].fields.description}"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _deleteProduct(snapshot.data![index].pk); // Panggil fungsi hapus produk dengan ID tertentu
            },
            child: Text('Hapus'),
          ),
        ],
      ),
    ),
  ),
);       

                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  
}
