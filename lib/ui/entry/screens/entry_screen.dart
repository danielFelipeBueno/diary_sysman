// ignore_for_file: avoid_renaming_method_parameters

import 'dart:io';

import 'package:diary_sysman/ui/entry/cubit/entry_cubit.dart';
import 'package:diary_sysman/ui/styles.dart';
import 'package:diary_sysman/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_titleFocusNode);
    });
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return BlocBuilder<EntryCubit, EntryState>(
      builder: (ctx, state) {
        var edgeInsets = EdgeInsets.symmetric(horizontal: getAvailableWidth(0.061));
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: getAvailableWidth(0.038)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 52,
                      child: IconButton(
                        onPressed: ()=>Navigator.pop(ctx),
                        icon: const Icon(CupertinoIcons.clear, size: 36,)
                      ),
                    ),
                    const Spacer(),
                    CupertinoButton(
                      onPressed: (){
                        showDialogDatePicker(
                        CupertinoDatePicker(
                          initialDateTime: DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: true,
                          showDayOfWeek: true,
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() => ctx.read<EntryCubit>().setDateTime(newDate));
                          },
                          //   ),
                          ),
                        );
                      },
                      child: Text(
                        state.dateTime!=null?DateFormat('EEEE, d \'de\' MMMM', 'es_ES').format(state.dateTime!):'',
                        style: h5Style
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width:52)
                  ],
                ),
              ),
            ),
            toolbarHeight: getAvailableHeight(0.07),
          ),
          body: Column(
            children: [
              if(!state.finishedTitle)
              const Spacer(),
              Center(
                child: Container(
                  margin: edgeInsets,
                  width: getAvailableWidth(0.76),
                  child: TextField(
                    focusNode: _titleFocusNode,
                    maxLines: null,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    controller: state.titleController,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.done,
                    style: h1HintStyle.copyWith(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Escribe tu título',
                      hintStyle: h1HintStyle,
                      border: InputBorder.none, 
                    ),
                    onSubmitted: (_) {
                      if(!state.finishedTitle) {
                        Future.delayed(
                        const Duration(milliseconds: 500),(){
                          FocusScope.of(context).requestFocus(_descriptionFocusNode);
                        }
                      );
                      ctx.read<EntryCubit>().setFinishedTitle(true);
                      }
                    },
                  ),
                ),
              ),
              if(state.finishedTitle&&state.selectedImages.isNotEmpty)
              SizedBox(
                height: getAvailableHeight(0.24),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.selectedImages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      clipBehavior: Clip.antiAlias, 
                      child: Image.file(
                        File(state.selectedImages[index].path),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              if(state.finishedTitle)SizedBox(height:  getAvailableHeight(0.016)),
              if(state.finishedTitle)
              Padding(
                padding: edgeInsets,
                child: InkWell(
                  onTap: ()=>showOptionsDialog(ctx),
                  borderRadius: borderRadius12,
                  child: Container(
                    height: getAvailableHeight(0.058),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius12,
                      color: kSecondaryColor
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/photos_icon.png', height: 24),
                        const SizedBox(width: 6),
                        Text('Agregar imagenes',style: h3ButtonStyle)
                      ],
                    ),
                  ),
                ),
              ),
              if(state.finishedTitle)SizedBox(height:  getAvailableHeight(0.016)),
              if(state.finishedTitle)
              Expanded(
                child: Padding(
                  padding: edgeInsets,
                  child: TextField(
                    focusNode: _descriptionFocusNode,
                    maxLines: null,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    controller: state.descriptionController,
                    textInputAction: TextInputAction.done,
                    style: h5HintStyle.copyWith(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Empieza a escribir...',
                      hintStyle: h5HintStyle,
                      border: InputBorder.none, 
                    ),
                    onSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              ),
              if(!state.finishedTitle)
              const Spacer()
            ],
          ),
        );
      },
    );
  }

  void showDialogDatePicker(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  void showOptionsDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Seleccionar Imagenes'),
          content: const Text('¿Desde dónde quieres seleccionar imágenes?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                ctx.read<EntryCubit>().getCamera(ctx);
                Navigator.pop(ctx);
              },
              child: const Text('Cámara'),
            ),
            TextButton(
              onPressed: () {
                ctx.read<EntryCubit>().getGalery(ctx);
                Navigator.pop(ctx);
              },
              child: const Text('Galería'),
            ),
          ],
        );
      },
    );
  }
}