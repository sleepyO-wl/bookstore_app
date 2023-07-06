// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookstore/utils/null_image_url.dart';

class Books {
  final String? id;
  final String? title;
  final int? pageCount;
  final String? thumbnailUrl;
  final DateTime? publishedDate;
  final String? shortDescription;
  final String? longDescription;
  final List<String>? authors;
  final List<String>? categories;

  Books({
    required this.id,
    required this.title,
    required this.pageCount,
    required this.thumbnailUrl,
    required this.publishedDate,
    required this.shortDescription,
    required this.longDescription,
    required this.authors,
    required this.categories,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'pageCount': pageCount,
      'thumbnailUrl': thumbnailUrl,
      'publishedDate': publishedDate?.millisecondsSinceEpoch,
      'shortDescription': shortDescription,
      'longDescription': longDescription,
      'authors': authors,
      'categories': categories,
    };
  }

  factory Books.fromJson(Map<String, dynamic> json) {
    return Books(
      id: json['_id'] != null ? json['_id'] as String : null,
      title: json['title'] != null ? json['title'] as String : 'title',
      pageCount: json['pageCount'] != null ? json['pageCount'] as int : 0,
      thumbnailUrl: json['thumbnailUrl'] != null
          ? json['thumbnailUrl'] as String
          : nullImage,
      publishedDate: json['publishedDate'] != null
          ? DateTime.parse(json['publishedDate'])
          : DateTime.now(),
      shortDescription: json['shortDescription'] != null
          ? json['shortDescription'] as String
          : '',
      longDescription: json['longDescription'] != null
          ? json['longDescription'] as String
          : '',
      authors:
          json['authors'] != null ? List<String>.from(json['authors']) : [],
      categories: json['categories'] != null
          ? List<String>.from(json['categories'])
          : [],
    );
  }

  String toJson() => json.encode(toMap());
}
