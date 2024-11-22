import 'dart:typed_data';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf_test/core/models/fake_model.dart';
import 'package:http/http.dart' as http;
import 'package:open_document/my_files/init.dart';

class InvoiceService {
  Future<Uint8List> fetchImage(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception("Failed to load image");
    }
  }

  Future<Uint8List> createInvoice(FakeModel fakeModel) async {
    final pdf = pw.Document();
    final image = await fetchImage(fakeModel.image);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Center(
          child: pw.Column(
            children: [
              pw.Image(pw.MemoryImage(image), width: 150, height: 150),
              pw.Text(fakeModel.companyName),
              pw.Text(fakeModel.companyAddress),
            ],
          ),
        ),
      ),
    );

    return await pdf.save();
  }

  Future<void> savedPdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    final filePath = '${output.path}/$fileName.pdf';
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    print('PDF saved at $filePath');
    await OpenDocument.openDocument(filePath: filePath);
  }
}
