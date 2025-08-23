import 'package:example/extensions/common_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio_builder/flutter_radio_builder.dart';

class SimeRadioExampleScreen extends StatelessWidget with CommonScreen {
  final String title;
  SimeRadioExampleScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return getScreen(title: title, body: _buildSimpleRadioButtons());
  }

  Widget _buildSimpleRadioButtons() {
    return RadioBuilder<String>(
      list: options, // list of items <T> type
      scrollEnabled: false, // disable scrolling,
      defaultTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.deepPurple,
      ), // label text style
      optionTextBuilder: (item, index) => options[index], // text for label
      onSelectionChanged: (selectedItem, index) {
        /// option selection changed
        print("Radio Option : $selectedItem Selected");
      },
    );
  }
}
