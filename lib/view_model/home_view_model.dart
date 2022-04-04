import 'package:flutter/material.dart';
import 'package:pattern_provider_note/models/pattern_model.dart';
import 'package:pattern_provider_note/services/http_service.dart';

class HomeViewModel extends ChangeNotifier {

  List<PatternApi> list = [];
  bool isLoading = true;

  // text editing controller
  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  // get
  void apiGet() async {
    await HttpService.GET(HttpService.API_USERS, HttpService.paramEmpty()).then((value) => {
      response(value!),
    });
  }

  // parsing
  void response(String response) {
    List<PatternApi> items = HttpService.parsePatternApi(response);
    isLoading = false;
    list = items;
    notifyListeners();
  }

  // api delete
  void apiDelete(String userId) async {
    isLoading = true;
    notifyListeners();

    await HttpService.DELETE(HttpService.apiDelete(userId), HttpService.paramEmpty());
    apiGet();
  }

  // create posts
  void postCreate(BuildContext context) async {
    bool result = await displayDialog(context);

    String name = nameController.text.trim().toString();
    String title = titleController.text.trim().toString();
    String body = bodyController.text.trim().toString();
    notifyListeners();

    if(result) {
      isLoading = true;
      notifyListeners();

      PatternApi patternApi = PatternApi(name: name, title: title, body: body, dateTime: DateTime.now().toString().substring(0, 16), id: "");
      await HttpService.POST(HttpService.API_POST, HttpService.paramsCreate(patternApi));

      apiGet();
      notifyListeners();
    }
  }

  Future <bool> displayDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Post Create'),
            content: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: "Name"),
                ),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(hintText: "Title"),
                ),
                TextField(
                  controller: bodyController,
                  decoration: const InputDecoration(hintText: "Body"),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Create'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
              ),

              const SizedBox(width: 10,),

              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          );
        }
    );
  }

}