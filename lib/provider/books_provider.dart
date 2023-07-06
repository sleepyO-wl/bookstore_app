import 'dart:convert';
import 'package:bookstore/utils/uri.dart';
import 'package:http/http.dart' as http;
import 'package:bookstore/models/books.dart';

class BooksRepository {
  Future<List<Books>> getBooks() async {
    final response = await http.get(Uri.parse('$uri/api/books'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      return jsonData.map((data) => Books.fromJson(data)).toList();
    } else {
      throw Exception('Error fetching books');
    }
  }

  Future<Books> getBookById(String bookId) async {
    final response = await http.get(Uri.parse('$uri/api/books/$bookId'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return Books.fromJson(jsonData);
    } else {
      throw Exception('Error fetching books');
    }
  }
}
