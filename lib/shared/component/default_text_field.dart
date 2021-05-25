import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/network/bloc_screen.dart';

Widget defaultTextField({
  TextEditingController controller,
  Function onTap,
  String textLabel,
  IconData prefixed,
  Function validate,
  TextInputType type,
}) =>
    TextFormField(
      keyboardType: type,
      decoration: InputDecoration(
        labelText: textLabel,
        prefixIcon: Icon(prefixed),
        border: OutlineInputBorder(borderSide: BorderSide()),
      ),
      validator: validate,
      onTap: onTap,
      controller: controller,
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text('${model['time']}'),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${model['title']}",
                    style:
                        TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${model['date']}",
                    style: TextStyle(fontSize: 13.0, color: Colors.grey[700]),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            IconButton(
                icon: Icon(Icons.check_box),
                iconSize: 30,
                color: Colors.green[800],
                onPressed: () {
                  AppCubit.get(context).updateDateBase(
                    status: 'DONE',
                    id: model['id'],
                  );
                }),
            IconButton(
                icon: Icon(Icons.archive_rounded),
                iconSize: 30,
                color: Colors.black54,
                onPressed: () {
                  AppCubit.get(context).updateDateBase(
                    status: 'Archive',
                    id: model['id'],
                  );
                })
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteDateBase(id: model['id']);
      },
    );

Widget buildConditionalBuilder({@required List<Map> task}) =>
    ConditionalBuilder(
      condition: task.length>0,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(task[index], context),
          separatorBuilder: (context, index) => Container(
              width: double.infinity, height: 2, color: Colors.grey[300]),
          itemCount: task.length),
      fallback: (context) => Center(
        child: fallBack(),
      ),
    );


Widget fallBack()=>Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Icon(
      Icons.menu,
      size: 50.0,
      color: Colors.grey,
    ),
    Text(
      'No Tasks is here Enter Some Tasks',
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.grey,
      ),
    )
  ],
);