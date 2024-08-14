import 'package:flutter/material.dart';

class Soal extends StatelessWidget {
  const Soal({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Body(),
      backgroundColor: Color(0xffADE3FC),
    ));
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: EdgeInsets.all(25),
          padding: EdgeInsets.all(16),
          width: 326,
          height: 646,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(17)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Questionnaire For Major',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                height: 1,
                color: Colors.black.withOpacity(0.2),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Total Question',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '80',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Time Limit',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'There is no time limit',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  height: 289,
                  width: 234,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color(0xffF0F8FE)),
                  child: Column(
                    children: [
                      Text(
                        'Questionnaire Description',
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 189.81,
                        child: Text(
                          'Kuisioner ini akan memberikan beberapa pertanyaan mengenai kehidupan sehari - hari dan juga mengenai hal apa yang anda suka lakukan. Dengan tujuan agar dapat memberikan hasil rekomendasi yang sesuai dengan apa yang anda minati. Dalam kuisioner ini tidak akan mempertanyakan pertanyaan yang sangat personal.',
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Start',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFF57C3F4))),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
