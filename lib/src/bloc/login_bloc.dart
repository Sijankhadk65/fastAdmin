import 'package:fastibtmsadmin/src/models/user.dart';
import 'package:fastibtmsadmin/src/models/vendor.dart';
import 'package:fastibtmsadmin/src/resources/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  String _email = "", _password = "";
  final _repo = Repository();

  final BehaviorSubject<String> _emailSubject = BehaviorSubject<String>();
  Stream<String> get email => _emailSubject.stream;

  Function(String) get changeEmail => _emailSubject.sink.add;

  final BehaviorSubject<String> _passwordSubject = BehaviorSubject<String>();
  Stream<String> get password => _passwordSubject.stream;
  Function(String) get changePassword => _passwordSubject.sink.add;

  final BehaviorSubject<Vendor> _vendorSubject = BehaviorSubject<Vendor>();
  Stream<Vendor> get vendor => _vendorSubject.stream;
  Function(Vendor) get changeVendor => _vendorSubject.sink.add;

  Stream<bool> canLogin() =>
      Rx.combineLatest2(email, password, (String email, String password) {
        _email = email;
        _password = password;
        return true;
      });

  Future<AuthResult> loginUser() => _repo.logIn(_email, _password);

  Stream<User> userStatus() => _repo.userStatus();

  getVendor(String userEmail) {
    _repo.getUser(userEmail).listen((event) {
      _repo.getVendorInfo(event.vendor).listen((vendor) {
        changeVendor(vendor);
      });
    });
  }

  updateStatus(bool value, String vendor) => _repo.updateStatus(value, vendor);

  dispose() {
    _emailSubject.close();
    _passwordSubject.close();
    _vendorSubject.close();
  }
}
