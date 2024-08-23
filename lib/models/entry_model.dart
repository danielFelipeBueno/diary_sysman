import 'package:flutter/foundation.dart';

class Entry {
  final int? id;
  final String date;
  final String title;
  final String description;
  final List<ImageEntry> images;

  Entry({
    this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.images,
  });

  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
      id: map['id'],
      date: map['date'],
      title: map['title'],
      description: map['description'],
      images: [],
    );
  }
}


class ImageEntry {
  final int? id;
  final int entryId;
  final Uint8List image;

  ImageEntry({
    this.id,
    required this.entryId,
    required this.image,
  });

  factory ImageEntry.fromMap(Map<String, dynamic> map) {
    return ImageEntry(
      id: map['id'],
      entryId: map['entry_id'],
      image: map['image'],
    );
  }
}
