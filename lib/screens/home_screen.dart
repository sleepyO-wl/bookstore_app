import 'package:bookstore/models/books.dart';
import 'package:bookstore/provider/books_provider.dart';
import 'package:bookstore/screens/book_details_screen.dart';
import 'package:bookstore/widgets/home_screen_widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Books>> _booksFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = BooksRepository().getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Books>>(
        future: _booksFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Books> books = snapshot.data!;
            Set<String> uniqueCategories = getUniqueCategories(books);
            return HomeScreenWidget(
              books: books,
              uniqueCategories: uniqueCategories.toList(),
              onBookSelected: (bookId) {
                navigateToBookDetailsScreen(context, bookId);
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading books'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Set<String> getUniqueCategories(List<Books> books) {
    Set<String> uniqueCategories = {};
    for (var book in books) {
      uniqueCategories.addAll(book.categories!);
    }
    return uniqueCategories;
  }

  void navigateToBookDetailsScreen(BuildContext context, String bookId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsScreen(bookId: bookId),
      ),
    );
  }
}
