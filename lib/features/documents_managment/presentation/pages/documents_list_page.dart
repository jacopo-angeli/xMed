import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DocumentsListPage extends StatefulWidget {
  const DocumentsListPage({super.key});

  @override
  State<DocumentsListPage> createState() => _DocumentsListPageState();
}

class _DocumentsListPageState extends State<DocumentsListPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
