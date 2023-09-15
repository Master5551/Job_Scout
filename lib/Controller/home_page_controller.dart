import 'package:get/get.dart';

class HomePageController extends GetxController {
  // Initialize currentIndex as an RxInt with a default value of 0
  RxInt currentIndex = 0.obs;

  // Method to update the current index
  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }
}
