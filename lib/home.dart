import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insighted2/campusPage.dart';
import 'sholarshipPage.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarCustom(
        screenWidth: screenWidth,
      ),
      body: Body(
        screenWidth: screenWidth,
      ),
      floatingActionButton: CustomeFloatingButton(),
      backgroundColor: const Color(0xFFF0F8FE),
    );
  }
}

class CustomeFloatingButton extends StatefulWidget {
  const CustomeFloatingButton({super.key});

  @override
  State<CustomeFloatingButton> createState() => _CustomeFloatingButtonState();
}

class _CustomeFloatingButtonState extends State<CustomeFloatingButton> {
  int index = 0;

  void updateIndex(int angka) {
    setState(() {
      index = angka; // Pastikan setState memicu pembaruan UI
    });
  }

  final List<Widget> pageAdd = [
    const addCampus(),
    const addScholarship(),
  ];

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
          ),
          builder: (context) {
            return DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.5,
              maxChildSize: 0.9,
              snap: true,
              snapSizes: const [0.5, 0.9],
              expand: false,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 0,
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18),
                                ),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.only(top: 5),
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 30),
                                        decoration: const BoxDecoration(
                                          color: Colors.black45,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18)),
                                        ),
                                        child: const SizedBox(
                                          width: 100,
                                          height: 5,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: SizedBox(
                                        width: 240,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                updateIndex(0);
                                                print(index);
                                              },
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Campus',
                                                    style: TextStyle(
                                                      color: index == 0
                                                          ? Colors.blue
                                                          : Colors.black,
                                                      fontWeight: index == 0
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                    ),
                                                  ),
                                                  if (index == 0)
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      height: 2,
                                                      width: 60,
                                                      color: Colors.blue,
                                                    ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                updateIndex(1);
                                                print(index);
                                              },
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Scholarship',
                                                    style: TextStyle(
                                                      color: index == 1
                                                          ? Colors.blue
                                                          : Colors.black,
                                                      fontWeight: index == 1
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                    ),
                                                  ),
                                                  if (index == 1)
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 4),
                                                      height: 2,
                                                      width: 60,
                                                      color: Colors.blue,
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                            // Bagian ini di-comment karena Anda tidak memerlukan perbaikan di sini.
                            // Expanded(
                            //   child: Container(
                            //     padding: const EdgeInsets.symmetric(
                            //         horizontal: 16, vertical: 10),
                            //     decoration: const BoxDecoration(
                            //       color: Colors.white,
                            //     ),
                            //     child: ListView(
                            //       children: [
                            //         pageAdd[index],
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

class addCampus extends StatefulWidget {
  const addCampus({super.key});

  @override
  State<addCampus> createState() => _addCampusState();
}

class _addCampusState extends State<addCampus> {
  File? _imageLogo;
  File? _imageCampus;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _akreditasiController = TextEditingController();

  Future<void> _pickLogoImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageLogo = File(image.path);
      });
    }
  }

  Future<void> _pickCampusImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageCampus = File(image.path);
      });
    }
  }

  Future<String?> _uploadImageToStorage(File imageFile) async {
    try {
      // Generate a unique file name based on the current timestamp
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      // Create a reference to Firebase Storage
      Reference storageReference =
          FirebaseStorage.instance.ref().child('$fileName');
      // Upload the file to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(imageFile);
      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      // Get the download URL of the uploaded image
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Failed to upload image: $e");
      return null;
    }
  }

  void _uploadData() async {
    if (_imageLogo != null &&
        _nameController != '' &&
        _akreditasiController != '' &&
        _lokasiController != '' &&
        _imageCampus != null) {
      String? imageLogoUrl = await _uploadImageToStorage(_imageLogo!);
      String? imageCampusUrl = await _uploadImageToStorage(_imageCampus!);
      if (imageLogoUrl != null && imageCampusUrl != null) {
        CollectionReference campus =
            FirebaseFirestore.instance.collection('campus');

        // Menambahkan data baru ke Firestore
        await campus.add({
          'nama': _nameController.text,
          'lokasi': _lokasiController.text,
          'akreditasi': _akreditasiController.text,
          'foto': imageCampusUrl,
          'logo': imageLogoUrl
        }).then((value) {
          Fluttertoast.showToast(msg: 'berhasil');
          Navigator.pop(context);
          return;
        }).catchError((error) =>
            Fluttertoast.showToast(msg: "Failed to add user: $error"));
      } else {
        Fluttertoast.showToast(msg: 'Failed to upload image');
      }
    } else {
      Fluttertoast.showToast(msg: 'Please field all column');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _pickLogoImage,
          child: const Text('Upload logo Image'),
        ),
        const SizedBox(height: 20),
        _imageLogo != null
            ? Image.file(
                _imageLogo!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              )
            : const Text('No image selected'),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _pickCampusImage,
          child: const Text('Upload campus Image'),
        ),
        const SizedBox(height: 20),
        _imageCampus != null
            ? Image.file(
                _imageCampus!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              )
            : const Text('No image selected'),
        const SizedBox(height: 20),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Nama',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _lokasiController,
          decoration: const InputDecoration(
            labelText: 'lokasi',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _akreditasiController,
          decoration: const InputDecoration(
            labelText: 'akreditasi',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _uploadData();
                // Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ),
        ),
      ],
    );
  }
}

class addScholarship extends StatefulWidget {
  const addScholarship({super.key});

  @override
  State<addScholarship> createState() => _addScholarshipState();
}

class _addScholarshipState extends State<addScholarship> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _deskController = TextEditingController();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<String?> _uploadImageToStorage(File imageFile) async {
    try {
      // Generate a unique file name based on the current timestamp
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      // Create a reference to Firebase Storage
      Reference storageReference =
          FirebaseStorage.instance.ref().child('$fileName');
      // Upload the file to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(imageFile);
      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      // Get the download URL of the uploaded image
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Failed to upload image: $e");
      return null;
    }
  }

  void _uploadData() async {
    if (_image != null &&
        _nameController.text != '' &&
        _deskController.text != '') {
      String? imageUrl = await _uploadImageToStorage(_image!);
      if (imageUrl != null) {
        CollectionReference scholarsip =
            FirebaseFirestore.instance.collection('scholarship');

        // Menambahkan data baru ke Firestore
        await scholarsip.add({
          'nama': _nameController.text,
          'desk': _deskController.text,
          'gambar': imageUrl,
        }).then((value) {
          Fluttertoast.showToast(msg: 'berhasil');
          Navigator.pop(context);
          return;
        }).catchError((error) =>
            Fluttertoast.showToast(msg: "Failed to add user: $error"));
      } else {
        Fluttertoast.showToast(msg: 'Failed to upload image');
      }
    } else {
      Fluttertoast.showToast(msg: 'Please field all form');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('Upload Image'),
        ),
        const SizedBox(height: 20),
        _image != null
            ? Image.file(
                _image!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              )
            : const Text('No image selected'),
        const SizedBox(height: 20),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Nama',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _deskController,
          decoration: const InputDecoration(
            labelText: 'Desk',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _uploadData();
                // Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ),
        ),
      ],
    );
  }
}

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final double screenWidth;
  const AppBarCustom({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'hello,',
                style: TextStyle(fontSize: 20, color: Color(0xFFB3B3B3)),
              ),
              Text(
                'fitz 👋',
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              popup(context);
            },
            icon: const Icon(Icons.account_circle_rounded),
            iconSize: 63,
            padding: EdgeInsets.zero,
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 29);

  void popup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: screenWidth,
          height: 250,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle_rounded,
                size: 60,
              ),
              SizedBox(height: 10),
              Text(
                'Logout',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Body extends StatelessWidget {
  final double screenWidth;
  const Body({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Campus',
                      style: TextStyle(fontSize: 32),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CampusPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'view all',
                        style: TextStyle(
                          color: Color(0xFFB3B3B3),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('campus')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }

                          final data = snapshot.requireData;

                          return Row(
                            children: data.docs.map((campus) {
                              return CampusList(
                                nama: campus['nama'],
                                lokasi: campus['lokasi'],
                                akreditasi: campus['akreditasi'],
                                foto: campus['foto'],
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Scholarship',
                      style: TextStyle(fontSize: 32),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ScholarshipPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'view all',
                        style: TextStyle(
                          color: Color(0xFFB3B3B3),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('scholarship')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          final data = snapshot.requireData;

                          return Column(
                            children: data.docs.map((scholarship) {
                              return ScholarshipList(
                                screenWidth: screenWidth,
                                desk: scholarship['desk'],
                                foto: scholarship['gambar'],
                                nama: scholarship['nama'],
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CampusList extends StatelessWidget {
  const CampusList({
    super.key,
    required this.akreditasi,
    required this.foto,
    required this.lokasi,
    required this.nama,
  });

  final String nama;
  final String foto;
  final String akreditasi;
  final String lokasi;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: Color(0xFF1D5D9B),
      ),
      width: 218,
      height: 245,
      child: Column(
        children: [
          Image.network(
            foto,
            width: 206,
            height: 152,
            // fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              nama,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Image.asset('assets/lokasi.png'),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        lokasi,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Image.asset('assets/star.png'),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        akreditasi,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ScholarshipList extends StatelessWidget {
  const ScholarshipList({
    super.key,
    required this.screenWidth,
    required this.desk,
    required this.foto,
    required this.nama,
  });

  final String nama;
  final String desk;
  final String foto;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: Row(
        children: [
          Image.network(
            foto,
            width: 194,
            height: 194,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
            loadingBuilder: (context, child, progress) {
              if (progress == null) {
                return child;
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                ),
                SizedBox(
                  width: screenWidth - 250,
                  height: 165,
                  child: Text(
                    desk,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
