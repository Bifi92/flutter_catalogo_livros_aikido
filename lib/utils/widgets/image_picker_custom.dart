import 'dart:io';

import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerCustomWidget extends StatefulWidget {
  const ImagePickerCustomWidget(
      {required this.usaBotoes, required this.nomeFoto, super.key});

  final bool usaBotoes;

  final String nomeFoto;

  @override
  State<ImagePickerCustomWidget> createState() =>
      _ImagePickerCustomWidgetState();
}

class _ImagePickerCustomWidgetState extends State<ImagePickerCustomWidget> {
  String _imagemUrl = '';
  var storage = FirebaseStorage.instance;

  @override
  initState() {
    super.initState();
    initImage();
  }

  initImage() async {
    try {
      String imageUrl = await storage
          .ref()
          .child('/Imagem/${widget.nomeFoto}.jpg')
          .getDownloadURL();

      setState(() {
        _imagemUrl = imageUrl;
      });
    } catch (e) {
      setState(() {
        _imagemUrl = '';
      });
    }
  }

  Future<void> _getImage() async {
    XFile? imagemMobile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (imagemMobile == null) return;

    TaskSnapshot snapshot = await storage
        .ref()
        .child('/Imagem/${widget.nomeFoto}.jpg')
        .putFile(File(imagemMobile.path));
    if (snapshot.state == TaskState.success) {
      String url = await snapshot.ref.getDownloadURL();
      setState(() {
        _imagemUrl = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _imagemUrl == ''
              ? const Icon(
                  Icons.camera_alt,
                  size: 300,
                )
              : Image.network(
                  _imagemUrl,
                  height: 300,
                  fit: BoxFit.fitHeight,
                ),
        ),
        widget.usaBotoes
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: _getImage, child: const Text(L_CARREGAR_IMAGEM)),
              )
            : Container(),
      ],
    );
  }
}
