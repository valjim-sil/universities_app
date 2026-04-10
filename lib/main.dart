import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/university_viewmodel.dart';
import 'views/list/university_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UniversityViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: UniversityListScreen());
  }
}
