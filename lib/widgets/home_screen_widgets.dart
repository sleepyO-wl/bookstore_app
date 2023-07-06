import 'package:bookstore/models/books.dart';
import 'package:bookstore/screens/books_list.dart';
import 'package:bookstore/utils/null_image_url.dart';
import 'package:flutter/material.dart';

class HomeScreenWidget extends StatelessWidget {
  final List<String> uniqueCategories;
  final List<Books> books;

  final Function(String) onBookSelected;

  const HomeScreenWidget(
      {super.key,
      required this.uniqueCategories,
      required this.books,
      required this.onBookSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: uniqueCategories.length,
      itemBuilder: (context, index) {
        String category = uniqueCategories[index];
        final categorisedBooks =
            books.where((b) => b.categories!.contains(category)).toList();
        if (category.isEmpty) {
          category = 'Not listed';
        }
        return SizedBox(
          height: 330,
          width: double.infinity,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  category,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  'Tap to view all',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 12),
                ),
                trailing: IconButton(
                    onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BooksListScreen(
                              books: categorisedBooks,
                              category: category,
                            ),
                          ),
                        ),
                    icon: const Icon(Icons.arrow_forward)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BooksListScreen(
                        books: categorisedBooks,
                        category: category,
                      ),
                    ),
                  );
                },
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsetsDirectional.only(start: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: categorisedBooks.length,
                  itemBuilder: (context, index) {
                    final book = categorisedBooks[index];
                    return SizedBox(
                      height: 280,
                      width: 170,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              onBookSelected(book.id.toString());
                            },
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Image.network(
                                book.thumbnailUrl ?? nullImage,
                                height: 200,
                                width: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            book.title!,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            '₹${book.pageCount!.toString()}',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
