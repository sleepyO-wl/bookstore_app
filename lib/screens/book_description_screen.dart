import 'package:flutter/material.dart';

class BookDescriptionScreen extends StatelessWidget {
  const BookDescriptionScreen(
      {super.key, required this.description, required this.title});

  final String description;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 12, top: 14, bottom: 16),
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 16,
                ),
          ),
        ),
      ),
    );
  }
}
