import 'package:example/extensions/common_screen.dart';
import 'package:example/models/menu.dart';
import 'package:example/screen/custom_checkbox_example_screen.dart';
import 'package:example/screen/custom_radio_example_screen.dart';
import 'package:example/screen/simple_radio_example_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio_builder/flutter_radio_builder.dart';

class ExampleMenuScreen extends StatelessWidget with CommonScreen {
  ExampleMenuScreen({super.key, required this.title});

  final String title;
  final List<Menu> _menuList = RadioMenu.getRadioBuilderMenu();

  final List<String> _bottomSheetOptions = const [
    "Bottom Sheet Item 1",
    "Bottom Sheet Item 2",
    "Bottom Sheet Item 3",
    "Bottom Sheet Item 4",
    "Bottom Sheet Item 5",
    "Bottom Sheet Item 6",
    "Bottom Sheet Item 7",
    "Bottom Sheet Item 8",
    "Bottom Sheet Item 9",
    "Bottom Sheet Item 10",
    "Bottom Sheet Item 11",
    "Bottom Sheet Item 12",
  ];

  @override
  Widget build(BuildContext context) {
    return getScreen(title: title, body: _buildBody(context), includeWaterMark: true);
  }

  Widget _buildBody(BuildContext context) {
    return ListView.builder(
      itemCount: _menuList.length,
      itemBuilder: (context, index) {
        final item = _menuList[index];
        return ListTile(
          leading: Text(
            "#${(index + 1).toString()}",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.deepPurple,
            ),
          ),
          title: Text(
            item.title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.deepPurple,
            ),
          ),
          subtitle: item.description != null && item.description!.isNotEmpty
              ? Text(
                  item.description!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey,
                  ),
                )
              : null,
          onTap: () => _onItemSelection(context, item, index),
        );
      },
    );
  }

  void _onItemSelection(BuildContext context, Menu menu, int index) {
    switch (index) {
      case 0:
        navigatePage(
          context: context,
          page: SimpleRadioExampleScreen(title: menu.title),
        );
        break;
      case 1:
        navigatePage(
          context: context,
          page: CustomRadioExampleScreen(title: menu.title),
        );
        break;
      case 2:
        navigatePage(
          context: context,
          page: CustomCheckboxExampleScreen(title: menu.title),
        );
        break;
      case 3:
        _showBottomSheet(
          context,
          builder: (controller) {
            return RadioBuilder<String>(
              list: _bottomSheetOptions,
              scrollController: controller,
              scrollEnabled: true,
              optionTextBuilder: (item, index) => item,
              defaultTextStyle: TextStyle(fontSize: 16),
            );
          },
        );
        break;
      case 4:
        _showBottomSheet(
          context,
          builder: (controller) {
            return CheckBoxBuilder<String>(
              list: _bottomSheetOptions,
              scrollController: controller,
              scrollEnabled: true,
              optionTextBuilder: (item, index) => item,
              defaultTextStyle: TextStyle(fontSize: 16),
            );
          },
        );
        break;
      default:

      /// do nothing
    }
  }

  void _showBottomSheet(
    BuildContext context, {
    required Widget Function(ScrollController controller) builder,
  }) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.6,
          minChildSize: 0.2,
          initialChildSize: 0.2,
          builder: (context, scrollController) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: builder(scrollController));
          },
        );
      },
    );

    return;
  }
}
