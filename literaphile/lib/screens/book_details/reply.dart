import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:literaphile/screens/book_details/add_discussion.dart';
import 'package:literaphile/models/reply.dart';


class ReplyFullPage extends StatefulWidget {
  final Reply reply;

  const ReplyFullPage({Key? key, required this.reply}) : super(key: key);

  @override
  _ReplyFullPageState createState() => _ReplyFullPageState();
}

class _ReplyFullPageState extends State<ReplyFullPage> {
  late String id;
  late Reply reply;
  double fem = 1.0; // Define the 'fem' factor

  @override
  void initState() {
    super.initState();
    reply = widget.reply;

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
                  Text(reply.fields.user,
                    style: const TextStyle(
                      color: Color(0xFF3C3744),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(reply.fields.replies,
                    style: const TextStyle(
                      color: Color(0xFF3C3744),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(reply.fields.dateAdd,
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
          const SizedBox(
            width: 10,
            height: 10,),
        ],),
      ),
    );
  }
}
