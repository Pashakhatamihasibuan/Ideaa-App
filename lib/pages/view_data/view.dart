import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/component/color.dart';
import 'package:final_project/pages/card/item_card.dart';
import 'package:final_project/pages/edit/edit.dart';
import 'package:final_project/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewData extends StatelessWidget {
  ViewData({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");

    return PopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.to(HomePage());
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            "Data",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                children: [
                  // * VIEW DATA HERE
                  StreamBuilder<QuerySnapshot>(
                    stream: users.orderBy('name').snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text('No data available'),
                        );
                      }

                      return Column(
                        children: snapshot.data!.docs.map(
                          (document) {
                            var data = document.data() as Map<String, dynamic>;
                            return ItemCard(
                              name: data['name'],
                              age: data['age'].toString(),
                              address: data['address'],
                              onUpdate: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditPage(
                                      id: document.id,
                                      name: data['name'],
                                      age: data['age'].toString(),
                                      address: data['address'],
                                    ),
                                  ),
                                );
                              },
                              onDelete: () {
                                document.reference.delete();
                              },
                            );
                          },
                        ).toList(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 150,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
