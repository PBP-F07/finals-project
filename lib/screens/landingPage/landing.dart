import 'package:flutter/material.dart';
import 'package:literaphile/screens/landingPage/rightDrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:literaphile/models/books.dart';
import 'package:literaphile/screens/wishlist_page/wishlist.dart';
import 'package:literaphile/widgets/left_drawer.dart';
import 'package:literaphile/screens/book_details/book_details.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<Book> listBooks = [];

  @override
  void initState() {
    super.initState();
    // Fetch initial data when the widget is inserted into the tree
    updateBooks("");
  }

  void updateBooks(String searchTitle) async {
    List<Book> books = await fetchBooks(searchTitle);
    setState(() {
      listBooks = books;
    });
  }

  Future<List<Book>> fetchBooks(String searchTitle) async {
    var url =
        Uri.parse('https://literaphile-f07-tk.pbp.cs.ui.ac.id/get_books/');

    if (searchTitle.isNotEmpty) {
      url = Uri.parse(
          'https://literaphile-f07-tk.pbp.cs.ui.ac.id/?search_title=$searchTitle');
    }

    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product

    List<Book> listBooksMain = [];
    for (var d in data) {
      if (d != null) {
        listBooksMain.add(Book.fromJson(d));
      }
    }
    return listBooksMain;
  }

  void _borrowBook(int productId) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://literaphile-f07-tk.pbp.cs.ui.ac.id/borrow_book_flutter/$productId/'),
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
  Widget build(BuildContext context) {
    String searchName = "";
    double screenWidth = MediaQuery.of(context).size.width;
    int axisCount;

    if (screenWidth < 980) {
      axisCount = 2;

      if (screenWidth < 700) {
        axisCount = 1;
      }
    } else {
      axisCount = 3;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "LiteraPhile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        drawer: const LeftDrawer(),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
                child: Column(
                  children: [
                    const Text(
                      "LiteraPhile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Fasilkom's #1 Book Lending App",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: screenWidth - (screenWidth / 2) - 20,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WishlistPage()),
                                );
                              },
                              child: const Text(
                                "Tambahkan Wishlist",
                                textAlign: TextAlign.center,
                              )),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: screenWidth - (screenWidth / 2) - 20,
                          child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      margin: const EdgeInsets.all(25.0),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      width:
                                          MediaQuery.of(context).size.width * 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text(
                                            "About",
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Text(
                                            "Kami kelompok PBP F07 dengan anggota : Vincent, Julian, Evan, Zaim, dan Dien",
                                          ),
                                          ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("Close")),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text("About")),
                        )
                      ],
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: screenWidth - (screenWidth / 4),
                      child: TextField(
                        onChanged: (value) async => updateBooks(value),
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Search",
                          prefixIcon: const Icon(Icons.search),
                          prefixIconColor: Colors.grey.shade800,
                        ),
                      ),
                    )
                  ],
                )),
            Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: axisCount,
                    ),
                    itemCount: listBooks.length,
                    itemBuilder: (context, index) => Container(
                          width: screenWidth / axisCount,
                          height: screenWidth / axisCount,
                          margin: const EdgeInsets.all(5.0),
                          child: Card(
                            child: InkWell(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        margin: const EdgeInsets.all(25.0),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Text(
                                                    listBooks[index]
                                                        .fields
                                                        .description,
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Available : ${listBooks[index].fields.amount}",
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                                const SizedBox(width: 10),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    _borrowBook(
                                                        listBooks[index].pk);
                                                  },
                                                  child: const Text("Pinjam"),
                                                ),
                                              ],
                                            ),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color(
                                                            0xFF090C9B)),
                                              ),
                                              child: const Text(
                                                "Discussion",
                                                style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DiscussionPage(
                                                              bookId: listBooks[
                                                                      index]
                                                                  .pk,
                                                              book: listBooks[
                                                                  index],
                                                            )));
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    padding: const EdgeInsets.all(20.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.network(
                                                  listBooks[index].fields.image,
                                                  height: 200,
                                                  width: 300,
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  listBooks[index].fields.title,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  listBooks[index]
                                                      .fields
                                                      .author,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize:
                                                          16), // Adjust the font size as needed
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  listBooks[index]
                                                      .fields
                                                      .yearOfRelease,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize:
                                                          16), // Adjust the font size as needed
                                                ),
                                                const SizedBox(height: 10),
                                              ]),
                                        ],
                                      ),
                                    ))),
                          ),
                        ))),
          ],
        ));
  }
}
