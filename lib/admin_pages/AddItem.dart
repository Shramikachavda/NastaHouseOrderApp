import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_order/auth_helper.dart';
import 'package:food_order/custom_widget/TextField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class Additem extends StatefulWidget {
  const Additem({super.key});

  @override
  State<Additem> createState() => _AdditemState();
}

class _AdditemState extends State<Additem> {
  TextEditingController item = TextEditingController();
  TextEditingController price = TextEditingController();
  String? _selectedRole;
  final ImagePicker _picker = ImagePicker();
  File? pickedImage;

  showAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Pick Image From'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      onTap: () {
                        getImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                      leading: Icon(Icons.camera_alt),
                      title: Text('Camera')),
                  ListTile(
                      onTap: () {
                        getImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      leading: Icon(Icons.image),
                      title: Text('Gallary'))
                ],
              ));
        });
  }

  getImage(ImageSource imagesource) async {
    try {
      final image = await _picker.pickImage(source: imagesource);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (e) {
      alertBox.CustomAlertBox(context, 'Image is not Able to Upload');
      print(e.toString());
    }
  }
  //

  addItem() async {
    if (pickedImage != null && item.text != '' && price.text != '') {
      final id = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('itemPhoto').child(id);
      final UploadTask task = firebaseStorageRef.putFile(pickedImage!);
      final downloadUrl = await (await task).ref.getDownloadURL();
      Map<String, dynamic> additem = {
        'Image': downloadUrl,
        'Name': item.text.trim(),
        'Price': price.text.trim(),
      };
      await addFoodItem(additem, _selectedRole!).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color.fromARGB(255, 250, 229, 112),
            content: Text(
              ' Item Added Successfully',
              style: TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 27, 30, 37)),
            )));
      }).then((value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Additem();
        }));
      });
    }
  }

  addFoodItem(Map<String, dynamic> userInfoMap, String name) async {
    return FirebaseFirestore.instance.collection(name).add(userInfoMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 250, 229, 112),
          title: Text('ADD ITEM HERE..'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ADD ITEM PHOTO HERE',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 5,
                ),

                InkWell(
                    onTap: () {
                      print('hi');
                      showAlertBox();
                    },
                    child: pickedImage != null
                        ? Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 27, 30, 37),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(pickedImage!,
                                      fit: BoxFit.cover)),
                            ))
                        : Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 27, 30, 37),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(Icons.camera_alt_outlined),
                            ))),

                SizedBox(
                  height: 5,
                ),
                Textfield(
                  Controller: item,
                  suffixIcon: Icons.text_snippet,
                  lable: 'Enter Name Of Item',
                  hintText: 'Enter Name Of Item',
                  obscureText: false,
                  textInputType: TextInputType.text,
                  obscuringCharacter: '',
                ),
                //
                Textfield(
                  Controller: price,
                  lable: 'Enter Price',
                  hintText: 'Enter Price',
                  suffixIcon: Icons.currency_rupee,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  obscuringCharacter: '',
                ),

                Container(
                  margin: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField(
                      value: _selectedRole,
                      iconSize: 30,
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedRole = newValue!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'Namkeen',
                          child: Text('Namkeen'),
                        ),
                        DropdownMenuItem(
                          value: 'Sweet',
                          child: Text('Sweet'),
                        ),
                        DropdownMenuItem(
                          value: 'Thepla',
                          child: Text('Thepla'),
                        ),
                        // Add more roles as needed
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 250, 229, 112),
                          ),
                        ),
                        labelText: 'Select Category',
                      ),
                    ),
                  ),
                ),
                //
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(blurRadius: 20, color: Colors.black12)
                        ],
                        color: Color.fromARGB(255, 27, 30, 37)),
                    child: Center(
                      child: TextButton(
                          onPressed: () {
                            print('done');
                            addItem();
                          },
                          child: Text(
                            'Add Item',
                            style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 250, 229, 112),
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
