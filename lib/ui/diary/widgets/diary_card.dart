
// ignore_for_file: avoid_renaming_method_parameters, use_build_context_synchronously

import 'package:diary_sysman/models/entry_model.dart';
import 'package:diary_sysman/ui/diary/screens/photo_carousel_modal.dart';
import 'package:diary_sysman/ui/diary/widgets/delete_entre_dialog.dart';
import 'package:diary_sysman/ui/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiaryCard extends StatelessWidget {
  const DiaryCard({
    required this.entry,
    super.key
  });

  final Entry entry;

  String weekDay(String dateStr){
    DateTime date = DateTime.parse(dateStr);
    String dayOfWeek = DateFormat('EEEE').format(date);
    return dayOfWeek[0].toUpperCase() + dayOfWeek.substring(1);
  }

  String formattedDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    String day = DateFormat('d').format(date);
    String month = DateFormat('MMMM', 'es').format(date); // 'es' para español

    return '$day de $month';
  }

  @override
  Widget build(BuildContext ctx) {
    return Dismissible(
      key: ValueKey(entry.title),
      direction: DismissDirection.endToStart,
      onDismissed: (direction)async{
        if(entry.id!=null){
          showDeleteConfirmationDialog(ctx,entry,false);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        height: entry.images.isEmpty?262:351,
        decoration:  BoxDecoration(
          color: Theme.of(ctx).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(12))
        ),
        child: Column(
          children: [
            SizedBox(
              height: 28,
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Text(weekDay(entry.date),
                    style: h2Style.copyWith(color: isDarkMode(ctx)?Colors.white:null)
                  ),
                  const Spacer(),
                  Text(formattedDate(entry.date),style: h4Style)
                ],
              ),
            ),
            const Spacer(),
            entry.images.isEmpty
            ?Image.asset('assets/icons/icon_ia.PNG', height: 60,)
            :InkWell(
              onTap: ()=>showModalBottomSheet(
                context: ctx,
                isScrollControlled: true,
                builder:(_)=>PhotoCarouselModal(entry: entry)
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(13))
                ),
                clipBehavior: Clip.antiAlias, 
                height: 182,
                child: FadeInImage(
                  placeholder: const AssetImage('assets/placeholder.png'),
                  image: MemoryImage(entry.images[0].image),
                  fadeInDuration: const Duration(milliseconds: 500),
                  height: 300,
                  width: 300,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 22,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(entry.title,
                  style: h3StyleSemiBold.copyWith(color: isDarkMode(ctx)?Colors.white:null),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis
                )
              ),
            ),
            SizedBox(
              height: 70,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(entry.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ),
            ),
          ],
        ),
      ),
    );
  }


}