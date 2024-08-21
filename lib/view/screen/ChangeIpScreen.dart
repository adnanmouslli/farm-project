import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth/login_controler.dart';

class ChangeIpScreen extends StatelessWidget {
  final TextEditingController ipController = TextEditingController();

  ChangeIpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Server IP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: ipController,
              decoration: InputDecoration(
                labelText: 'Enter new IP address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String newIp = ipController.text.trim();
                if (newIp.isNotEmpty) {
                  Get.find<LoginControlerImp>().updateServerIp(newIp);
                  Get.back();
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
