import 'package:get/get.dart';

class Filtercontroller extends GetxController {
  RxList<String> category = <String>[
    "All",
    "Food",
    "coding",
    "Design",
    "Music",
    "Religion",
  ].obs;

  var index = 0.obs;
  var selected = "All".obs;

  void changeIndex(int ind) {
    index.value = ind;
    selected.value = category[ind];
  }
}
