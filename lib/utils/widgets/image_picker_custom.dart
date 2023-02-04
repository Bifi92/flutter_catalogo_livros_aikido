import 'dart:io';
import 'package:catalogo_livro_aikido/utils/constantes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagePickerCustomWidget extends StatefulWidget {
  const ImagePickerCustomWidget({
    required this.usaBotoes,
    required this.nomeFoto,
    super.key,
  });

  final bool usaBotoes;

  final String nomeFoto;

  @override
  State<ImagePickerCustomWidget> createState() =>
      _ImagePickerCustomWidgetState();
}

class _ImagePickerCustomWidgetState extends State<ImagePickerCustomWidget> {
  String _imagemUrl = L_VAZIO;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  initState() {
    super.initState();
    initImage();
  }

  void atualizarState(String url) {
    setState(() {
      _imagemUrl = url;
    });
  }

  void initImage() async {
    try {
      String imageUrl = await _storage
          .ref()
          .child(L_CAMINHO_IMAGEM.replaceAll('<NOME>', widget.nomeFoto))
          .getDownloadURL();
      atualizarState(imageUrl);
    } catch (e) {
      atualizarState(L_VAZIO);
    }
  }

  Future<void> _getImage() async {
    XFile? imagemMobile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (imagemMobile == null) return;

    TaskSnapshot snapshot = await _storage
        .ref()
        .child(L_CAMINHO_IMAGEM.replaceAll('<NOME>', widget.nomeFoto))
        .putFile(File(imagemMobile.path));
    if (snapshot.state == TaskState.success) {
      String url = await snapshot.ref.getDownloadURL();
      atualizarState(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _imagemUrl == L_VAZIO
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
                  onPressed: _getImage,
                  child: const Text(L_CARREGAR_IMAGEM),
                ),
              )
            : Container(),
      ],
    );
  }
}
