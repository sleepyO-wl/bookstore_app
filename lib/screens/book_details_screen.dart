import 'package:bookstore/models/books.dart';
import 'package:bookstore/provider/books_provider.dart';
import 'package:bookstore/screens/bag_screen.dart';
import 'package:bookstore/screens/book_description_screen.dart';
import 'package:bookstore/screens/books_library_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookDetailsScreen extends StatelessWidget {
  final String bookId;

  BookDetailsScreen({
    super.key,
    required this.bookId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<Books>(
        future: BooksRepository().getBookById(bookId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Books book = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 16.0, top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            book.thumbnailUrl!,
                            height: 180,
                            width: 120,
                            fit: BoxFit.fill,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 12),
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        fontSize: 30,
                                      ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: book.authors!.length,
                                  itemBuilder: (context, index) => Text(
                                    book.authors![index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Published ${DateFormat.yMMMMd().format(book.publishedDate!)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              BooksLibraryScreen.addBookToLibrary(book);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text('Book added to library')),
                              );
                            },
                            icon: const Icon(Icons.library_add),
                            label: const Text('Add to library'),
                            style: const ButtonStyle(
                                // shape: MaterialStatePropertyAll(
                                //   BeveledRectangleBorder(
                                //     borderRadius: BorderRadius.horizontal(
                                //         left: Radius.zero),
                                //   ),
                                // // ),
                                // visualDensity: VisualDensity.compact,
                                // elevation: MaterialStatePropertyAll(5)
                                ),
                          ),
                          ElevatedButton.icon(
                              onPressed: () {
                                BagScreen.addBookToBag(book);
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text('Book added to bag')),
                                );
                              },
                              icon: const Icon(Icons.shopping_bag),
                              label: const Text('Add to bag')),
                        ],
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BookDescriptionScreen(
                              title: book.title!,
                              description: book.longDescription ??
                                  book.shortDescription!),
                        )),
                        child: Container(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  'About this book',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                ),
                                trailing: const Icon(Icons.arrow_forward),
                              ),
                              Text(
                                book.longDescription ?? book.shortDescription!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14),
                                maxLines: 7,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      // Text('Pages'),
                      Text(
                        'Pages: ${book.pageCount}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ],
                  )),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading book details'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
