part of 'entry_cubit.dart';

class EntryState {
  TextEditingController titleController, descriptionController;
  bool finishedTitle;
  DateTime? dateTime;
  List<XFile> selectedImages;

  EntryState(
    this.titleController,
    this.descriptionController,{
      this.finishedTitle = false,
      this.dateTime,
      this.selectedImages = const[]
    }
  );

  EntryState copyWith({
    TextEditingController? titleController,
    TextEditingController? descriptionController,
    bool? finishedTitle,
    DateTime? dateTime,
    setDateTime = false,
    List<XFile>? selectedImages,
  })=>EntryState(
    titleController ?? this.titleController,
    descriptionController ?? this.descriptionController,
    finishedTitle: finishedTitle ?? this.finishedTitle,
    dateTime: setDateTime?dateTime:this.dateTime,
    selectedImages: selectedImages ?? this.selectedImages
  );
}
