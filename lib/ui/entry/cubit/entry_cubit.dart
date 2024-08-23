import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'entry_state.dart';

final titleController = TextEditingController();
final descriptionController = TextEditingController();

class EntryCubit extends Cubit<EntryState> {
  EntryCubit() : super(EntryState(
    titleController,
    descriptionController
  ));

  setFinishedTitle(bool value)=>emit(state.copyWith(finishedTitle: value));

  setDateTime(DateTime dateTime)=>emit(state.copyWith(dateTime: dateTime,setDateTime: true));

  addSelectedImages(List<XFile> images){
    List<XFile> selectedImages = List<XFile>.from(state.selectedImages+images);
    emit(state.copyWith(selectedImages: selectedImages));
  }

  Future getCamera(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    //todo
  }

  Future getGalery(BuildContext context)async {
    final List<XFile>? images = await ImagePicker().pickMultiImage();
    print('============= HOLANDA');
    if (images == null){
      print('============= HOLANDA 1');
      return;
    } else{
      print('============= HOLANDA 2');
      addSelectedImages(images);
    }
  }
}
