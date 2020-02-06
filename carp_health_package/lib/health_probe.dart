part of health_lib;

class HealthProbe extends StreamProbe {
  StreamController<HealthDatum> streamController = StreamController<HealthDatum>.broadcast();
  Stream<HealthDatum> get stream => streamController.stream;
  List<HealthDataPoint> healthData = List<HealthDataPoint>();

  List<HealthDataType> dataTypes;
  Duration duration;

  /// Make Health plugin call and fetch data points
  Future<void> _makeApiCall(DateTime start, DateTime end) async {
    for (HealthDataType type in dataTypes) {
      // calls to 'Health.getHealthDataFromType' must be wrapped in a try catch block.
      try {
        List<HealthDataPoint> healthData = await Health.getHealthDataFromType(start, end, type);
        healthData.addAll(healthData);
      } catch (exception) {
        print(exception.toString());
        streamController.addError(exception);
      }

      // convert [HealthDataPoint] to Datums and add them to the stream.
      for (HealthDataPoint h in healthData) streamController.add(HealthDatum.fromHealthDataPoint(h));
    }

    Future<void> onResume() async {
      super.onResume();
      _makeApiCall(DateTime.now().subtract(duration), DateTime.now());
    }

    Future<void> onInitialize(Measure measure) async {
      assert(measure is HealthMeasure);
      super.onInitialize(measure);
      duration = (measure as HealthMeasure).duration;
      dataTypes = (measure as HealthMeasure).healthDataTypes;
    }
  }
}
