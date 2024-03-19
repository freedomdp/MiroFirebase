import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/bloc/directory_bloc.dart';
import 'package:miro/bloc/directory_event.dart';
import 'package:miro/bloc/directory_state.dart';
import 'package:miro/style/colors.dart';
import 'package:miro/style/text_styles.dart';
import 'package:miro/widgets/IconTextButton.dart';
import 'package:miro/widgets/modals/universal_modal.dart';

void showEmployeesModal(BuildContext context) {
  final DirectoryBloc directoryBloc = BlocProvider.of<DirectoryBloc>(context);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: BlocProvider.value(
          value: directoryBloc,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Изменение размера окна под контент
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Сотрудники',
                  style: TextStyles.h1Style,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: IconTextButton(
                    icon: Icons.add,
                    text: 'Добавить сотрудника',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => UniversalModal(
                          title: 'Добавить нового сотрудника',
                          employeeName:
                              '', // Имя сотрудника пустое для нового сотрудника
                          documentId:
                              '', // ID документа пустое для нового сотрудника
                          onSave: (String newName) {
                            // Добавляем нового сотрудника
                            BlocProvider.of<DirectoryBloc>(context)
                                .add(AddDirectory(newName));
                            Navigator.of(context)
                                .pop(); // Закрываем модальное окно
                          },
                          content: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Имя сотрудника',
                            ),
                          ),
                        ),
                      );
                    },
                    textStyle: TextStyles.textStyle
                        .copyWith(color: AppColors.background),
                    backgroundColor: AppColors.primary,
                  ),
                ),
                Expanded(
                  child: BlocBuilder<DirectoryBloc, DirectoryState>(
                    builder: (context, state) {
                      if (state is DirectoryLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is DirectoryLoaded) {
                        print(
                            'Сотрудники загружены: ${state.directories.length}');
                        state.directories.forEach((doc) => print(doc
                            .data())); // Выводим список сотрудников в консоль
                        return ListView.builder(
                          itemCount: state.directories.length,
                          itemBuilder: (context, index) {
                            var doc = state.directories[index].data()
                                as Map<String, dynamic>;
                            return ListTile(
                              title: Text(doc['Employee'] ?? 'Нет данных',
                                  style: TextStyles.textStyle),
                              trailing: IconTextButton(
                                icon: Icons.edit,
                                text: '',
                                onPressed: () {
                                  // Логика для редактирования сотрудника
                                },
                                textStyle: TextStyle(color: AppColors.primary),
                                backgroundColor: AppColors.background,
                              ),
                            );
                          },
                        );
                      } else if (state is DirectoryError) {
                        return Text('Ошибка: ${state.error}',
                            style: TextStyles.textStyle);
                      }
                      // Если состояние не DirectoryLoading, DirectoryLoaded или DirectoryError,
                      // это означает, что Bloc еще не начал загрузку данных.
                      // В этом случае мы инициируем загрузку.
                      context.read<DirectoryBloc>().add(LoadDirectories());
                      return const SizedBox
                          .shrink(); // Пустой виджет в ожидании данных
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconTextButton(
                    icon: Icons.close,
                    text: 'Закрыть',
                    onPressed: () => Navigator.of(context).pop(),
                    textStyle: const TextStyle(color: AppColors.background),
                    backgroundColor: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
