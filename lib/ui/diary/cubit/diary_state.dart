part of 'diary_cubit.dart';

class DiaryState {
  List<Entry> entries;
  bool searching;
  DiaryState({
    this.entries = const[],
    this.searching = false
  }); 
  DiaryState copyWith({
    List<Entry>? entries,
    bool? searching
  })=>DiaryState(
    entries: entries ?? this.entries,
    searching: searching ?? this.searching
  );
}

