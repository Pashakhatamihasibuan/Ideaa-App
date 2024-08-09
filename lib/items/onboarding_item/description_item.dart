import 'package:final_project/items/onboarding_item/item_boarding.dart';

class ContentItem {
  List<OnboardContentItem> items = [
    OnboardContentItem(
      title: "Mulai Menambahkan Data",
      description:
          "Pelajari cara menambahkan entri baru ke database Anda dengan mudah dan cepat.",
      image: "assets/images/onboarding1.png",
    ),
    OnboardContentItem(
      title: "Lihat Data Anda",
      description:
          "Temukan cara untuk melihat dan menelusuri data yang telah Anda tambahkan ke dalam sistem",
      image: "assets/images/onboarding2.png",
    ),
    OnboardContentItem(
      title: "Update & Delete",
      description:
          "Pelajari cara memperbarui entri yang ada atau menghapus data yang tidak lagi diperlukan.",
      image: "assets/images/onboarding3.png",
    ),
  ];
}
