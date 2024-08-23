
import 'package:diary_sysman/ui/styles.dart';
import 'package:flutter/material.dart';

class DiaryCard extends StatelessWidget {
  const DiaryCard({
    required this.weekDay,
    required this.date,
    required this.title,
    required this.info,
    super.key
  });

  final String weekDay, date, title, info;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      height: 351,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Column(
        children: [
          SizedBox(
            height: 28,
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text(weekDay,style: h2Style),
                const Spacer(),
                Text(date,style: h4Style)
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(13))
            ),
            height: 182,
            child: const FadeInImage(
              placeholder: AssetImage('assets/placeholder.png'),  // Imagen de placeholder
              image: AssetImage('assets/placeholder.png'), // URL de la imagen a cargar
              fadeInDuration: Duration(milliseconds: 500),
              height: 300,
              width: 300,
              fit: BoxFit.fitWidth,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 22,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(title,style: h3StyleSemiBold )
            ),
          ),
          SizedBox(
            height: 70,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(info,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )
            ),
          ),
        ],
      ),
    );
  }
}