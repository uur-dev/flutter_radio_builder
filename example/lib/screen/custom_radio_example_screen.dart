import 'package:example/extensions/common_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio_builder/flutter_radio_builder.dart';

class CustomRadioExampleScreen extends StatelessWidget with CommonScreen {
  final String title;
  final ValueNotifier<bool> _adativeNotfier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _hoverEffect = ValueNotifier<bool>(false);

  CustomRadioExampleScreen({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return getScreen(title: title, body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Adative Radio"),
                const SizedBox(width: 8),
                ValueListenableBuilder(
                  valueListenable: _adativeNotfier,
                  builder: (context, value, child) =>
                      _buildSwitch(_adativeNotfier),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Hover Effect Radio"),
                const SizedBox(width: 8),
                ValueListenableBuilder(
                  valueListenable: _hoverEffect,
                  builder: (context, value, child) =>
                      _buildSwitch(_hoverEffect),
                ),
              ],
            ),
          ),

          /// Radio Builder
          ValueListenableBuilder(
            valueListenable: _adativeNotfier,
            builder: (context, value, child) => ValueListenableBuilder(
              valueListenable: _hoverEffect,
              builder: (context, value, child) {
                return _buildRadioList(context);
              },
            ),
          ),

          _buidlCustomRadioIconOption(),
        ],
      ),
    );
  }

  Widget _buildRadioList(BuildContext context) {
    return RadioBuilder<String>(
      list: options, // list of items <T> type
      scrollEnabled: false, // disable scrolling,
      radioStyle: RadioStyle(
        isAdaptive: _adativeNotfier.value,
        hoverEffect: _hoverEffect.value,
        hoverEffectFactor: 0.96,
      ),
      builder: (context, item, index, radio, checked) {
        return _buidlRadioCard(item, index, radio, checked);
      },
      onSelectionChanged: (selectedItem, index) {
        /// option selection changed
        print("Radio Option : $selectedItem Selected");
      },
    );
  }

  Widget _buidlRadioCard(String item, int index, Widget radio, bool checked) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: index < 2
              ? radio
              : null, // radio widget (you can place any where you want)
          trailing: index >= 2
              ? radio
              : null, // putting radio on trailing if index >= 2 else on leading
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

  Widget _buildSwitch(ValueNotifier<bool> valueListenable) {
    return Switch(
      value: valueListenable.value,
      onChanged: (value) {
        valueListenable.value = value;
      },
    );
  }

  Widget _buidlCustomRadioIconOption() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 8, left: 16),
          child: Text("Custom Radio Icon"),
        ),
        RadioBuilder<String>(
          list: options,
          selectedIndex: options.length - 1,
          scrollEnabled: false,
          builder: (context, item, index, radio, checked) =>
              _buidlRadioCard(item, index, radio, checked),
          radioIconBuilder: (isChecked) {
            return Icon(
              isChecked ? Icons.check_box : Icons.check_box_outline_blank,
              size: 25,
              color: Colors.purpleAccent,
            );
          },
        ),
      ],
    );
  }
}
