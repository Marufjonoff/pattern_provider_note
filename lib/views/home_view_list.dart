import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pattern_provider_note/view_model/home_view_model.dart';

Slidable itemOfList(int index, BuildContext context, HomeViewModel viewModel) {
  return Slidable(
    // Specify a key if the Slidable is dismissible.
    key: const ValueKey(0),

    // The start action pane is the one at the left or the top side.
    endActionPane: ActionPane(
      motion: const BehindMotion(),
      children: [
        SlidableAction(
          onPressed: (context) =>
              viewModel.apiDelete(viewModel.list[index].id),
          backgroundColor: Colors.blueGrey.shade700,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          flex: 1,
        )
      ],
    ),
    child: GestureDetector(
      onLongPress: (){
        viewModel.nameController.text = viewModel.list[index].name;
        viewModel.titleController.text = viewModel.list[index].title;
        viewModel.bodyController.text = viewModel.list[index].body;
        viewModel.updateId = viewModel.list[index].id;
        viewModel.updatePost(context);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(viewModel.list[index].name),
              const SizedBox(
                height: 5,
              ),
              Text(viewModel.list[index].title),
              const SizedBox(
                height: 5,
              ),
              Text(viewModel.list[index].body),
              const SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.centerRight,
                height: 15,
                width: MediaQuery.of(context).size.width,
                child: Text(viewModel.list[index].dateTime),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
