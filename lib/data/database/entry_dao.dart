// ignore_for_file: avoid_print

import 'package:diary_sysman/data/database/database_helper.dart';
import 'package:diary_sysman/models/entry_model.dart';

class EntryDao{
  final db = DatabaseHelper.instance.db;

  Future<List<Entry>> readAllEntries()async{
    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT 
        e.id AS entry_id, 
        e.date, 
        e.title, 
        e.description, 
        i.id AS image_id, 
        i.image 
      FROM entries e
      LEFT JOIN images i ON e.id = i.entry_id
    ''');

    return _mapResultToEntries(results);
  }

  Future<int> createEntry(Entry entry)async{
    int entryId = await db.insert('entries', {
      'date': entry.date,
      'title': entry.title,
      'description': entry.description,
    });
    for(ImageEntry imageEntry in entry.images){
      await db.insert('images', {
        'entry_id': entryId, // Usar el id generado de la Entry
        'image': imageEntry.image,
      });
    }
    return  entryId;
  }

  Future<void> checkTablesExist() async {
    final List<Map<String, dynamic>> tables = await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table";');
    print(tables);
  }

  Future<void> deleteEntry(int entryId) async {
    
    await db.delete(
      'images',
      where: 'entry_id = ?',
      whereArgs: [entryId],
    );

    await db.delete(
      'entries',
      where: 'id = ?',
      whereArgs: [entryId],
    );
  }

  Future<List<Entry>> searchEntries(String searchTerm) async {

    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT 
        e.id AS entry_id, 
        e.date, 
        e.title, 
        e.description, 
        i.id AS image_id,
        i.image 
      FROM entries e
      LEFT JOIN images i ON e.id = i.entry_id
      WHERE e.title LIKE ? OR e.description LIKE ?
    ''', ['%$searchTerm%', '%$searchTerm%']);
    return _mapResultToEntries(results);
  }

  List<Entry> _mapResultToEntries(List<Map<String, dynamic>> result) {
    Map<int, Entry> entriesMap = {};

    for (var row in result) {
      int entryId = row['entry_id'] ?? row['id'] ;
      print(entryId);

      if (!entriesMap.containsKey(entryId)) {
        entriesMap[entryId] = Entry(
          id: entryId,
          date: row['date'],
          title: row['title'],
          description: row['description'],
          images: [],
        );
      }

      if (row['image'] != null) {
        entriesMap[entryId]?.images.add(ImageEntry.fromMap({
          'id': row['image_id'],
          'entry_id': row['entry_id'],
          'image': row['image'],
        }));
      }
    }

    return entriesMap.values.toList();
  }

}