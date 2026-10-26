import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({
    super.key,
    required this.heading,
    required this.detailRouteName,
  });

  final String heading;
  final String detailRouteName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Books'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              heading,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          for (var i = 0; i < 4; i++)
            Card(
              child: ListTile(
                title: const Text('Da Vinci Code'),
                subtitle: const Text('Dan Brown'),
                onTap: () => context.goNamed(detailRouteName),
              ),
            ),
        ],
      ),
    );
  }
}
