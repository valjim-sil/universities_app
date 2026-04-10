import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/university_viewmodel.dart';
import '../detail/university_detail_screen.dart';

class UniversityListScreen extends StatefulWidget {
  const UniversityListScreen({super.key});

  @override
  State<UniversityListScreen> createState() => _UniversityListScreenState();
}

class _UniversityListScreenState extends State<UniversityListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final viewModel = Provider.of<UniversityViewModel>(context, listen: false);

    Future.microtask(() => viewModel.fetchUniversities());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        viewModel.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<UniversityViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Universities (${viewModel.visibleUniversities.length})'),
        actions: [
          IconButton(
            icon: Icon(viewModel.isGridView ? Icons.list : Icons.grid_view),
            onPressed: viewModel.toggleView,
          ),
        ],
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.isGridView
          ? GridView.builder(
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
              ),
              itemCount: viewModel.visibleUniversities.length,
              itemBuilder: (context, index) {
                final uni = viewModel.visibleUniversities[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UniversityDetailScreen(university: uni),
                      ),
                    );
                  },
                  child: Card(
                    child: Center(
                      child: Text(uni.name, textAlign: TextAlign.center),
                    ),
                  ),
                );
              },
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: viewModel.visibleUniversities.length,
              itemBuilder: (context, index) {
                final uni = viewModel.visibleUniversities[index];

                return ListTile(
                  title: Text(uni.name),
                  subtitle: Text(uni.country),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UniversityDetailScreen(university: uni),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
