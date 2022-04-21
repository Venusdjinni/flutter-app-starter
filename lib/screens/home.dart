import 'package:flutter/material.dart';
import 'package:flutter_app_starter/widgets/item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
      ),
      body: ListView.separated(
        itemBuilder: (_, i) => const ItemWidget(),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: 10,
      ),
    );
  }
}
