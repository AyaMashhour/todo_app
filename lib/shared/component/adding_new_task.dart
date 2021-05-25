import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'default_text_field.dart';



Widget AddingNewTask (context,
{
  @required TextEditingController title,
  @required TextEditingController time,
  @required TextEditingController date,

})=>Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    defaultTextField(
        controller: title,
        prefixed: Icons.title,
        textLabel: 'TextTitle',
        onTap: () {
          print('task');
        },
        validate: (String value) {
          if (value.isEmpty) {
            return 'please enter your Task';
          }
          return null;
        }),
    SizedBox(
      height: 4.0,
    ),
    defaultTextField(
        type: TextInputType.datetime,
        controller: time,
        prefixed: Icons.watch_later_outlined,
        textLabel: 'time',
        onTap: () {

          showTimePicker(
              context: context,
              initialTime: TimeOfDay.now())
              .then((value) {
            time.text =
                value.format(context).toString();
            print(value.format(context));
          });
        },
        validate: (String value) {
          if (value.isEmpty) {
            return 'please enter your time ';
          }
          return null;
        }),
    SizedBox(
      height: 4.0,
    ),
    defaultTextField(
        type: TextInputType.datetime,
        controller: date,
        prefixed: Icons.assignment_sharp,
        textLabel: 'date',
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate:
            DateTime.parse('2021-05-30'),
          ).then((value) {
            date.text =
                DateFormat.yMMMd()
                    .format(value)
                    .toString();
            print(
                DateFormat.yMMMd().format(value));
          });
        },
        validate: (String value) {
          if (value.isEmpty) {
            return 'please enter your date';
          }
          return null;
        }),
  ],
);