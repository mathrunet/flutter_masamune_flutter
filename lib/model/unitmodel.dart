part of masamune.flutter;

/// Model for creating a unit.
abstract class UnitModel<T extends IDataField> extends Model<T> {
  /// Reads the value while monitoring it.
  ///
  /// [context]: Build context.
  TValue watch<TValue extends Object>(BuildContext context) {
    UnitModel<T> field = context.watch<UnitModel<T>>(this.context.path);
    return field?.data?.data as TValue;
  }

  /// Reads the value.
  ///
  /// [context]: Build context.
  TValue read<TValue extends Object>(BuildContext context) {
    UnitModel<T> field = context.read<UnitModel<T>>(this.context.path);
    return field?.data?.data as TValue;
  }

  /// True. if the value exists.
  ///
  /// [context]: Build context.
  bool exist(BuildContext context) {
    UnitModel<T> field = PathMap.get<UnitModel<T>>(this.context.path);
    return field?.data?.data != null;
  }
}
