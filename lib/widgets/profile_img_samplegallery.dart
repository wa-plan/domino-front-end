import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:domino/screens/MG/mygoal_profile_edit.dart';


void main() => runApp(const MyApp());

class ProfileSampleGallery extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        child: AppBar(),
        preferredSize: Size.fromHeight(0),
            ), 
            backgroundColor: Colors.black,
            body: const Home()
        )
    },

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    return Container(
      width: sizeX,
      height: sizeY,
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        children: createGallery(9),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        padding: const EdgeInsets.all(5.0),
      )
    );
  }

  List<Widget> createGallery(int numImg) {
    List<Widget> images = [];
    List<String> urls = [];
    urls.add('assets/profile_smp1.png');
    urls.add('assets/profile_smp2.png');
    urls.add('assets/profile_smp3.png');
    urls.add('assets/profile_smp4.png');
    urls.add('assets/profile_smp5.png');
    urls.add('assets/profile_smp6.png');
    urls.add('assets/profile_smp7.png');
    urls.add('assets/profile_smp8.png');
    urls.add('assets/profile_smp9.png');

    Widget image;
    int i = 0;
    while (i<numImg) {
      image = Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(urls[i%5]))
        ),
      );
      images.add(image);
      i++;
    }
    return images;
  }
  
}
