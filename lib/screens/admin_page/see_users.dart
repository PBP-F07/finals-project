import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:literaphile/widgets/admin_drawer.dart';


class UsersPage extends StatefulWidget {
    const UsersPage({Key? key}) : super(key: key);

    @override
    State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  List<Map<String, dynamic>> usersData = [];
  bool isPressed = false;

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://literaphile-f07-tk.pbp.cs.ui.ac.id/administrator/get-allusers/'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> users = data['users'];

      setState(() {
        usersData = List<Map<String, dynamic>>.from(users);
      });
    } else {
      print('Failed to fetch users. Error: ${response.statusCode}');
    }

    return usersData;
  }

  @override
  void initState() {
    super.initState();
    fetchUsers().then((users) {
      setState(() {
        usersData = users;
      });
    }).catchError((error) {
      print('Error fetching data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Users Page'),
      // ),

      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0.0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(width: 10.0),

            Icon(
              Icons.settings,
              size: 32.0,
            ),

            SizedBox(width: 10.0),

            Text(
              'LiteraPhile Admin',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        )
      ),

      // body: Center(
      //   child: SingleChildScrollView(
      //     scrollDirection: Axis.horizontal,
      //     child: SizedBox(
      //       width: MediaQuery.of(context).size.width, // Set width to screen width
      //       child: DataTable(
      //         columns: const [
      //           DataColumn(label: Text('ID')),
      //           DataColumn(label: Text('Username')),
      //           DataColumn(label: Text('Role')),
      //         ],
      //         rows: usersData.map((userData) {
      //           return DataRow(cells: [
      //             DataCell(Text('${userData['id']}')),
      //             DataCell(Text(userData['username'] ?? 'N/A')),
      //             DataCell(Text(userData['role'] ?? 'N/A')),
      //           ]);
      //         }).toList(),
      //       ),
      //     ),
      //   ),
      // ),

      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Username')),
              DataColumn(label: Text('Role')),
            ],
            rows: usersData.map((userData) {
              return DataRow(cells: [
                DataCell(Text('${userData['id']}')),
                DataCell(Text(userData['username'] ?? 'N/A')),
                DataCell(Text(userData['role'] ?? 'N/A')),
              ]);
            }).toList(),
          ),
        ),
      ),


      // DRAWER BUTTON
      floatingActionButton: GestureDetector(
        onTapDown: (_) {
          setState(() {
            isPressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            isPressed = false;
          });
        },

        child: AnimatedOpacity(
          opacity: isPressed ? 1.0 : 0.5,
          duration: const Duration(milliseconds: 300),
          child: Ink(
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: CircleBorder(),
            ),
            child: FloatingActionButton(
              onPressed: () {

                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const AdminDrawer();
                  },
                );

                Future.delayed(const Duration(milliseconds: 200), () {
                  setState(() {
                    isPressed = false;
                  });
                });
              },

              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Icon(Icons.arrow_upward),
            ),
          )
            
        ),
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const SizedBox(
        height: 50.0,
      ),
    );

  }
}


