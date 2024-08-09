import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/component/color.dart';

import 'package:final_project/pages/login/login.dart';
import 'package:final_project/pages/view_data/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Get.offAll(const LoginPage());
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            )
          ],
          title: Text(
            "Ideaa",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Masukan Data",
                  style: GoogleFonts.roboto(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextField(
                            style: GoogleFonts.roboto(),
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintText: "Nama",
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextField(
                            style: GoogleFonts.roboto(),
                            controller: ageController,
                            decoration: const InputDecoration(
                              hintText: "Umur",
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextField(
                            style: GoogleFonts.roboto(),
                            controller: addressController,
                            decoration: const InputDecoration(
                              hintText: "Alamat",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        // ADD DATA HERE
                        users.add(
                          {
                            'name': nameController.text,
                            'age': int.tryParse(ageController.text) ?? 0,
                            'address': addressController.text,
                          },
                        );
                        nameController.text = '';
                        ageController.text = '';
                        addressController.text = '';
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Tambah Data",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 26,
                  ),
                  SizedBox(
                    height: 60,
                    width: 140,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                          ViewData(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Lihat Data",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset("assets/images/inputdata.png")
            ],
          ),
        ),
      ),
    );
  }
}
