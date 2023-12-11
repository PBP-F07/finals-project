import 'package:flutter/material.dart';
import 'package:literaphile/screens/landingPage/rightDrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:literaphile/models/books.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  List<Books> bookList = [];

  Future<List<Books>> fetchBooks() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'http://localhost:8000/get_books/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Books> list_books = [];
    for (var d in data) {
        if (d != null) {
            list_books.add(Books.fromJson(d));
            bookList.add(Books.fromJson(d));
        }
    }
    return list_books;
  }

  @override
  Widget build(BuildContext context) {

    // double screenWidth = MediaQuery.of(context).size.width;
    // int axisCount;

    // if(screenWidth < 750) {
    //   axisCount = 2;
    //   if(screenWidth < 500) {
    //     axisCount = 1;
    //   }
    // } else {
    //   axisCount = 3;
    // }

    // final List<BookItem> books = [
    //   BookItem("Lihat Produk", Icons.checklist),
    //   BookItem("Tambah Produk", Icons.add_shopping_cart),
    //   BookItem("Logout", Icons.logout),
    // ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("LiteraPhile"),
      ),
      endDrawer: const RightDrawer(),
      body: Column(
        children: [
          const Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
              child: Column(
                children: [
                  Text(
                    "LiteraPhile",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Fasilkom's #1 Book Lending App",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              )
            ),
            Expanded(
              child: FutureBuilder(
                future: fetchBooks(), 
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                      if (!snapshot.hasData) {
                      return const Column(
                          children: [
                          Text(
                              "Tidak ada data item.",
                              style:
                                  TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                          ),
                          SizedBox(height: 8),
                          ],
                      );
                  } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => Card(
                            child: InkWell(
                              onTap: () {
                                // Navigator.push(context, 
                                //     MaterialPageRoute(builder: (context) => ));
                              },
                              child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [ Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                "${snapshot.data![index].fields.title}",
                                                style: const TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                "${snapshot.data![index].fields.author}"),
                                                const SizedBox(height: 10),
                                                Text(
                                                "${snapshot.data![index].fields.description}"
                                                )
                                              ]
                                            ),
                                          
                                        ],
                                    ),
                                )),
                            )
                          ); 
                      }
                  }
                }
              ),
            )
        ],
        )
      
      
      // SingleChildScrollView(  
      //   child: Padding(
      //     padding: const EdgeInsets.all(10.0),
      //     child: Column(
      //       children: <Widget>[
      //         const Padding(
      //           padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
      //           child: Column(
      //             children: [
      //               Text(
      //                 "LiteraPhile",
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                   fontSize: 30,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //               SizedBox(height: 20),
      //               Text(
      //                 "Fasilkom's #1 Book Lending App",
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                   fontSize: 15,
      //                   fontWeight: FontWeight.normal,
      //                 ),
      //               ),
      //               SizedBox(height: 50),
      //             ],
      //           )
      //         ),

              // GridView.count(
              //   // Container pada card kita.
              //   primary: true,
              //   padding: const EdgeInsets.all(20),
              //   crossAxisSpacing: 10,
              //   mainAxisSpacing: 10,
              //   crossAxisCount: axisCount,
              //   shrinkWrap: true,
              //   children: books.map((BookItem book) {
              //     // Iterasi untuk setiap item
              //     return BookCard(book);
              //   }).toList(),
              // ),
              
          
        );
  }
}

class BookItem {
  final String name;
  final IconData icon;

  BookItem(this.name, this.icon);
}

class BookCard extends StatelessWidget {
  final BookItem book;

  const BookCard(this.book, {super.key}); // Constructor

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
                content: Text("Kamu telah menekan tombol ${book.name}!")));
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  book.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  book.name,
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
