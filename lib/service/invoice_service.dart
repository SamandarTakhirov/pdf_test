import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf_test/core/models/fake_model.dart';
import 'package:http/http.dart' as http;
import 'package:open_document/my_files/init.dart';

import 'pdf_api.dart';

class InvoiceService {
  Future<Uint8List> fetchImage(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception("Failed to load image");
    }
  }

  Future<Future<File>> createInvoice(FakeModel fakeModel) async {
    final pdf = Document();
    final image = await fetchImage(fakeModel.image);

    pdf.addPage(
      MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) => [
                Center(
                  child: SizedBox(
                    width: 1000,
                    height: 3000,
                    child: Column(
                      children: [
                        Image(
                          MemoryImage(image),
                          width: 150,
                          height: 150,
                        ),
                        Text(
                          fakeModel.companyName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          fakeModel.companyAddress,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
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
                            Text('${fakeModel.createdAt}'),
                          ],
                        ),
                        Text(
                          '---------------------------------------',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Text(
                              '---------------------------------------',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.normal),
                            ),
                            itemCount: fakeModel.productModel.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        fakeModel.productModel
                                            .elementAt(index)
                                            .productName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        '${fakeModel.productModel.elementAt(index).price} USD',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('sh.j QQS 12%'),
                                      Text(
                                          '${fakeModel.productModel.elementAt(index).qqs}'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Product Info'),
                                      Text(
                                        fakeModel.productModel
                                            .elementAt(index)
                                            .productInfo,
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Text(
                          '---------------------------------------',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.normal),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'HAMMASI:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${fakeModel.totalPrice} USD',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tuzatish QQS:'),
                            Text('-${fakeModel.totalQQS}'),
                          ],
                        ),
                        Text(
                          '---------------------------------------',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
          footer: (context) {
            final text = 'Page ${context.pageNumber} of ${context.pagesCount}';
            return Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(top: 1 * PdfPageFormat.cm),
              child: Text(
                text,
                style: TextStyle(
                  color: PdfColors.black,
                ),
              ),
            );
          }),
    );
    return PdfApi.saveDocument(name: 'my_example.pdf', pdf: pdf);
    // return await pdf.save();
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
