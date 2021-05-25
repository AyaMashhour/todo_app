import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/model/bloc_model/bloc_model.dart';
import 'package:todo_app/shared/component/default_text_field.dart';
import 'package:todo_app/shared/network/bloc_screen.dart';

class DoneTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {},
        builder: (BuildContext context, AppState state) {
          var task = AppCubit.get(context).doneTask;
          return buildConditionalBuilder(task: task);
        });
  }
}
