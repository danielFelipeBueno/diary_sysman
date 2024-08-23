
// ignore_for_file: avoid_renaming_method_parameters

import 'dart:async';
import 'dart:io';

import 'package:cupertino_page_controller/srcs/cupertino_page_controller.dart';
import 'package:diary_sysman/models/entry_model.dart';
import 'package:diary_sysman/ui/diary/widgets/delete_entre_dialog.dart';
import 'package:diary_sysman/ui/styles.dart';
import 'package:diary_sysman/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoCarouselModal extends StatefulWidget {
  const PhotoCarouselModal({
    required this.entry,
    super.key
  });

  final Entry entry;
  

  @override
  State<PhotoCarouselModal> createState() => _PhotoCarouselModalState();
}

class _PhotoCarouselModalState extends State<PhotoCarouselModal> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _pageController.addListener(() {
      final page = _pageController.page;
      if (page != null) {
        setState(() {
          _currentIndex = page.round();
        });
      }
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Container(
      height: getAvailableHeight(2),
      margin: EdgeInsets.symmetric(horizontal: getAvailableWidth(0.038)),
      child: Column(
        children: [
          SizedBox(height: getAvailableHeight(Platform.isAndroid?0.03:0.07)),
          SizedBox(
            height: getAvailableHeight(0.074),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: ()=>Navigator.pop(ctx),
                  icon: const Icon(CupertinoIcons.clear, size: 36,)
                ),
                IconButton(
                  onPressed: (){
                    showDeleteConfirmationDialog(ctx,widget.entry,true);
                  },
                  icon: const Icon(CupertinoIcons.trash, size: 36,)
                )
              ],
            ),
          ),
          SizedBox(
            height: getAvailableHeight(0.722),
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.entry.images.length,
              itemBuilder: (ctx, i){
                return Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(28))
                  ),
                  clipBehavior: Clip.antiAlias, 
                  height: getAvailableHeight(0.722),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/placeholder.png'),
                    image: MemoryImage(widget.entry.images[i].image),
                    fadeInDuration: const Duration(milliseconds: 500),
                    height: 300,
                    width: 300,
                    fit: BoxFit.fitHeight,
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: getAvailableHeight(0.066),
            child: Center(
              child: Text('Title',style: h2Style),
            ),
          ),
          SizedBox(
            height: getAvailableHeight(0.046),
            child: Center(
              child: Text('Domingo, 18 de agosto', style: h5Style),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CupertinoPageControl(
              brightness: Brightness.light,
              isSelect: true,
              length: widget.entry.images.length,
              timer: Timer(const Duration(milliseconds: 500),(){}),
              current: _currentIndex,
            ),
          ),
        ],
      ),
    );
  }
}