// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_radio_builder/widget/base_builder.dart';

typedef RadioBuilderNotifierType = int?;

class RadioBuilder<T> extends BaseRadioBuilder<T, RadioBuilderNotifierType> {
  RadioBuilder({
    super.key,
    required super.list,
    super.allowMultiSelection = false,
    int? selectedIndex,
    this.radioStyle,
    super.builder,
    super.padding,
    super.margin,
    super.scrollEnabled = true,
    super.scrollDirection = Axis.vertical,
    super.scrollController,
    super.isPrimary,
    super.defaultTextStyle,
    super.optionTextBuilder,
    super.onSelectionChanged,
    super.radioIconBuilder,
  }) : super(
         selectedItemIndexes: selectedIndex != null ? [selectedIndex] : null,
       );

  static RadioController<RadioBuilderNotifierType> newController({
    RadioBuilderNotifierType initialValue,
  }) {
    return RadioController<RadioBuilderNotifierType>(
      initialValue: initialValue,
    );
  }

  RadioStyle? radioStyle;

  @override
  BaseRadioStyle get controlStyle {
    return radioStyle ?? RadioStyle();
  }

  @override
  Widget getRadioWidget({
    required int index,
    required bool isChecked,
    required Function(int? index) onSelectionChanged,
    required ValueNotifier<RadioBuilderNotifierType?> notifier,
  }) {
    final radioStyle = controlStyle as RadioStyle;
    if (radioIconBuilder != null) {
      final radioWidget = radioIconBuilder!(isChecked);
      return radioSemanticLabel != null
          ? Semantics(label: radioSemanticLabel, child: radioWidget)
          : radioWidget;
    } else if (radioStyle.isAdaptive) {
      final radioWidget = Radio.adaptive(
        value: index,
        groupValue: notifier.value,
        onChanged: onSelectionChanged,
        fillColor: radioStyle.fillColor,
        splashRadius: radioStyle.splashRadius,
        focusColor: radioStyle.focusColor,
        activeColor: radioStyle.activeColor,
        autofocus: radioStyle.autofocus,
        toggleable: radioStyle.toggleable,
        materialTapTargetSize: radioStyle.materialTapTargetSize,
        mouseCursor: radioStyle.mouseCursor,
        hoverColor: radioStyle.hoverColor,
        focusNode: radioStyle.focusNode,
        visualDensity: radioStyle.visualDensity,
        useCupertinoCheckmarkStyle: radioStyle.useCupertinoCheckmarkStyle,
      );
      return radioSemanticLabel != null
          ? Semantics(label: radioSemanticLabel, child: radioWidget)
          : radioWidget;
    } else {
      final radioWidget = Radio(
        value: index,
        groupValue: notifier.value,
        onChanged: onSelectionChanged,
        fillColor: radioStyle.fillColor,
        splashRadius: radioStyle.splashRadius,
        focusColor: radioStyle.focusColor,
        activeColor: radioStyle.activeColor,
        autofocus: radioStyle.autofocus,
        toggleable: radioStyle.toggleable,
        materialTapTargetSize: radioStyle.materialTapTargetSize,
        mouseCursor: radioStyle.mouseCursor,
        hoverColor: radioStyle.hoverColor,
        focusNode: radioStyle.focusNode,
        visualDensity: radioStyle.visualDensity,
      );
      return radioSemanticLabel != null
          ? Semantics(label: radioSemanticLabel, child: radioWidget)
          : radioWidget;
    }
  }

  @override
  RadioController<RadioBuilderNotifierType?> getController() {
    return RadioBuilder.newController(initialValue: selectedItemIndexes?.first);
  }

  @override
  RadioBuilderNotifierType? getNofifierNewValue({
    required int index,
    required bool isChecked,
    required RadioBuilderNotifierType? notifierValue,
  }) {
    return index;
  }
}

class RadioStyle extends BaseRadioStyle {
  final MouseCursor? mouseCursor;
  final bool toggleable;
  final Color? activeColor;
  final WidgetStateProperty<Color?>? fillColor;
  final Color? focusColor;
  final Color? hoverColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool useCupertinoCheckmarkStyle;

  RadioStyle({
    super.isAdaptive = false,
    this.mouseCursor,
    this.toggleable = false,
    this.activeColor,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.useCupertinoCheckmarkStyle = false,
    super.space,
    super.hoverEffect,
    super.hoverEffectFactor = 1.1,
  });
}
