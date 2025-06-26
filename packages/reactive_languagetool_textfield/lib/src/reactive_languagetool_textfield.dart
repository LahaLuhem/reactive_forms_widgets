library;

// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_languagetool_textfield/reactive_languagetool_textfield.dart';

typedef ControllerInitCallback = void Function(
    LanguageToolController controller);

/// A [ReactiveLanguageToolTextField] that contains a [LanguageToolTextField].
///
/// This is a convenience widget that wraps a [LanguageToolTextField] widget in a
/// [ReactiveLanguageToolTextField].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveLanguageToolTextField<T> extends ReactiveFormField<T, String> {
  final ControllerInitCallback? onControllerInit;
  final HighlightStyle highlightStyle;
  final Duration delay;
  final DelayType delayType;

  /// Creates a [ReactiveLanguageToolTextField] that contains a [LanguageToolTextField].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// Can optionally provide a [validationMessages] argument to customize a
  /// message for different kinds of validation errors.
  ///
  /// Can optionally provide a [valueAccessor] to set a custom value accessors.
  /// See [ControlValueAccessor].
  ///
  /// Can optionally provide a [showErrors] function to customize when to show
  /// validation messages. Reactive Widgets make validation messages visible
  /// when the control is INVALID and TOUCHED, this behavior can be customized
  /// in the [showErrors] function.
  ///
  /// ### Example:
  /// Binds a text field.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveLanguageToolTextField(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveLanguageToolTextField(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveLanguageToolTextField(
  ///   formControlName: 'email',
  ///   validationMessages: {
  ///     ValidationMessage.required: 'The email must not be empty',
  ///     ValidationMessage.email: 'The email must be a valid email',
  ///   }
  /// ),
  /// ```
  ///
  /// Customize when to show up validation messages.
  /// ```dart
  /// ReactiveLanguageToolTextField(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [TextField], the constructor.
  ReactiveLanguageToolTextField({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    String language = 'auto',
    MistakePopup? mistakePopup,
    bool alignCenter = true,
    InputDecoration decoration = const InputDecoration(),
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    bool? showCursor,
    bool obscureText = false,
    String obscuringCharacter = '•',
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    MaxLengthEnforcement? maxLengthEnforcement,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    GestureTapCallback? onTap,
    void Function(PointerDownEvent)? onTapOutside,
    VoidCallback? onEditingComplete,
    List<TextInputFormatter>? inputFormatters,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
    VoidCallback? onSubmitted,
    FocusNode? focusNode,
    Iterable<String>? autofillHints,
    MouseCursor? mouseCursor,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    AppPrivateCommandCallback? onAppPrivateCommand,
    String? restorationId,
    ScrollController? scrollController,
    TextSelectionControls? selectionControls,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.onControllerInit,
    this.highlightStyle = const HighlightStyle(),
    this.delay = const Duration(seconds: 0),
    this.delayType = DelayType.debouncing,
    Clip clipBehavior = Clip.hardEdge,
    bool enableIMEPersonalizedLearning = true,
    bool scribbleEnabled = true,
    Widget Function(BuildContext context, String error)? errorBuilder,
  }) : super(
          builder: (ReactiveFormFieldState<T, String> field) {
            final state = field as _ReactiveLanguageToolTextFieldState<T>;
            final effectiveDecoration = decoration
                .applyDefaults(Theme.of(state.context).inputDecorationTheme);

            final errorText = field.errorText;

            state._setFocusNode(focusNode);

            return LanguageToolTextField(
              controller: state._textController,
              language: language,
              mistakePopup: mistakePopup,
              alignCenter: alignCenter,
              focusNode: state.focusNode,
              decoration: effectiveDecoration.copyWith(
                errorText: errorBuilder == null ? field.errorText : null,
                enabled: field.control.enabled,
                error: errorBuilder != null && errorText != null
                    ? DefaultTextStyle.merge(
                        style: Theme.of(field.context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                              color: Theme.of(field.context).colorScheme.error,
                            )
                            .merge(effectiveDecoration.errorStyle),
                        child: errorBuilder.call(
                          field.context,
                          errorText,
                        ),
                      )
                    : null,
              ),
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              style: style,
              // strutStyle: strutStyle,
              textAlign: textAlign,
              // textAlignVertical: textAlignVertical,
              textDirection: textDirection,
              // textCapitalization: textCapitalization,
              autoFocus: autofocus,
              readOnly: readOnly,
              // showCursor: showCursor,
              // obscureText: obscureText,
              autocorrect: autocorrect,
              // smartDashesType: smartDashesType ??
              //     (obscureText
              //         ? SmartDashesType.disabled
              //         : SmartDashesType.enabled),
              // smartQuotesType: smartQuotesType ??
              //     (obscureText
              //         ? SmartQuotesType.disabled
              //         : SmartQuotesType.enabled),
              // enableSuggestions: enableSuggestions,
              // maxLengthEnforcement: maxLengthEnforcement,
              maxLines: maxLines,
              minLines: minLines,
              expands: expands,
              // maxLength: maxLength,
              // onChanged: field.didChange,
              onTap: onTap,
              onTapOutside: onTapOutside,
              onTextChange: field.didChange,
              onTextSubmitted:
                  onSubmitted != null ? (_) => onSubmitted() : null,
              // onEditingComplete: onEditingComplete,
              // inputFormatters: inputFormatters,
              // enabled: field.control.enabled,
              // cursorWidth: cursorWidth,
              // cursorHeight: cursorHeight,
              // cursorRadius: cursorRadius,
              cursorColor: cursorColor,
              // scrollPadding: scrollPadding,
              // scrollPhysics: scrollPhysics,
              keyboardAppearance: keyboardAppearance,
              // enableInteractiveSelection: enableInteractiveSelection,
              // buildCounter: buildCounter,
              // autofillHints: autofillHints,
              mouseCursor: mouseCursor,
              // obscuringCharacter: obscuringCharacter,
              // dragStartBehavior: dragStartBehavior,
              // onAppPrivateCommand: onAppPrivateCommand,
              // restorationId: restorationId,
              // scrollController: scrollController,
              // selectionControls: selectionControls,
              // selectionHeightStyle: selectionHeightStyle,
              // selectionWidthStyle: selectionWidthStyle,
              // clipBehavior: clipBehavior,
              // enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
              // scribbleEnabled: scribbleEnabled,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, String> createState() =>
      _ReactiveLanguageToolTextFieldState<T>();
}

class _ReactiveLanguageToolTextFieldState<T>
    extends ReactiveFormFieldState<T, String> {
  late LanguageToolController _textController;
  FocusNode? _focusNode;
  late FocusController _focusController;

  @override
  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void initState() {
    super.initState();

    final initialValue = value;

    _textController = LanguageToolController(
      highlightStyle:
          (widget as ReactiveLanguageToolTextField<T>).highlightStyle,
      delay: (widget as ReactiveLanguageToolTextField<T>).delay,
      delayType: (widget as ReactiveLanguageToolTextField<T>).delayType,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _textController.text = initialValue?.toString() ?? '';
    });

    (widget as ReactiveLanguageToolTextField<T>)
        .onControllerInit
        ?.call(_textController);
  }

  @override
  void didUpdateWidget(ReactiveFormField<T, String> oldWidget) {
    final newControl = _resolveFormControl();
    if (control != newControl) {
      unsubscribeControl();
      control = newControl;
      subscribeControl();
      final initialValue = value;
      _textController.text =
          initialValue == null ? '' : initialValue.toString();
    }

    super.didUpdateWidget(oldWidget);
  }

  FormControl<T> _resolveFormControl() {
    if (widget.formControl != null) {
      return widget.formControl!;
    }

    final parent = ReactiveForm.of(context, listen: false);
    if (parent == null || parent is! FormControlCollection) {
      throw FormControlParentNotFoundException(widget);
    }

    final collection = parent as FormControlCollection;
    final control = collection.control(widget.formControlName!);
    if (control is! FormControl<T>) {
      throw BindingCastException<T, String>(widget, control);
    }

    return control;
  }

  @override
  void subscribeControl() {
    _registerFocusController(FocusController());
    super.subscribeControl();
  }

  @override
  void dispose() {
    _unregisterFocusController();
    _textController.dispose();
    super.dispose();
  }

  @override
  void onControlValueChanged(dynamic value) {
    final effectiveValue = (value == null) ? '' : value.toString();
    _textController.value = _textController.value.copyWith(
      text: effectiveValue,
      selection: TextSelection.collapsed(offset: effectiveValue.length),
      composing: TextRange.empty,
    );

    super.onControlValueChanged(value);
  }

  @override
  ControlValueAccessor<T, String> selectValueAccessor() {
    if (control is FormControl<int>) {
      return IntValueAccessor() as ControlValueAccessor<T, String>;
    } else if (control is FormControl<double>) {
      return DoubleValueAccessor() as ControlValueAccessor<T, String>;
    } else if (control is FormControl<DateTime>) {
      return DateTimeValueAccessor() as ControlValueAccessor<T, String>;
    } else if (control is FormControl<TimeOfDay>) {
      return TimeOfDayValueAccessor() as ControlValueAccessor<T, String>;
    }

    return super.selectValueAccessor();
  }

  void _registerFocusController(FocusController focusController) {
    _focusController = focusController;
    control.registerFocusController(focusController);
  }

  void _unregisterFocusController() {
    control.unregisterFocusController(_focusController);
    _focusController.dispose();
  }

  void _setFocusNode(FocusNode? focusNode) {
    if (_focusNode != focusNode) {
      _focusNode = focusNode;
      _unregisterFocusController();
      _registerFocusController(FocusController(focusNode: _focusNode));
    }
  }
}
