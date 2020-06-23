import 'package:fastibtmsadmin/src/resources/repository.dart';
import 'package:fastibtmsadmin/src/models/online_order.dart';
import 'package:rxdart/rxdart.dart';

class OnlineOrderBloc {
  final _repo = Repository();

  final BehaviorSubject<List<OnlineOrder>> _liveOnlineOrdersSubject =
      BehaviorSubject<List<OnlineOrder>>();
  Stream<List<OnlineOrder>> get liveOnlineOrders =>
      _liveOnlineOrdersSubject.stream;
  Function(List<OnlineOrder>) get changeLiveOnlineOrders =>
      _liveOnlineOrdersSubject.sink.add;

  getLiveOrders(String vendor) {
    _repo.getLiveOnlineOrders(vendor).listen((orders) {
      changeLiveOnlineOrders(orders);
    });
  }

  setStatus(String orderId, List<String> oldStatus, String currentStatus) {
    var newStatus = [...oldStatus, currentStatus];
    return _repo.setLiveOrderStatus(orderId, newStatus);
  }

  void dispose() {
    _liveOnlineOrdersSubject.close();
  }
}
