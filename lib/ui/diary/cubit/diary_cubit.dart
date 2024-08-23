
import 'package:diary_sysman/data/database/entry_dao.dart';
import 'package:diary_sysman/models/entry_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'diary_state.dart';

class DiaryCubit extends Cubit<DiaryState> {
  DiaryCubit() : super(DiaryState());

  final dao = EntryDao();

  readAllEntries()async{
    emit(DiaryState());
    await dao.readAllEntries().then((values)async{
      List<Entry> entries = [];
      for(Entry entry in values){
        entries.add(entry);
      }
      emit(state.copyWith(entries: entries));
    });
  }

  deleteEntry(int entryId)async{
    await dao.deleteEntry(entryId);
  }

  searchEntry(String searchTerm)async{
    emit(state.copyWith(searching: true));
    await dao.searchEntries(searchTerm).then((values)async{
      List<Entry> entries = [];
      for(Entry entry in values){
        entries.add(entry);
      }
      emit(state.copyWith(entries: entries,searching: false));
    });
  }
}
