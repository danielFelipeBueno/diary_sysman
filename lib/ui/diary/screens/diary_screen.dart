import 'package:diary_sysman/models/entry_model.dart';
import 'package:diary_sysman/ui/diary/cubit/diary_cubit.dart';
import 'package:diary_sysman/ui/diary/widgets/diary_card.dart';
import 'package:diary_sysman/ui/entry/cubit/entry_cubit.dart';
import 'package:diary_sysman/ui/entry/screens/entry_screen.dart';
import 'package:diary_sysman/ui/styles.dart';
import 'package:diary_sysman/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({
    required this.onThemeToggle,
    super.key
  });

  final VoidCallback onThemeToggle;

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  late TextEditingController textController;

   @override
  void initState() {
    super.initState();
    context.read<DiaryCubit>().readAllEntries();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiaryCubit, DiaryState>(
      builder: (ctx, state) {
        return Scaffold(
          // backgroundColor: const Color(0xffF8F5F4),
          body: SafeArea(
            bottom: false,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: getAvailableWidth(0.038)),
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
                            icon: Icon(
                              isDarkMode(ctx)
                              ?CupertinoIcons.sun_min
                              :CupertinoIcons.moon,
                              color: isDarkMode(ctx)?Colors.white:null,
                            ),
                            onPressed: widget.onThemeToggle,
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
                      placeholder: 'Buscar por título o descripción',
                      style: isDarkMode(ctx)?const TextStyle(color: Colors.white):null,
                      onChanged: (searchTerm){
                        if(searchTerm.isNotEmpty){
                          ctx.read<DiaryCubit>().searchEntry(searchTerm);
                        }else{
                          ctx.read<DiaryCubit>().readAllEntries();
                        }
                      },
                    ),
                  ),
                  if(state.entries.isNotEmpty&&state.searching)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: CupertinoActivityIndicator(),
                  ),
                  SizedBox(height: getAvailableHeight(0.016)),
                  Expanded(
                    child: state.entries.isNotEmpty
                    ?SingleChildScrollView(
                      child: Column(
                        children: state.entries.map((Entry entry)=> DiaryCard(entry: entry)).toList()
                      ),
                    )
                    :Column(
                      children: [
                        const Spacer(flex: 3),
                        Center(child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                ctx.read<EntryCubit>().checkTablesExist();
                              },
                              child: Image.asset('assets/icons/icon_ia.PNG',height: 80)
                            ),
                            const SizedBox(height: 20),
                            Text('Registra tus momentos.',style: h2Style.copyWith(fontSize: 20)),
                            const SizedBox(height: 10),
                            Text("Toca el boton '+' para crear momentos",
                              style: h5HintStyle.copyWith(fontWeight: FontWeight.w300,color: const Color(0xff878589))
                            )
                          ],
                        )),
                        const Spacer(flex: 4),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: SizedBox(
            width: 70, // Ajusta el ancho según sea necesario
            height: 70,
            child: FloatingActionButton(
              backgroundColor:isDarkMode(ctx)?kPrimaryColor:Colors.white,
              onPressed: (){
                ctx.read<EntryCubit>().setDateTime(DateTime.now());
                Navigator.of(ctx).push(
                  MaterialPageRoute(builder: (_) => const EntryScreen()),
                );
              },
              elevation: 10,
              child: Icon(Icons.add,
                size: 36,
                color: isDarkMode(ctx)?Colors.white:kPrimaryColor
              ),
            ),
          ),
        );
      },
    );
  }
}