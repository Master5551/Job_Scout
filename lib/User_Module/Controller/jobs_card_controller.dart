import 'package:get/get.dart';

class JobsCardController extends GetxController {
  RxInt currentIndex = 3.obs;
  // Observable variable to track the current index

  void changePage(int index) {
    currentIndex.value = index; // Update the current index
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }
}
