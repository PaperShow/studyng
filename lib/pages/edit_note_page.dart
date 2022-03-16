import 'package:flutter/material.dart';
import 'package:studyng/db/notes_db.dart';
import 'package:studyng/model/note_model.dart';
import 'package:studyng/widget/note_form_widget.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.pink.shade50,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            // buildButton(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addOrUpdateNote,
          child: Icon(Icons.check),
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            isImportant: isImportant,
            number: number,
            title: title,
            description: description,
            onChangedImportant: (isImportant) =>
                setState(() => this.isImportant = isImportant),
            onChangedNumber: (number) => setState(() => this.number = number),
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
          ),
        ),
      );

  // Widget buildButton() {
  //   final isFormValid = title.isNotEmpty && description.isNotEmpty;

  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  //     child: TextButton(
  //       style: TextButton.styleFrom(
  //         primary: Colors.white,
  //         elevation: 0,
  //         // primary: isFormValid ? null : Colors.blueGrey,
  //       ),
  //       onPressed: addOrUpdateNote,
  //       child: Text('Save'),
  //     ),
  //   );
  // }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }
}
