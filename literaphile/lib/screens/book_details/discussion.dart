import 'package:literaphile/models/discussion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiscussionPage extends StatefulWidget {
  final int bookId;

  const DiscussionPage({Key? key, required this.bookId}) : super(key: key);

  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  late String id;
  double fem = 1.0; // Define the 'fem' factor

  @override
  void initState() {
    super.initState();
    id = widget.bookId.toString();
  }

  Future<List<Discussion>> fetchProduct() async {
    var urlAwal = 'http://localhost:8000/details/discussion/$id/json/';
    var url = Uri.parse(urlAwal);
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Discussion> list_product = [];
    for (var d in data) {
      if (d != null) {
        list_product.add(Discussion.fromJson(d));
      }
    }
    return list_product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product'),
        ),
        backgroundColor: const Color(0xffb4c5e4),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data diskusi.",
                        style:
                        TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        if("${snapshot.data![index].fields.user}" == "zaim1"){
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: double.infinity,
                                    height: 130 * fem,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10 * fem),
                                      border: Border.all(color: Color(0xff3c3744)),
                                      color: Color(0xfffbfff1),
                                    ),
                                    child:Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              width: 30,
                                              height: 30,
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${snapshot.data![index].fields.user}",
                                                  style: const TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${snapshot.data![index].fields.comment}",
                                                  style: const TextStyle(
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text("${snapshot.data![index].fields.dateAdded}",
                                                  style: const TextStyle(
                                                    fontSize: 10.0,
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all(const Color(0xFF090C9B)),
                                              ),
                                              child: const Text("Reply",
                                                style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onPressed: (){},
                                            ),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all(const Color(0xFF090C9B)),
                                              ),
                                              child: const Text("Delete",
                                                style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onPressed: (){},
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: double.infinity,
                                    height: 130 * fem,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10 * fem),
                                      border: Border.all(color: Color(0xff3c3744)),
                                      color: Color(0xfffbfff1),
                                    ),
                                    child:Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              width: 30,
                                              height: 30,
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${snapshot.data![index].fields.user}",
                                                  style: const TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${snapshot.data![index].fields.comment}",
                                                  style: const TextStyle(
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text("${snapshot.data![index].fields.dateAdded}",
                                                  style: const TextStyle(
                                                    fontSize: 10.0,
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all(const Color(0xFF090C9B)),
                                              ),
                                              child: const Text("Reply",
                                                style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onPressed: (){},
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            ),
                          );
                        }

                      }
                  );
                }
              }
            }));
  }
}
