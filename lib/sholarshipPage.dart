import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ScholarshipPage extends StatelessWidget {
  const ScholarshipPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F8FE),
        appBar: const CustomeAppbar(),
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('scholarship')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: 3, // Misalkan kita tampilkan 5 skeleton
                          itemBuilder: (context, index) =>
                              const LoadingSkeleton(),
                        ),
                      );
                    }

                    final data = snapshot.requireData;

                    return Expanded(
                      child: ListView(
                        children: data.docs.map((scholarship) {
                          return Body(
                            screenWidth: screenWidth,
                            desk: scholarship['desk'],
                            foto: scholarship['gambar'],
                            nama: scholarship['nama'],
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              size: 24,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Scholarship',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class Body extends StatelessWidget {
  const Body({
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
              return Icon(Icons.error);
            },
            loadingBuilder: (context, child, progress) {
              if (progress == null) {
                return child;
              } else {
                return Center(child: CircularProgressIndicator());
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
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                ),
                SizedBox(
                  width: screenWidth - 250,
                  height: 165,
                  child: Text(
                    desk,
                    style: TextStyle(
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

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: 372,
        height: 153,
        decoration: BoxDecoration(
          color: Colors.grey[
              300], // Menggunakan warna dari shimmer sebagai latar belakang.
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Row(
          children: [
            Container(
              width: 144,
              height: 87,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                color: Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 133,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(
                      height: 10), // Menambahkan jarak antara elemen.
                  Container(
                    width: 81,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
