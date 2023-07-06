import 'package:bookstore/main.dart';
import 'package:bookstore/models/books.dart';
import 'package:bookstore/screens/bag_screen.dart';
import 'package:bookstore/screens/book_details_screen.dart';
import 'package:bookstore/screens/books_library_screen.dart';
import 'package:bookstore/screens/home_screen.dart';
import 'package:bookstore/screens/profile_screen.dart';
import 'package:bookstore/utils/null_image_url.dart';
import 'package:flutter/material.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key, required this.books});
  final List<Books> books;

  @override
  State<NavigationBarScreen> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBarScreen> {
  late List<Books> filteredBooks;
  late TextEditingController searchController;
  late FocusNode _searchFocusNode;

  var _pageIndex = 0;

  final List<Widget> _selectedPage = [
    const HomeScreen(),
    const BooksLibraryScreen(),
    const BagScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    filteredBooks = widget.books;
    searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _page(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  void filterBooks(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredBooks = widget.books
            .where((book) =>
                book.title!.toLowerCase().contains(query.toLowerCase()) ||
                book.authors!.any((author) =>
                    author.toLowerCase().contains(query.toLowerCase())))
            .toList();
      } else {
        filteredBooks = widget.books;
      }
    });
  }

  void _openKeyboard() {
    FocusScope.of(context).requestFocus(_searchFocusNode);
  }

  void _closeKeyboard() {
    _searchFocusNode.unfocus();
  }

  void navigateToBookDetailsScreen(context, String bookId) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsScreen(bookId: bookId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pageIndex != 3
          ? AppBar(
              forceMaterialTransparency: true,
              backgroundColor: Colors.transparent,
              actions: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 8),
                          height: double.infinity,
                          width: 280,
                          child: SearchBar(
                            onTap: _openKeyboard,
                            focusNode: _searchFocusNode,
                            controller: searchController,
                            onChanged: (value) => filterBooks(value),
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(horizontal: 14)),
                            shape: const MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    side: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)))),
                            elevation: const MaterialStatePropertyAll(5.0),
                            hintText: 'Search your book',
                            textStyle: const MaterialStatePropertyAll(
                                TextStyle(color: Colors.grey)),
                          ),
                        ),
                        IconButton(
                          iconSize: 25,
                          onPressed: () {
                            searchController;
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          alignment: Alignment.center,
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  colorScheme.onBackground)),
                          splashColor: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ])
          : AppBar(
              backgroundColor: Colors.transparent,
            ),
      body: GestureDetector(
        onTap: _closeKeyboard,
        child: searchController.text.isEmpty
            ? _selectedPage[_pageIndex]
            : ListView.builder(
                itemCount: filteredBooks.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => navigateToBookDetailsScreen(
                      context, filteredBooks[index].id!),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            filteredBooks[index].thumbnailUrl ?? nullImage)),
                    title: Text(
                      filteredBooks[index].title!,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    subtitle: Text(
                      //
                      'Book by ${filteredBooks[index].authors}',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    trailing: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Text(
                          '₹${filteredBooks[index].pageCount!.toString()}',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        )),
                  ),
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        iconSize: 25,
        currentIndex: _pageIndex,
        onTap: _page,
        selectedItemColor: const Color.fromARGB(221, 4, 7, 129),
        selectedFontSize: 14,
        showUnselectedLabels: true,
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books_outlined),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Bag',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
