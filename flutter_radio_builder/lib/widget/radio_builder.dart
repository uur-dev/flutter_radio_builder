// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RadioBuilder<T> extends StatelessWidget {
  RadioBuilder({
    super.key,
    required this.list,
    this.builder,
    this.padding,
    this.margin,
    this.scrollEnabled = true,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.isPrimary,
    this.defaultTextStyle,
    this.optionTextBuilder,
    this.onSelectionChanged,
    RadioStyle? radioStyle,
    this.radioIconBuilder,
  }) {
    this._radioIndexNotifier = ValueNotifier<int?>(null);
    this.radioStyle = radioStyle ?? RadioStyle();

    if (this.radioStyle.hoverEffect) {
      this._hoverNotifier = ValueNotifier<int?>(null);
    }
  }

  /// radio data
  final List<T> list;

  /// builder used to create each radio element (custom UI element)
  final Widget Function(
    BuildContext context,
    T item,
    int index,
    Widget radio,
    bool checked,
  )?
  builder;

  /// padding
  final EdgeInsets? padding;

  /// margins
  final EdgeInsets? margin;

  /// scrollable
  final bool scrollEnabled;

  /// scroll direction
  final Axis scrollDirection;

  /// scroll controller
  final ScrollController? controller;

  /// is primary scroll
  final bool? isPrimary;

  /// default text style - if builder not implemented
  final TextStyle? defaultTextStyle;

  /// default options string builder
  final String? Function(T item, int index)? optionTextBuilder;

  /// value notifier
  late ValueNotifier<int?> _radioIndexNotifier;

  /// value notifier for hover effect
  ValueNotifier<int?>? _hoverNotifier;

  /// on changed
  final void Function(T selectedItem, int index)? onSelectionChanged;

  /// Radio Style
  late RadioStyle radioStyle;

  /// Custom Radio Icon
  final Widget Function(bool isChecked)? radioIconBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: ValueListenableBuilder(
        valueListenable: _radioIndexNotifier,
        builder: (context, value, child) => ListView.builder(
          itemBuilder: (context, index) {
            final radio = _getRadio(index: index);
            final customElement = builder != null
                ? builder!(
                    context,
                    list[index],
                    index,
                    radio,
                    index == _radioIndexNotifier.value,
                  )
                : _defaultWidget(radio: radio, index: index);
            return _buildHoverEffect(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => _onSelectionChanged(index),
                child: customElement,
              ),
              index: index
            );
          },
          itemCount: list.length,
          shrinkWrap: !scrollEnabled,
          physics: scrollEnabled ? null : NeverScrollableScrollPhysics(),
          primary: isPrimary,
          scrollDirection: scrollDirection,
          controller: controller,
        ),
      ),
    );
  }

  Widget _buildHoverEffect({required Widget child, required int index}) {
     return MouseRegion(
        onEnter: (_) => _hoverNotifier?.value = index,
        onExit: (_) => _hoverNotifier?.value = null,
        child: _hoverNotifier != null ? ValueListenableBuilder<int?>(
          valueListenable: _hoverNotifier!,
          builder: (context, isHovering, _) {
            return AnimatedScale(
              scale: _hoverNotifier?.value == index ? radioStyle.hoverEffectFactor : 1.0,
              duration: const Duration(milliseconds: 200),
              child: child,
            );
          },
        ) : child,
      );
  }

  Widget _getRadio({required int index}) {
    if(radioIconBuilder != null) {
      return radioIconBuilder!(_radioIndexNotifier.value == index);
    } else if (radioStyle.isAdaptive) {
      return Radio.adaptive(
        value: index,
        groupValue: _radioIndexNotifier.value,
        onChanged: _onSelectionChanged,
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
    } else {
      return Radio(
        value: index,
        groupValue: _radioIndexNotifier.value,
        onChanged: _onSelectionChanged,
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
    }
  }

  Widget _defaultWidget({required Widget radio, required int index}) {
    final option = optionTextBuilder != null
        ? optionTextBuilder!(list[index], index) ?? ""
        : "";
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        radio,
        SizedBox(width: radioStyle.space),
        Text(option, style: defaultTextStyle),
      ],
    );
  }

  void _onSelectionChanged(int? value) {
    if (_radioIndexNotifier.value != value) {
      _radioIndexNotifier.value = value;
      if (onSelectionChanged != null && value != null) {
        onSelectionChanged!(list[value], value);
      }
    }
  }
}

class RadioStyle {
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
  final bool isAdaptive;
  final double space;
  final bool hoverEffect;
  final double hoverEffectFactor;

  const RadioStyle({
    this.isAdaptive = false,
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
    this.space = 0.0,
    this.hoverEffect = false,
    this.hoverEffectFactor = 1.1,
  });
}
