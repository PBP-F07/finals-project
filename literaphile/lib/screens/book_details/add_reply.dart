import 'package:flutter/material.dart';
import 'package:literaphile/models/reply.dart';
import 'package:literaphile/screens/book_details/discussion.dart';
import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:literaphile/models/discussion.dart';
import 'package:literaphile/screens/book_details/reply.dart';


class AddReply extends StatefulWidget {
  final Discussion discussion;

  const AddReply({super.key, required this.discussion});

  @override
  State<AddReply> createState() => _AddReplyState();
}

class _AddReplyState extends State<AddReply> {
  final _formKey = GlobalKey<FormState>();
  String _reply = "";
  late Discussion discussion;
  DateTime _dateAdded = DateTime.now();

  @override
  void initState() {
    super.initState();
    discussion = widget.discussion;

  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Reply',
          ),

        ),
        backgroundColor: const Color(0xFF3066BE),
        foregroundColor: const Color(0xFFFBFFF1) ,

      ),
      backgroundColor: const Color(0xFFB4C5E4),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Masukkan reply diskusi baru",
                      labelText: "Reply",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      filled: true,
                      fillColor: const Color(0xfffbfff1),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _reply = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Discussion tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF090C9B)),
                      ),

                      onPressed: () async {

                        if (_formKey.currentState!.validate()) {
                          _dateAdded = DateTime.now();

                          var url = 'https://literaphile-f07-tk.pbp.cs.ui.ac.id/details/create-reply-flutter/${discussion.pk.toString()}';

                          final response = await request.postJson(
                            url,
                            jsonEncode(<String, String>{
                              'replies': _reply,
                            }),
                          );

                          if (response['status'] == 'success') {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Reply baru berhasil disimpan!"),
                            ));
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) =>
                                    ReplyPage(discussionId: discussion.pk, discussion: discussion)));
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                  content:
                                  Text("Terdapat kesalahan, silakan coba lagi."),
                            ));
                          }

                          // ignore: use_build_context_synchronously
                          showDialog(
                              context: context,
                              builder: (context) {
                                return  const AlertDialog(
                                  title: Text('Reply berhasil tersimpan'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('Terima kasih!'),
                                      ],
                                    ),
                                  ),
                                );
                              }
                          );
                          _formKey.currentState!.reset();
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}