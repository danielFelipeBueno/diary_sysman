import 'package:diary_sysman/ui/diary/widgets/diary_card.dart';
import 'package:diary_sysman/ui/styles.dart';
import 'package:diary_sysman/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  late TextEditingController textController;

   @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F5F4),
      body: SafeArea(
        bottom: false,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: getAvailableHeight(0.038)),
          child: Column(
            children: [
              SizedBox(
                height: getAvailableHeight(0.07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('Diario',style: h1Style)
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton.filledTonal(
                        icon: const Icon(CupertinoIcons.moon),
                        onPressed: () {},
                      )
                    ),
                  ],
                ),
              ),
              SizedBox(height: getAvailableHeight(0.014)),
              SizedBox(
                height: getAvailableHeight(0.044),
                child: CupertinoSearchTextField(
                  controller: textController,
                  placeholder: 'Buscar',
                ),
              ),
              SizedBox(height: getAvailableHeight(0.016)),
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DiaryCard(
                        weekDay: 'Domingo',
                        date: '19 de agosto',
                        title: 'Title',
                        info: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent sed massa ut nunc vulputate posuere a ac ante. Curabitur lacus quam, convallis eget ante vulputate, dignissim sodales elit.',
                      ),
                      DiaryCard(
                        weekDay: 'Domingo',
                        date: '19 de agosto',
                        title: 'Title',
                        info: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent sed massa ut nunc vulputate posuere a ac ante. Curabitur lacus quam, convallis eget ante vulputate, dignissim sodales elit.',
                      ),
                      DiaryCard(
                        weekDay: 'Domingo',
                        date: '19 de agosto',
                        title: 'Title',
                        info: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent sed massa ut nunc vulputate posuere a ac ante. Curabitur lacus quam, convallis eget ante vulputate, dignissim sodales elit.',
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: null,
        elevation: 10,
        child: Icon(Icons.add,
          size: 30,
          color: kPrimaryColor
        ),
      ),
    );
  }
}