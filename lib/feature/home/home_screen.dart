import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf_test/core/models/fake_model.dart';
import 'package:pdf_test/core/models/product_model.dart';
import 'package:pdf_test/service/invoice_service.dart';
import 'package:pdf_test/service/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final InvoiceService invoiceService = InvoiceService();
  int number = 1;

  @override
  void initState() {
    super.initState();
    if (!Platform.isMacOS) initCheckPermission();
  }

  void initCheckPermission() async {
    final _handler = PermissionsService();
    await _handler.requestPermission(
      Permission.storage,
      onPermissionDenied: () => setState(
        () => debugPrint("Error: "),
      ),
    );

    await _handler.requestPermission(
      Permission.manageExternalStorage,
      onPermissionDenied: () => setState(
        () => debugPrint("Error: "),
      ),
    );
  }

  final FakeModel fakeModel = FakeModel(
    productModel: List.generate(
      100,
      (index) => index.isOdd
          ? const ProductModel(
              productName: "Laptop",
              price: 1200.50,
              qqs: 180.08,
              productInfo: "16GB RAM",
            )
          : const ProductModel(
              productName: "Smartphone",
              price: 800.00,
              qqs: 120.00,
              productInfo: "128GB storage",
            ),
    ),
    image: "https://frag.gg/uploads/category/429/original/1703247698.png",
    createdAt: DateTime.now(),
    companyName: "Tech Solutions Ltd.",
    companyAddress: "123 Main Street, Silicon Valley, CA",
    snCode: "SN12345",
    customer: "John Doe",
    totalPrice: 2000.50,
    totalQQS: 300.08,
    stir: 123456789,
    id: 1,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(31, 170, 170, 170),
        title: const Text('Invoice'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              print('11111111111111');
              try {
                final data = await invoiceService.createInvoice(fakeModel);
                print('ishladi 222222222222222');
                // invoiceService.saveDocument('invoice_$number', data);
                number++;
                print('chiqib ketdi 333333');
              } catch (e) {
                print('Error: $e');
              }
            },
            icon: const Icon(CupertinoIcons.cloud_download),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10,
        ),
        child: Column(
          children: [
            Image.network(
              fakeModel.image,
              width: size.width * 0.8,
              height: size.height * 0.2,
            ),
            Text(
              fakeModel.companyName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Text(
              fakeModel.companyAddress,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('STIR:${fakeModel.stir}'),
                Text('S/N: STS-${fakeModel.snCode}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('KASSIR:${fakeModel.customer}'),
                Text('POS N ${fakeModel.id}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('SAVDO CHEKI:${fakeModel.id}'),
                Text(
                  DateFormat('dd/MM/yyyy HH:mm:ss').format(fakeModel.createdAt),
                ),
              ],
            ),
            const Text(
              '---------------------------------------',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200),
            ),
            Expanded(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const Text(
                  '---------------------------------------',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200),
                ),
                itemCount: fakeModel.productModel.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            fakeModel.productModel.elementAt(index).productName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${fakeModel.productModel.elementAt(index).price} USD',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('sh.j QQS 12%'),
                          Text(
                              '${fakeModel.productModel.elementAt(index).qqs}'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Product Info'),
                          Text(
                            fakeModel.productModel.elementAt(index).productInfo,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            const Text(
              '---------------------------------------',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'HAMMASI:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${fakeModel.totalPrice} USD',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tuzatish QQS:'),
                Text('-${fakeModel.totalQQS}'),
              ],
            ),
            const Text(
              '---------------------------------------',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ),
    );
  }
}
