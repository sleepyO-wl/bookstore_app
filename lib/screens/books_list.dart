import 'package:flutter/material.dart';

import 'package:bookstore/models/books.dart';

class BooksListScreen extends StatelessWidget {
  const BooksListScreen(
      {super.key, required this.books, required this.category});

  final List<Books> books;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        shadowColor: null,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: GridView.builder(
          padding:
              const EdgeInsets.only(top: 16, left: 10, right: 10, bottom: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.62,
              crossAxisSpacing: 10,
              mainAxisSpacing: 14),
          itemCount: books.length,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              height: 260,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      books[index].thumbnailUrl!,
                      fit: BoxFit.cover,
                      height: 200,
                      width: 180,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    books[index].title!,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  Text(
                    'Price: ₹${books[index].pageCount}',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
