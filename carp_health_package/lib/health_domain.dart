part of health_lib;

/// Specify the configuration on how to collect location data.
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class HealthMeasure extends Measure {
  List<HealthDataType> healthDataTypes;
  Duration duration;

  HealthMeasure(MeasureType type, this.healthDataTypes, this.duration) : super(type);

  static Function get fromJsonFunction => _$HealthMeasureFromJson;

  factory HealthMeasure.fromJson(Map<String, dynamic> json) =>
      FromJsonFactory.fromJson(json[Serializable.CLASS_IDENTIFIER].toString(), json);

  Map<String, dynamic> toJson() => _$HealthMeasureToJson(this);
}

/// A [Datum] that holds a [HealthDataPoint] datapoint information collected through the [World's Air Quality Index (WAQI)](https://waqi.info) API.
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class HealthDatum extends CARPDatum {
  static const DataFormat CARP_DATA_FORMAT = DataFormat(NameSpace.CARP, HealthSamplingPackage.HEALTH);

  DataFormat get format => CARP_DATA_FORMAT;

  num value;
  String unit;
  int dateFrom;
  int dateTo;
  String dataType;
  String platform;

  HealthDatum(this.value, this.unit, this.dateFrom, this.dateTo, this.dataType, this.platform) : super();

  factory HealthDatum.fromHealthDataPoint(HealthDataPoint healthDataPoint) => HealthDatum(
      healthDataPoint.value,
      healthDataPoint.unit,
      healthDataPoint.dateFrom,
      healthDataPoint.dateTo,
      healthDataPoint.dataType,
      healthDataPoint.platform);

  factory HealthDatum.fromJson(Map<String, dynamic> json) => _$HealthDatumFromJson(json);

  Map<String, dynamic> toJson() => _$HealthDatumToJson(this);
}
