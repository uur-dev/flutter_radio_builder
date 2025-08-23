import 'package:example/extensions/common_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio_builder/flutter_radio_builder.dart';

class CustomCheckboxExampleScreen extends StatelessWidget with CommonScreen {
  CustomCheckboxExampleScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return getScreen(title: title, body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 8, left: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// default checkbox
            CheckBoxBuilder<String>(
              list: options,
              scrollEnabled: false,
              checkBoxStyle: CheckBoxStyle(
                hoverEffect: true,
                hoverEffectFactor: 0.9,
              ),
              builder: (context, item, index, radio, checked) {
                return _buildCheckBox(item, index, radio, checked);
              },
            ),
      
            /// Check box error example
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "Error Example: Only on Even Index",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
      
            ///error example
            CheckBoxBuilder<String>(
              list: options,
      
              errorForItem: (index, value) {
                return (index % 2) == 0;
      
                /// error only on even index
              },
              checkBoxStyle: CheckBoxStyle(isError: true),
              builder: (context, item, index, radio, checked) {
                return _buildCheckBox(item, index, radio, checked);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckBox(String item, int index, Widget radio, bool checked) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: radio,
          title: Text(
            item,
            style: TextStyle(
              fontSize: 16,
              color: Colors.purple,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
