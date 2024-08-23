// ignore_for_file: unnecessary_nullable_for_final_variable_declarations

import 'dart:developer';

import 'package:diary_sysman/data/database/entry_dao.dart';
import 'package:diary_sysman/models/entry_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

part 'entry_state.dart';

final titleController = TextEditingController();
final descriptionController = TextEditingController();

class EntryCubit extends Cubit<EntryState> {
  EntryCubit() : super(EntryState(
    titleController,
    descriptionController
  ));

  final dao = EntryDao();

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
    if (images == null){
      return;
    } else{
      addSelectedImages(images);
    }
  }

  checkTablesExist()async{
    await dao.checkTablesExist();
  }

  Future<int> createEntry()async{
    List<ImageEntry> imageEntries = [];
    for(XFile file in state.selectedImages){
      Uint8List imageData = await convertXFileToUint8List(file);
      ImageEntry imageEntry = ImageEntry(
        entryId: 0,
        image: imageData,
      );
      imageEntries.add(imageEntry);
    }
    Entry newEntry = Entry(
      date: DateFormat('yyyy-MM-dd').format(state.dateTime??DateTime.now()),
      title: state.titleController.text,
      description: state.descriptionController.text,
      images: imageEntries
    );
    int result = await dao.createEntry(newEntry);
    emit(EntryState(TextEditingController(), TextEditingController()));
    return result;
  }

  Future<Uint8List> convertXFileToUint8List(XFile file) async {
    return await file.readAsBytes();
  }

  


}
