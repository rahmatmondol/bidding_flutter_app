import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/provder_add_service_controller.dart';

class ProvderAddServiceView extends GetView<ProvderAddServiceController> {
  const ProvderAddServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provder Add Service View'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProvderAddServiceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
