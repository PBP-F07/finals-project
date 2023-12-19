import 'package:flutter/material.dart';
import 'package:literaphile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:literaphile/models/dashboard.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key});

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Dashboard'),
      ),
      drawer: const LeftDrawer(),
    );
  }
}
