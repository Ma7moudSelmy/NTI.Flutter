import 'package:flutter/material.dart';

import '../../../core/widgets/date_field.dart';
import '../../../core/widgets/my_custom_button.dart';
import '../../../core/widgets/my_text_form_field.dart';
import '../../../core/widgets/simple_appbar.dart';
import 'widgets/edit_task_header.dart';

class EditTaskPage extends StatelessWidget {
  EditTaskPage({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController groupController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SimpleAppBar.build(
          title: 'Edit Task',
          isDelete: true,
          onBack: () {
            Navigator.pop(context);
          },
          onDelete: () {},
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  EditTaskHeader(),
                  SizedBox(height: 20),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyTextFormField(
                          fieldType: TextFieldType.group,
                          controller: groupController,
                        ),
                        SizedBox(height: 15),
                        MyTextFormField(
                          fieldType: TextFieldType.taskTitle,
                          controller: titleController,
                        ),
                        SizedBox(height: 15),
                        MyTextFormField(
                          fieldType: TextFieldType.taskDescribtion,
                          controller: descriptionController,
                        ),

                        SizedBox(height: 15),
                        DateField(),
                        SizedBox(height: 30),
                        MyCustomeButton(text: 'Mark as Done', onPressed: () {}),
                        SizedBox(height: 15),
                        MyCustomeButton(
                          text: 'Update',
                          onPressed: () {},
                          isOutlinedButton: true,
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
