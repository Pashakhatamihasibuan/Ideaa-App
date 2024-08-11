import 'package:final_project/component/color.dart';
import 'package:final_project/pages/view_data/view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPage extends StatelessWidget {
  final String id;
  final String name;
  final String age;
  final String address;

  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController addressController;

  EditPage({
    super.key,
    required this.id,
    required this.name,
    required this.age,
    required this.address,
  })  : nameController = TextEditingController(text: name),
        ageController = TextEditingController(text: age),
        addressController = TextEditingController(text: address);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(ViewData());
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          "Ubah Data",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Nama",
                  prefixIcon: const Icon(
                    Icons.person_outline,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: "Umur",
                  prefixIcon: const Icon(
                    Icons.person_outline,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: "Alamat",
                  prefixIcon: const Icon(
                    Icons.location_pin,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .9,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: primaryColor,
              ),
              child: TextButton(
                onPressed: () {
                  users.doc(id).update({
                    'name': nameController.text,
                    'age': int.tryParse(ageController.text) ?? 0,
                    'address': addressController.text,
                  }).then((_) {
                    Navigator.of(context).pop();
                  });
                },
                child: Text(
                  'Simpan',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset("assets/images/ubahdata.png")
          ],
        ),
      ),
    );
  }
}
