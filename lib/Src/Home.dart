import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controllerText = TextEditingController();
  final valueNotifierQr = ValueNotifier('');
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.white,
              child: ValueListenableBuilder(
                valueListenable: valueNotifierQr,
                builder: (BuildContext context,String value, _){
                  return QrImage(
                    data: value,
                    version: QrVersions.auto,
                    size: 180,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Form(
              key: formKey,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: controllerText,
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: 'Enter a text or URL',
                ),
                maxLines: 1,
                minLines: 1,
                onFieldSubmitted: (value){
                  CreateQR();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void CreateQR(){
    if(formKey.currentState!.validate()){
      final qrData = controllerText.text.trim();
      valueNotifierQr.value = qrData;
    }
  }
}

