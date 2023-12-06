import 'package:flutter/material.dart';
// import 'package:literaphile/screens/wishlist_page/


import 'package:literaphile/screens/wishlist_page/wishlist-main.dart';
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final List<LiteraphileItem> items = [
    LiteraphileItem("Daftar Buku", Icons.book),
    LiteraphileItem("Wishlist", Icons.list_alt),
    LiteraphileItem("User Dashboard", Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text(
          'Literaphile',
          style: TextStyle(color: Colors.white), // Set font color to white
        ),
        backgroundColor: const Color.fromARGB(255, 1, 40, 73), // Set background color to blue
      ),
      body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(
            'Selamat Datang Kembali! Pilih menu yang kamu butuhkan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Column(
            children: items.map((LiteraphileItem item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("You pressed ${item.feature}!"),
                    ));
                    if (item.feature == "Wishlist") {
                      Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const WishlistPage()));
                    }
                  },
                  icon: Icon(item.icon),
                  label: Text(item.feature),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  ),
),

    );
  }
}


class LiteraphileItem {
  final String feature;
  final IconData icon;

  LiteraphileItem(this.feature, this.icon);
}

class LiteraphileCard extends StatelessWidget {
  final LiteraphileItem item;

  const LiteraphileCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.indigo,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.feature}!")));
                if (item.feature == "Wishlist Page") {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const ()));
            }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.feature,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}