
// ignore_for_file: use_build_context_synchronously

  import 'package:diary_sysman/models/entry_model.dart';
import 'package:diary_sysman/ui/diary/cubit/diary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showDeleteConfirmationDialog(BuildContext ctx, Entry entry, bool fronCarousel) {
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación de Eliminación'),
          content: Text('¿Estás seguro de que deseas eliminar "${entry.title}"?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                ctx.read<DiaryCubit>().readAllEntries();
                Navigator.of(context).pop();
                
              },
            ),
            TextButton(
              child: const Text('Eliminar'),
              onPressed: () async {
                if(fronCarousel){
                  Navigator.of(context).pop();

                }
                Navigator.of(context).pop();
                await ctx.read<DiaryCubit>().deleteEntry(entry.id!);
                ctx.read<DiaryCubit>().readAllEntries();
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(
                    content: Text('Entrada eliminado'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }