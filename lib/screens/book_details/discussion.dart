import 'package:literaphile/models/reply.dart';
import 'package:literaphile/models/discussion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:literaphile/screens/book_details/add_reply.dart';
import 'package:literaphile/screens/book_details/reply.dart';

class ReplyPage extends StatefulWidget {
  final int discussionId;
  final Discussion discussion;


  const ReplyPage({Key? key, required this.discussionId, required this.discussion}) : super(key: key);

  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  late String id;
  late Discussion discussion;

  double fem = 1.0; // Define the 'fem' factor

  @override
  void initState() {
    super.initState();
    id = widget.discussionId.toString();
    discussion = widget.discussion;

  }

  Future<List<Reply>> fetchProduct() async {
    var urlAwal = 'https://literaphile-f07-tk.pbp.cs.ui.ac.id/details/replies/$id/json/';
    var url = Uri.parse(urlAwal);
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Reply> list_reply = [];
    for (var d in data) {
      if (d != null) {
        list_reply.add(Reply.fromJson(d));
      }
    }
    return list_reply;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discussion'),
        backgroundColor: const Color(0xFF3066BE),
        foregroundColor: const Color(0xFFFBFFF1) ,
      ),
      backgroundColor: const Color(0xffb4c5e4),
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
                  Text(discussion.fields.user,
                    style: const TextStyle(
                      color: Color(0xFF3C3744),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(discussion.fields.comment,
                    style: const TextStyle(
                      color: Color(0xFF3C3744),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(discussion.fields.dateAdded,
                    style: const TextStyle(
                      color: Color(0xFF3C3744),
                      fontSize: 10,
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
            child: const Text("Reply",
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.white,
              ),
            ),
            onPressed: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) =>
                      AddReply(discussion: discussion)));
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
                          "Tidak ada data Reply.",
                          style:
                          TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics:const NeverScrollableScrollPhysics() ,
                        itemCount: snapshot.data!.length,
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
                                                    softWrap: true,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${snapshot.data![index].fields.replies}",
                                                    style: const TextStyle(
                                                      fontSize: 15.0,
                                                    ),
                                                    softWrap: true,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text("${snapshot.data![index].fields.dateAdd}",
                                                    style: const TextStyle(
                                                      fontSize: 10.0,
                                                    ),
                                                    softWrap: true,
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
                                                          ReplyFullPage(reply: snapshot.data![index])));
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
