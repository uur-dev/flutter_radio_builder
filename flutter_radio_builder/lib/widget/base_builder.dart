import 'package:flutter/material.dart';

abstract class BaseRadioBuilder<T, NotifierType> extends StatefulWidget {
  const BaseRadioBuilder({
    super.key,
    required this.list,
    required this.allowMultiSelection,
    this.selectedItemIndexes,
    this.builder,
    this.padding,
    this.margin,
    this.scrollEnabled = true,
    this.scrollDirection = Axis.vertical,
    this.scrollController,
    this.isPrimary,
    this.defaultTextStyle,
    this.optionTextBuilder,
    this.onSelectionChanged,
    this.radioIconBuilder,
    this.optionSemanticLabel,
    this.radioSemanticLabel,
  });

  /// abstract methods and properties
  Widget getRadioWidget({
    required int index,
    required bool isChecked,
    required Function(int? index) onSelectionChanged,
    required ValueNotifier<NotifierType?> notifier,
  });

  /// radio control controller
  RadioController<NotifierType?> getController();

  /// New Value of Notifier
  NotifierType getNofifierNewValue({
    required int index,
    required bool isChecked,
    required NotifierType? notifierValue,
  });

  /// base control style
  BaseRadioStyle get controlStyle;

  /// radio semnetic label
  final String? radioSemanticLabel;

  /// custom widget sementic label
  final String? optionSemanticLabel;

  /// radio data
  final List<T> list;

  /// selected items index
  final List<int>? selectedItemIndexes;

  /// allow multi selection
  final bool allowMultiSelection;

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
  final ScrollController? scrollController;

  /// is primary scroll
  final bool? isPrimary;

  /// default text style - if builder not implemented
  final TextStyle? defaultTextStyle;

  /// default options string builder
  final String? Function(T item, int index)? optionTextBuilder;

  /// on changed
  final void Function(T selectedItem, int index)? onSelectionChanged;

  /// Custom Radio Icon
  final Widget Function(bool isChecked)? radioIconBuilder;

  @override
  State<BaseRadioBuilder<T, NotifierType>> createState() =>
      _BaseRadioBuilderState<T, NotifierType>();
}

class _BaseRadioBuilderState<T, NotifierType>
    extends State<BaseRadioBuilder<T, NotifierType>> {
  /// value notifier for hover effect
  ValueNotifier<int?>? _hoverNotifier;

  late RadioController<NotifierType?> _radioController;

  @override
  void initState() {
    /// initialization
    _radioController = widget.getController();

    /// init state
    super.initState();
  }

  @override
  void dispose() {
    _radioController.notifier.dispose();
    _hoverNotifier?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controlStyle.hoverEffect) {
      _hoverNotifier = ValueNotifier<int?>(null);
    } else {
      _hoverNotifier?.dispose();
      _hoverNotifier = null;
    }

    return Container(
      padding: widget.padding,
      margin: widget.margin,
      child: ValueListenableBuilder<NotifierType?>(
        valueListenable: _radioController.notifier,
        builder: (context, value, child) => ListView.builder(
          itemBuilder: (context, index) {
            final isChecked = this._isChecked(index);

            final radio = widget.getRadioWidget(
              index: index,
              isChecked: isChecked,
              onSelectionChanged: (selectedIndex) =>
                  _onSelectionChanged(index, isChecked),
              notifier: _radioController.notifier,
            );
            final customElement = widget.builder != null
                ? widget.builder!(
                    context,
                    widget.list[index],
                    index,
                    radio,
                    isChecked,
                  )
                : _defaultWidget(radio: radio, index: index);

            /// gesture widget
            final gestureWidget = InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => _onSelectionChanged(index, isChecked),
              child: customElement,
            );
            final itemWidget = widget.controlStyle.hoverEffect
                ? _buildHoverEffect(child: gestureWidget, index: index)
                : gestureWidget;
            return widget.optionSemanticLabel != null
                ? Semantics(
                    label: widget.optionSemanticLabel,
                    child: itemWidget,
                  )
                : itemWidget;
          },
          itemCount: widget.list.length,
          shrinkWrap: !widget.scrollEnabled,
          physics: widget.scrollEnabled
              ? null
              : const NeverScrollableScrollPhysics(),
          primary: widget.isPrimary ?? false,
          scrollDirection: widget.scrollDirection,
          controller: widget.scrollController,
        ),
      ),
    );
  }

  Widget _buildHoverEffect({required Widget child, required int index}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _hoverNotifier?.value = index,
      onExit: (_) => _hoverNotifier?.value = null,
      child: _hoverNotifier != null
          ? ValueListenableBuilder<int?>(
              valueListenable: _hoverNotifier!,
              builder: (context, isHovering, _) {
                return AnimatedScale(
                  scale: _hoverNotifier?.value == index
                      ? widget.controlStyle.hoverEffectFactor
                      : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: child,
                );
              },
            )
          : child,
    );
  }

  Widget _defaultWidget({required Widget radio, required int index}) {
    final option = widget.optionTextBuilder != null
        ? widget.optionTextBuilder!(widget.list[index], index) ?? ""
        : "";
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        radio,
        SizedBox(width: widget.controlStyle.space),
        Text(option, style: widget.defaultTextStyle),
      ],
    );
  }

  bool _isChecked(int index) {
    final notifierValue = _radioController.currentValue;
    if (widget.allowMultiSelection) {
      return notifierValue is List<int> ? notifierValue.contains(index) : false;
    } else {
      return index == notifierValue;
    }
  }

  void _onSelectionChanged(int index, bool isChecked) {
    NotifierType newValue = widget.getNofifierNewValue(
      index: index,
      isChecked: isChecked,
      notifierValue: _radioController.currentValue,
    );

    _radioController.changeValue(newValue);

    if (widget.onSelectionChanged != null) {
      widget.onSelectionChanged!(widget.list[index], index);
    }
  }
}

abstract class BaseRadioStyle {
  final bool isAdaptive;
  final double space;
  final bool hoverEffect;
  final double hoverEffectFactor;

  BaseRadioStyle({
    this.isAdaptive = false,
    this.space = 0.0,
    this.hoverEffect = false,
    this.hoverEffectFactor = 1.1,
  });
}

class RadioController<T> {
  late ValueNotifier<T> notifier;

  RadioController({required T initialValue}) {
    notifier = ValueNotifier<T>(initialValue);
  }

  T get currentValue {
    return notifier.value;
  }

  void changeValue(T value) {
    notifier.value = value;
  }
}
