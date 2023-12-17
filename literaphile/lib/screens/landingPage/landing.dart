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
  
  List<Books> listBooks = [];

  @override
  void initState() {
    super.initState();
    // Fetch initial data when the widget is inserted into the tree
    updateBooks("");
  }

  void updateBooks(String searchTitle) async {
    List<Books> books = await fetchBooks(searchTitle);
    setState(() {
      listBooks = books;
    });
  }

  Future<List<Books>> fetchBooks(String searchTitle) async {
    var url = Uri.parse(
        'http://localhost:8000/get_books/');

    if (searchTitle.isNotEmpty) {
      url = Uri.parse('http://localhost:8000/search_books_static/?search_title=$searchTitle');
    } 

    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    
    List<Books> listBooksMain = [];
    for (var d in data) {
        if (d != null) {
            listBooksMain.add(Books.fromJson(d));
        }
    }
    return listBooksMain;
  }

  @override
  Widget build(BuildContext context) {

    String searchName = "";
    double screenWidth = MediaQuery.of(context).size.width;
    int axisCount;

    if(screenWidth < 980) {
      axisCount = 2;

      if(screenWidth < 700) {
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
      endDrawer: const RightDrawer(),
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
                    children: <Widget> [
                      SizedBox(
                        width: screenWidth - (screenWidth / 2) - 20,
                        child: ElevatedButton(
                          onPressed: () {}, 
                          child: const Text("Tambahkan Wishlist", textAlign: TextAlign.center,)
                        ),
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
                                  height: MediaQuery.of(context).size.height / 2,
                                  width: MediaQuery.of(context).size.width * 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                      ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Close")),
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
              )
            ),
            Expanded(
              child: FutureBuilder(
                future: fetchBooks(searchName), 
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                      if (!snapshot.hasData) {
                      return const Column(
                          children: [
                          Text(
                              "Tidak ada data buku.",
                              style:
                                  TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                          ),
                          SizedBox(height: 8),
                          ],
                      );
                  } else {
                      return GridView.builder(
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
                                      height: MediaQuery.of(context).size.height / 2,
                                      width: MediaQuery.of(context).size.width * 2,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Container(
                                                padding: const EdgeInsets.all(16),
                                                child: Text(
                                                  listBooks[index].fields.description,
                                                  style: const TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "Available : ${listBooks[index].fields.amount}",
                                                  style: const TextStyle(fontSize: 16),
                                              ),
                                              const SizedBox(width: 10),
                                              ElevatedButton(
                                                onPressed: () {},
                                                child: const Text("Pinjam"),
                                              ),
                                            ],
                                          )
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
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [ Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
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
                                                    listBooks[index].fields.author,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(fontSize: 16), // Adjust the font size as needed
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    listBooks[index].fields.yearOfRelease,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(fontSize: 16), // Adjust the font size as needed
                                                  ),
                                                  const SizedBox(height: 10),
                                                ]
                                              ),
                                          ],
                                      ),
                                    )
                                )
                              ),
                            ),
                          )
                        ); 
                      }
                  }
                }
              ),
            ),
          ],
      )
    );
  }
}
