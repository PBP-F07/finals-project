import 'package:literaphile/models/discussion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:literaphile/models/books.dart';
import 'package:literaphile/screens/book_details/discussion.dart';
import 'package:literaphile/screens/book_details/add_discussion.dart';
import 'package:literaphile/widgets/left_drawer.dart';

class DiscussionPage extends StatefulWidget {
  final int bookId;
  final Book book;

  const DiscussionPage({Key? key, required this.bookId, required this.book}) : super(key: key);

  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  late String id;
  late Book book;
  double fem = 1.0; // Define the 'fem' factor

  @override
  void initState() {
    super.initState();
    id = widget.bookId.toString();
    book = widget.book;

  }

  Future<List<Discussion>> fetchProduct() async {
    var urlAwal = 'https://literaphile-f07-tk.pbp.cs.ui.ac.id/details/discussion/$id/json/';
    var url = Uri.parse(urlAwal);
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Discussion> list_discussion= [];
    for (var d in data) {
      if (d != null) {
        list_discussion.add(Discussion.fromJson(d));
      }
    }
    return list_discussion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
          backgroundColor: const Color(0xFF3066BE),
          foregroundColor: const Color(0xFFFBFFF1) ,
        ),
        backgroundColor: const Color(0xffb4c5e4),
        drawer: const LeftDrawer(),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              width: 10,
              height: 10,),
            Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 0),
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                height: 400 * fem,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * fem),
                  border: Border.all(color: const Color(0xff3c3744)),
                  color: const Color(0xfffbfff1),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book.fields.title,
                        style: const TextStyle(
                          color: Color(0xFF3C3744),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            book.fields.image,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Author: ",
                            style: TextStyle(
                              color: Color(0xFF3C3744),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),

                          ),
                          Text(book.fields.author,
                            style: const TextStyle(
                              color: Color(0xFF3C3744),
                              fontSize: 15,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Published: ",
                            style: TextStyle(
                              color: Color(0xFF3C3744),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(book.fields.yearOfRelease,
                            style: const TextStyle(
                              color: Color(0xFF3C3744),
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),

                        ],
                      ),
                      const SizedBox(height: 7),
                      Text(book.fields.description,
                        style: const TextStyle(
                          color: Color(0xFF3C3744),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
            ),
            const SizedBox(
              width: 10,
              height: 10,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(const Color(0xFF090C9B)),
              ),
              child: const Text("Add Discussion",
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                ),
              ),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        AddDiscussion(book: book)));
              },
            ),
            const SizedBox(
              width: 10,
              height: 10,),
            FutureBuilder(
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
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
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

                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      constraints: const BoxConstraints(
                                                        maxWidth: 150,
                                                      ),// Set the maximum width for the text
                                                      child: Text(
                                                        "${snapshot.data![index].fields.comment}",
                                                        style: const TextStyle(
                                                          fontSize: 15.0,
                                                          height: 1.255,
                                                        ),
                                                        maxLines: 1, // Set the maximum number of lines you want to display
                                                        overflow: TextOverflow.ellipsis, // Use ellipsis (...) for overflow
                                                        softWrap: true,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text("${snapshot.data![index].fields.dateAdded}",
                                                      style: const TextStyle(
                                                        fontSize: 10.0,
                                                      ),

                                                      overflow: TextOverflow.ellipsis,
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
                                                  child: const Text("More",
                                                    style: TextStyle(
                                                      fontSize: 10.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  onPressed: (){
                                                    Navigator.push(context,
                                                        MaterialPageRoute(builder: (context) =>
                                                            ReplyPage(discussionId: snapshot.data![index].pk,
                                                                discussion:snapshot.data![index]) ));
                                                  },
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
                      );
                    }
                  }
                })
          ],),
        ),
        );
  }
}
