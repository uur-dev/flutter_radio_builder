import 'package:flutter/material.dart';
import 'package:flutter_radio_builder/widget/base_builder.dart';

typedef CheckBoxBuilderNotifierType = List<int>?;

class CheckBoxBuilder<T>
    extends BaseRadioBuilder<T, CheckBoxBuilderNotifierType> {
  const CheckBoxBuilder({
    super.key,
    required super.list,
    super.allowMultiSelection = true,
    List<int>? selectedItems,
    this.checkBoxStyle,
    super.builder,
    super.padding,
    super.margin,
    super.scrollEnabled = false,
    super.scrollDirection = Axis.vertical,
    super.scrollController,
    super.isPrimary,
    super.defaultTextStyle,
    super.optionTextBuilder,
    super.onSelectionChanged,
    super.radioIconBuilder,
    this.onSelectedItemsChanged,
    this.errorForItem
  }) : super(selectedItemIndexes: selectedItems);

  static RadioController<CheckBoxBuilderNotifierType> newController({
    CheckBoxBuilderNotifierType initialValue,
  }) {
    return RadioController<CheckBoxBuilderNotifierType>(
      initialValue: initialValue,
    );
  }

  final CheckBoxStyle? checkBoxStyle;

  /// selected items changed
  final void Function(List<int> selectedItems)? onSelectedItemsChanged;

  /// have error for inder
  final bool Function(int index, T value)? errorForItem;

  @override
  BaseRadioStyle get controlStyle => checkBoxStyle ?? CheckBoxStyle();

  void _onSelectionChanges(
    bool? value,
    int index,
    Function(int? index) onSelectionChanged,
    bool isChecked,
  ) {
    onSelectionChanged(index);

    if (onSelectedItemsChanged != null) {
      List<int> initialChekedItems = selectedItemIndexes ?? [];
      final indexExist = initialChekedItems.contains(index);
      if (indexExist && isChecked) {
        onSelectedItemsChanged!(initialChekedItems);
      } else if (isChecked) {
        initialChekedItems.add(index);
        onSelectedItemsChanged!(initialChekedItems);
      } else {
        initialChekedItems.remove(index);
        onSelectedItemsChanged!(initialChekedItems);
      }
    }
  }

  @override
  Widget getRadioWidget({
    required int index,
    required bool isChecked,
    required Function(int? index) onSelectionChanged,
    required ValueNotifier<List<int>?> notifier,
  }) {
    final style = controlStyle as CheckBoxStyle;
    final isError = style.isError && (errorForItem != null ? errorForItem!(index, list[index]) : false);
    late Widget widgetToReturn;
    if (radioIconBuilder != null) {
      widgetToReturn = radioIconBuilder!(isChecked);
    } else if (style.isAdaptive) {
      widgetToReturn = Checkbox.adaptive(
        value: isChecked,
        onChanged: (value) =>
            _onSelectionChanges(value, index, onSelectionChanged, isChecked),
        tristate: style.tristate,
        checkColor: style.checkColor,
        overlayColor: style.overlayColor,
        side: style.side,
        shape: style.shape,
        isError: isError,
        fillColor: style.fillColor,
        splashRadius: style.splashRadius,
        focusColor: style.focusColor,
        activeColor: style.activeColor,
        autofocus: style.autofocus,
        materialTapTargetSize: style.materialTapTargetSize,
        mouseCursor: style.mouseCursor,
        hoverColor: style.hoverColor,
        focusNode: style.focusNode,
        visualDensity: style.visualDensity,
      );
    } else {
      widgetToReturn = Checkbox(
        value: isChecked,
        onChanged: (value) =>
            _onSelectionChanges(value, index, onSelectionChanged, isChecked),
        tristate: style.tristate,
        checkColor: style.checkColor,
        overlayColor: style.overlayColor,
        side: style.side,
        shape: style.shape,
        isError: isError,
        fillColor: style.fillColor,
        splashRadius: style.splashRadius,
        focusColor: style.focusColor,
        activeColor: style.activeColor,
        autofocus: style.autofocus,
        materialTapTargetSize: style.materialTapTargetSize,
        mouseCursor: style.mouseCursor,
        hoverColor: style.hoverColor,
        focusNode: style.focusNode,
        visualDensity: style.visualDensity,
      );
    }

    return radioSemanticLabel != null
        ? Semantics(label: radioSemanticLabel, child: widgetToReturn)
        : widgetToReturn;
  }

  @override
  RadioController<CheckBoxBuilderNotifierType?> getController() {
    return CheckBoxBuilder.newController(initialValue: selectedItemIndexes);
  }

  @override
  CheckBoxBuilderNotifierType? getNofifierNewValue({
    required int index,
    required bool isChecked,
    required CheckBoxBuilderNotifierType? notifierValue,
  }) {
    final List<int> selectedItems = List<int>.from(notifierValue ?? []);

    if (selectedItems.contains(index)) {
      selectedItems.remove(index); // uncheck
    } else {
      selectedItems.add(index); // check
    }

    return selectedItems; // new list reference
  }
}

class CheckBoxStyle extends BaseRadioStyle {
  final bool? value;
  final bool tristate;
  final ValueChanged<bool?>? onChanged;
  final MouseCursor? mouseCursor;
  final Color? activeColor;
  final WidgetStateProperty<Color?>? fillColor;
  final Color? checkColor;
  final Color? focusColor;
  final Color? hoverColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;
  final FocusNode? focusNode;
  final bool autofocus;
  final OutlinedBorder? shape;
  final BorderSide? side;
  final bool isError;

  CheckBoxStyle({
    super.isAdaptive = false,
    super.space,
    super.hoverEffect,
    super.hoverEffectFactor = 1.1,

    // matching Checkbox.adaptive params
    this.value,
    this.tristate = false,
    this.onChanged,
    this.mouseCursor,
    this.activeColor,
    this.fillColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
    this.isError = false,
  });
}
