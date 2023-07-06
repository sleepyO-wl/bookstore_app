import 'package:bookstore/models/books.dart';
import 'package:bookstore/utils/null_image_url.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BooksLibraryScreen extends StatefulWidget {
  const BooksLibraryScreen({
    super.key,
  });
  static List<Books> libraryBooks = [];

  static void addBookToLibrary(Books book) {
    libraryBooks.add(book);
  }

  @override
  State<BooksLibraryScreen> createState() => _BooksLibraryScreenState();
}

class _BooksLibraryScreenState extends State<BooksLibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        itemCount: BooksLibraryScreen.libraryBooks.length,
        itemBuilder: (context, index) {
          final libraryBooks = BooksLibraryScreen.libraryBooks;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: Image.network(
                  libraryBooks[index].thumbnailUrl ?? nullImage,
                  height: 160,
                  width: 120,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 12),
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      libraryBooks[index].title!,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Book by ${libraryBooks[index].authors.toString()}',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Price: ${libraryBooks[index].pageCount}',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Book id ${libraryBooks[index].id.toString()}',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
