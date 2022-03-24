import 'dart:io';
import 'dart:typed_data';
import 'package:anki_clone/controllers/card_controller.dart';
import 'package:anki_clone/database/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

class AddCardImage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snapshot;
  const AddCardImage(this.snapshot, {Key? key}) : super(key: key);

  @override
  _AddCardImageState createState() => _AddCardImageState();
}

class _AddCardImageState extends State<AddCardImage> {
  SQFlite helper = SQFlite();
  XFile? image;
  PainterController controller = PainterController();
  ui.Image? backgroundImage;
  Paint shapePaint = Paint()
    ..color = Colors.orange
    ..style = PaintingStyle.fill;

  @override
  void initState() {
    super.initState();
    controller = PainterController(
        settings: PainterSettings(
      shape: ShapeSettings(paint: shapePaint, drawOnce: false),
    ));

    //initBackground();
  }

  void initBackground() async {
    // Extension getter (.image) to get [ui.Image] from [ImageProvider]
    final image3 = await FileImage(
      File(image!.path),
    ).image;

    setState(() {
      backgroundImage = image3;

      controller.background = image3.backgroundDrawable;
      print(backgroundImage!.width.toDouble());
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.snapshot.nameDeck),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                image = await _picker.pickImage(
                  source: ImageSource.gallery,
                  maxHeight: 1000,
                  maxWidth: 1000,
                  imageQuality: 70,
                );
                setState(() {
                  initBackground();
                });
              },
              icon: const Icon(Icons.photo))
        ],
      ),
      body: FittedBox(
        fit: BoxFit.cover,
        child: Container(
          alignment: Alignment.center,
          width: backgroundImage == null ? width : backgroundImage!.width.toDouble(),
          height: backgroundImage == null ? height : backgroundImage!.height.toDouble(),
          child: FlutterPainter(
            controller: controller,
          ),
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              controller.shapeFactory =
                  RectangleFactory(borderRadius: BorderRadius.circular(3));
            },
            icon: const Icon(Icons.format_shapes_outlined),
          ),
          IconButton(
            onPressed: () async {
              controller.undo();
            },
            icon: const Icon(Icons.undo),
          ),
          IconButton(
              onPressed: () async {
                final selectedDrawable = controller.selectedObjectDrawable;
                if (selectedDrawable != null) {
                  controller.removeDrawable(selectedDrawable);
                }
              },
              icon: const Icon(Icons.delete)),
          Container(
            height: 35,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(5)),
            child: TextButton(
                onPressed: () async {
                  renderImage();
                },
                child: const Text(
                  'add cards',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
          ),
        ],
      ),
    );
  }

  void renderImage() async {
    
    if (backgroundImage == null || controller.drawables.isEmpty) return;
    _showMyDialog();
    final backgroundImageSize = Size(
        backgroundImage!.width.toDouble(), backgroundImage!.height.toDouble());

    for (var element in controller.drawables) {
      //variaveis
      // ignore: prefer_typing_uninitialized_variables
      var frontImage; //card com retangulo vermelho
      // ignore: prefer_typing_uninitialized_variables
      var backImage; //card sem retangulo

      //seleciona o objeto para poder fazer as modificações
      controller.selectObjectDrawable(element as ObjectDrawable);
      //pega o objeto selecionado
      var selectedDrawable = controller.selectedObjectDrawable;

      //aqui removemos o temporariamento o retangulo
      controller.removeDrawable(selectedDrawable!);

      //renderiza a imagem sem o retangulo
      backImage = await controller
          .renderImage(backgroundImageSize)
          .then<Uint8List?>((ui.Image image) => image.pngBytes);

      //colocamos a imagem na tela novamente usando undo()
      controller.undo();

      //seleciona o objeto novamente para poder fazer as modificações
      controller.selectObjectDrawable(element);
      //pega o objeto selecionado novamente
      selectedDrawable = controller.selectedObjectDrawable;

      //aqui substituimos o retangulo selecionado por outro de outra cor
      var paint1 = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill;
      controller.replaceDrawable(
          element,
          RectangleDrawable(
              paint: paint1,
              size: selectedDrawable!.getSize(),
              position: selectedDrawable.position));
      //aqui renderizamos a imagem com retangulo vermelho
      frontImage = await controller
          .renderImage(backgroundImageSize)
          .then<Uint8List?>((ui.Image image) => image.pngBytes);

      //colocamos a imagem na tela novamente usando undo()
      controller.undo();

      //removemos a seleção da imagem
      controller.deselectObjectDrawable();
      gravarNoBanco(backImage, frontImage);
      
    }
    controller.clearDrawables();
    controller.background = null;
    Get.back();
  }

  gravarNoBanco(backImage, frontImage) {
    CardController cc = Get.put(CardController());

    if (image != null) {
      //File file = File(image!.path);
      /*Uint8List uint8list =
          Uint8List.fromList(File(image!.path).readAsBytesSync());*/
      Cartao c = Cartao();
      c.isImage = 1;
      c.backImage = backImage;
      c.frontImage = frontImage;
      c.proxRevisao = DateTime.now().toString();
      c.nivel = 0;
      c.fkDeck = widget.snapshot.idDeck;

      cc.addCards(c);
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Gerando cartões, aguarde!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[LinearProgressIndicator()],
            ),
          ),
        );
      },
    );
  }
}
