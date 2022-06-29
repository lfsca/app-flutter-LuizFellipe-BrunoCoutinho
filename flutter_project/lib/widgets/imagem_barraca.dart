import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImagemBarraca extends StatelessWidget {
  const ImagemBarraca({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadImage(url),
        builder: (BuildContext context, AsyncSnapshot<String> image) {
          if (image.hasData) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 300.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(image.data.toString()),
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

Future<String> loadImage(String imagePath) async {
  Reference ref = FirebaseStorage.instance.ref().child(imagePath);
  var url = await ref.getDownloadURL();
  return url;
}
