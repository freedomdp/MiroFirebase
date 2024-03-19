import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/bloc/directory_bloc.dart';
import 'package:miro/bloc/directory_event.dart';
import 'package:miro/bloc/directory_state.dart';
import 'package:miro/style/text_styles.dart';

class DirectoryTable extends StatelessWidget {
  const DirectoryTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Запускаем загрузку данных при первой отрисовке виджета
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DirectoryBloc>().add(LoadDirectories());
    });

    return BlocBuilder<DirectoryBloc, DirectoryState>(
      builder: (context, state) {
        if (state is DirectoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DirectoryLoaded) {
          return ListView.builder(
            itemCount: state.directories.length,
            itemBuilder: (context, index) {
              var doc = state.directories[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(doc['Employee'] ?? 'Нет данных',
                    style: TextStyles.textStyle),
                // Добавьте здесь кнопки действий, если необходимо
              );
            },
          );
        } else if (state is DirectoryError) {
          return Text('Ошибка: ${state.error}', style: TextStyles.textStyle);
        }
        return const SizedBox
            .shrink(); // Пустой виджет для начального состояния
      },
    );
  }
}
