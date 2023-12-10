import 'package:flutter/material.dart';
import 'package:literaphile/widgets/admin_drawer.dart';

class AdminPage extends StatefulWidget {
    const AdminPage({Key? key}) : super(key: key);

    @override
    State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0.0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(width: 10.0),

            Icon(
              Icons.book,
              size: 32.0,
            ),

            SizedBox(width: 10.0),

            Text(
              'LiteraPhile',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        )
      ),

      body: Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                width: 300.0,
                height: 150.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Center(
                  child: Text(
                    'X Books',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
      // DRAWER BUTTON
      floatingActionButton: Ink(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const SizedBox(
        height: 50.0,
      ),
    
    );
  }
}