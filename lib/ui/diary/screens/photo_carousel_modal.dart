
// ignore_for_file: avoid_renaming_method_parameters

import 'dart:async';
import 'dart:io';

import 'package:cupertino_page_controller/srcs/cupertino_page_controller.dart';
import 'package:diary_sysman/ui/styles.dart';
import 'package:diary_sysman/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoCarouselModal extends StatelessWidget {
  const PhotoCarouselModal({super.key});

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
                  onPressed: ()=>Navigator.pop(ctx),
                  icon: const Icon(CupertinoIcons.trash, size: 36,)
                )
              ],
            ),
          ),
          SizedBox(
            height: getAvailableHeight(0.722),
            child: PageView(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    // color: Colors.red`,
                    borderRadius: BorderRadius.all(Radius.circular(13))
                  ),
                  height: getAvailableHeight(0.722),
                  child: const FadeInImage(
                    placeholder: AssetImage('assets/placeholder.png'),  // Imagen de placeholder
                    image: AssetImage('assets/placeholder.png'), // URL de la imagen a cargar
                    fadeInDuration: Duration(milliseconds: 500),
                    height: 300,
                    width: 300,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(13))
                  ),
                  height: getAvailableHeight(0.722),
                  child: const FadeInImage(
                    placeholder: AssetImage('assets/placeholder.png'),  // Imagen de placeholder
                    image: AssetImage('assets/placeholder.png'), // URL de la imagen a cargar
                    fadeInDuration: Duration(milliseconds: 500),
                    height: 300,
                    width: 300,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(13))
                  ),
                  height: getAvailableHeight(0.722),
                  child: const FadeInImage(
                    placeholder: AssetImage('assets/placeholder.png'),  // Imagen de placeholder
                    image: AssetImage('assets/placeholder.png'), // URL de la imagen a cargar
                    fadeInDuration: Duration(milliseconds: 500),
                    height: 300,
                    width: 300,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
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
              length: 3,
              timer: Timer(const Duration(milliseconds: 500),(){}),
              current: 1,
            ),
          ),
        ],
      ),
    );
  }
}