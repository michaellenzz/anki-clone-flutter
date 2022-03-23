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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.upload),
        onPressed: () {
          CardController cc = Get.put(CardController());

          if (image != null) {
            //File file = File(image!.path);
            Uint8List uint8list =
                Uint8List.fromList(File(image!.path).readAsBytesSync());
            Cartao c = Cartao();
            c.isImage = 1;
            c.backImage = uint8list;
            c.frontImage = uint8list;
            c.proxRevisao = DateTime.now().toString();
            c.nivel = 0;
            c.fkDeck = widget.snapshot.idDeck;

            cc.addCards(c);
          }
        },
      ),
      appBar: AppBar(
        title: Text(widget.snapshot.nameDeck),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                image = await _picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  initBackground();
                });
              },
              icon: const Icon(Icons.photo))
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            child: FlutterPainter(
              controller: controller,
              onDrawableCreated: (value) {
                //print(value);
              },
            ),
          ),
          //SizedBox(height: height,)
        ],
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () async {
                controller.shapeFactory =
                    RectangleFactory(borderRadius: BorderRadius.circular(3));
              },
              child: const Text('Retangulo')),
          TextButton(
              onPressed: () async {
                controller.undo();
              },
              child: const Text('Desfazer')),
          TextButton(
              onPressed: () async {
                final selectedDrawable = controller.selectedObjectDrawable;
                if (selectedDrawable != null) {
                  controller.removeDrawable(selectedDrawable);
                }
              },
              child: const Text('Apagar')),
          TextButton(
              onPressed: () async {
                renderImage();
              },
              child: const Text('Renderizar')),
        ],
      ),
    );
  }

  void renderImage() async {
    if (backgroundImage == null) return;
    final backgroundImageSize = Size(
        backgroundImage!.width.toDouble(), backgroundImage!.height.toDouble());

    for (var element in controller.drawables) {
      //variaveis
      var frontImage; //card com retangulo vermelho
      var backImage; //card sem retangulo

      //seleciona o objeto para poder fazer as modificações
      controller.selectObjectDrawable(element as ObjectDrawable);
      //pega o objeto selecionado
      final selectedDrawable = controller.selectedObjectDrawable;
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

      //aqui removemos o temporariamento o retangulo
      controller.removeDrawable(selectedDrawable);
      //renderiza a imagem sem o retangulo
      backImage = await controller
          .renderImage(backgroundImageSize)
          .then<Uint8List?>((ui.Image image) => image.pngBytes);

      //colocamos a imagem na tela novamente usando undo()
      controller.undo();
      controller.undo();
      //removemos a seleção da imagem
      controller.deselectObjectDrawable();
      print(backImage);
    }
  }
}
