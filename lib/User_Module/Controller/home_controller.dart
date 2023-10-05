import 'package:get/get.dart';

class HomeController extends GetxController {
   RxInt currentIndex = 0.obs;
    // Observable variable to track the current index

  void changePage(int index) {
    currentIndex.value = index; // Update the current index
  }
  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }
  
}