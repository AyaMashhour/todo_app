import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/model/bloc_model/bloc_model.dart';
import 'package:todo_app/shared/component/default_text_field.dart';
import 'package:todo_app/shared/network/bloc_screen.dart';


class NewTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<AppCubit,AppState>
        (
        listener: (BuildContext context ,AppState state){},
          builder:(BuildContext context ,AppState state)
          {
            var task=AppCubit.get(context).newTask;
            return buildConditionalBuilder(task: task);

          }




    );
  }


}
