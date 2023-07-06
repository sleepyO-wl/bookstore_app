import 'package:bookstore/models/books.dart';
import 'package:bookstore/utils/null_image_url.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BagScreen extends StatefulWidget {
  const BagScreen({
    super.key,
  });
  static List<Books> bagBooks = [];
  static var total = 0;

  static void addBookToBag(Books book) {
    bagBooks.add(book);
  }

  @override
  State<BagScreen> createState() => _BooksLibraryScreenState();
}

class _BooksLibraryScreenState extends State<BagScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        itemCount: BagScreen.bagBooks.length,
        itemBuilder: (context, index) {
          final bagBooks = BagScreen.bagBooks;

          return ListTile(
            leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(bagBooks[index].thumbnailUrl ?? nullImage)),
            title: Text(
              bagBooks[index].title!,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            subtitle: Text(
              //
              'Book by ${bagBooks[index].authors}',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            trailing: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Text(
                  '₹${bagBooks[index].pageCount!.toString()}',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                )),
          );
        },
      ),
    );
  }
}
