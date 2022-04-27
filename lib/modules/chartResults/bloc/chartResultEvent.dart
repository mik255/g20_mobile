class ChartResultEvent{}

class ChartResultFetch extends ChartResultEvent{
  String userId;

  ChartResultFetch(this.userId);
}