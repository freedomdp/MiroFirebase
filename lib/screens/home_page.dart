import 'package:flutter/material.dart';
import 'package:miro/widgets/sidebar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Используется GlobalKey<ScaffoldState> для управления состоянием Scaffold из кода
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Smart Ship Cars'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: EmployeesSidebar(),
    );
  }
}
