import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/model/bloc_model/bloc_model.dart';
import 'package:todo_app/shared/component/adding_new_task.dart';
import 'package:todo_app/shared/component/default_text_field.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:todo_app/shared/network/bloc_screen.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {
          if (state is AppInsertDataBaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppState state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.title[cubit.currentIndex]),
            ),
            body: ConditionalBuilder(
              condition: cubit.newTask.length > 0,
              builder: (context) => cubit.screen[cubit.currentIndex],
              fallback: (context) => Center(
                child: fallBack(),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState.validate()) {
                    cubit.insertDataBase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet((context) => Container(
                            padding: EdgeInsets.all(15.0),
                            color: Colors.white,
                            child: Form(
                              key: formKey,
                              child: AddingNewTask(context,
                                  title: titleController,
                                  time: timeController,
                                  date: dateController),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        fIcon: Icons.edit, isShow: false);
                    titleController.clear();
                    timeController.clear();
                    dateController.clear();
                  });
                  cubit.changeBottomSheetState(fIcon: Icons.add, isShow: true);
                }
              },
              child: Icon(cubit.fIconData),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              elevation: 10.0,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(label: 'Task', icon: Icon(Icons.menu)),
                BottomNavigationBarItem(
                    label: 'Done', icon: Icon(Icons.check_circle_outline)),
                BottomNavigationBarItem(
                    label: 'Archive', icon: Icon(Icons.archive)),
              ],
            ),
          );
        },
      ),
    );
  }
}
