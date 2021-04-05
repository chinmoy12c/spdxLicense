import 'package:xml/xml.dart';
import 'dart:io';
import 'dart:convert';

void main() async {
  var request = await HttpClient().getUrl(Uri.parse('https://raw.githubusercontent.com/spdx/license-list-XML/master/src/MIT.xml'));
  var response = await request.close();
  var decoded = response.transform(Utf8Decoder());
  var contents = '';

  await for (var content in decoded) {
    contents += content;
  }

  final license = XmlDocument.parse(contents);

  //Getting all the attributes
  for (var descendant in license.descendants) {
    var attributes = descendant.attributes;
    for (var attribute in attributes) {
      print(attribute);
    }
  }

  print('==========================================');

  //Getting the license text
  var licenseText = '';
  for (var list in license.descendants) {
    if (list is XmlText && list.text.trim().isNotEmpty) {
      licenseText += '\n' + list.text.toString().trim();
    }
  }
  print(licenseText);

  print('=========================================');
}