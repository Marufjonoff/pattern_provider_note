import 'package:flutter/material.dart';
import 'package:pattern_provider_note/view_model/home_view_model.dart';
import 'package:pattern_provider_note/views/home_view_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String id = "home_page";
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.apiGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note with Provider"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<HomeViewModel> (
          builder: (ctx, model, index) => viewModel.isLoading ? const Center(
            child: CircularProgressIndicator(),
          ) : ListView.builder(
            itemCount: viewModel.list.length,
            itemBuilder: (context, index) {
              return itemOfList(index, context, viewModel);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          viewModel.postCreate(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
