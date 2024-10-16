import 'package:flutter/material.dart';

@immutable
class DinoLabColor extends Color implements WidgetStateProperty<Color> {
  const DinoLabColor(
    super.value, {
    Color? active,
    Color? compLight,
    Color? compDark,
  })  : _active = active,
        _compLight = compLight,
        _compDark = compDark;

  final Color? _active;
  final Color? _compLight;
  final Color? _compDark;

  Color get active => _active ?? this;
  Color get compLight => _compLight ?? this;
  Color get compDark => _compDark ?? this;

  @override
  int get hashCode => Object.hash(
        value,
        _active,
        _compLight,
        _compDark,
      );

  @override
  bool operator ==(Object other) =>
      other is DinoLabColor &&
      value == other.value &&
      _active == other._active &&
      _compLight == other._compLight &&
      _compDark == other._compDark;

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return _compLight ?? _compDark ?? this;
    }

    if (states.contains(WidgetState.pressed) ||
        states.contains(WidgetState.dragged) ||
        states.contains(WidgetState.hovered) ||
        states.contains(WidgetState.focused)) {
      return active;
    }

    return this;
  }
}

extension DimindColorExtensions on DinoLabColor {
  DinoLabColor lerp(DinoLabColor? other, double t) {
    return DinoLabColor(
      Color.lerp(this, other, t)!.value,
      active: Color.lerp(_active, other?._active, t),
      compLight: Color.lerp(_compLight, other?._compLight, t),
      compDark: Color.lerp(_compDark, other?._compDark, t),
    );
  }
}
