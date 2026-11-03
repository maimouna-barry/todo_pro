import 'package:flutter/material.dart';

class TodoFormPage extends StatelessWidget {
  const TodoFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajout")),
      body: const Center(child: Text("Formulaire")),
    );
  }
}
