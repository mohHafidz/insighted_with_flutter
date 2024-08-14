import 'package:flutter/material.dart';

class Psikolog extends StatelessWidget {
  const Psikolog({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFF0F8FE),
      body: Body(),
    ));
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Start conversation!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: 57,
            width: 370,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(17)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none, // Menghilangkan border default
                      hintText: 'Search',
                    ),
                  ),
                ),
                Icon(Icons.search),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Psikolog',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
              child: ListView(
            children: [
              ListPsikolog(),
              ListPsikolog(),
              ListPsikolog(),
              ListPsikolog(),
              ListPsikolog(),
              ListPsikolog(),
              ListPsikolog(),
              ListPsikolog(),
              ListPsikolog(),
            ],
          ))
        ],
      ),
    );
  }
}

class ListPsikolog extends StatelessWidget {
  const ListPsikolog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            height: 82,
            width: 108,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(71)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(71),
              child: Image.asset(
                'assets/psikolog.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dr. Shindy Claudya Aprianti',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Text(
                'Dokter Umum',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              Row(
                children: [
                  IntrinsicWidth(
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.card_travel_rounded,
                            size: 12,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text('11 Tahun'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  IntrinsicWidth(
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_up_off_alt_sharp,
                            size: 12,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text('95%'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rp 35.000',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  SizedBox(
                    width: 90,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Buy',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF57C3F4)),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
