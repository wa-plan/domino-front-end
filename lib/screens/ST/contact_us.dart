import 'package:flutter/material.dart';
import 'package:domino/screens/ST/settings_main.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 20.0, 20.0, 0.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '문의하기',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          backgroundColor: const Color(0xff262626),
        ),
        backgroundColor: const Color(0xff262626),
        body: const Padding(
          padding: EdgeInsets.fromLTRB(38.0, 30.0, 40.0, 0.0),
          child: Row(
            children: [
              Text(
                '이메일',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                width: 130,
              ),
              Text('new7932@naver.com',
                  style: TextStyle(color: Colors.white, fontSize: 16))
            ],
          ),
        ));
  }
}
