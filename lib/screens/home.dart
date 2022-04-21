import 'package:flutter/material.dart';
import 'package:flutter_app_starter/requests/datamanager.dart';
import 'package:flutter_app_starter/widgets/item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String _homeNotifierKey = "HOME_NOTIFIER_KEY";

  @override
  void initState() {
    super.initState();
    /// register to a change notifier. Wherever notifier.[notifyListener] is
    /// called, all the registered methods will be fired
    DataManager.notifier.addListener(_homeNotifierKey, refresh);
  }

  void refresh() {
    if (this.mounted) {
      // event happened. Refresh data
      setState(() {

      });
    }
  }

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

  @override
  void dispose() {
    /// cancel subscription to notifier when disposed
    DataManager.notifier.removeListeners(_homeNotifierKey, refresh);
    super.dispose();
  }
}
