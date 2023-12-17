import 'package:apple_store/util/extentions/string-extentions.dart';
import 'package:apple_store/util/url-handler.dart';
import 'package:uni_links/uni_links.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRequest();
  Future<void> sendPaymentRequest();
  Future<void> verifyPaymentRequest();
}

class ZarinpalPaymentHandler extends PaymentHandler {
  final PaymentRequest _paymentRequest = PaymentRequest();
  String? _authority;
  String? _status;
  UrlHandler _urlHandler = UrlLauncher();

  @override
  Future<void> initPaymentRequest() async {
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setAmount(120000); //price
    _paymentRequest.setDescription('Apple Store'); //description
    _paymentRequest.setMerchantID('d645fba8-1b29-11ea-be59-000c295eb8fc');
    _paymentRequest.setCallbackURL('expertflutter://store');
    linkStream.listen(
      (deeplink) {
        if (deeplink!.toLowerCase().contains('authority')) {
          _authority = deeplink.extractValueFromQuery('Authority');
          _status = deeplink.extractValueFromQuery('Status');
          verifyPaymentRequest();
        }
      },
    );
  }

  @override
  Future<void> verifyPaymentRequest() async {
    ZarinPal().verificationPayment(
      _status!,
      _authority!,
      _paymentRequest,
      (isPaymentSuccess, refID, paymentRequest) {
        if (isPaymentSuccess) {
          print('ok');
        } else {
          print('error');
        }
      },
    );
  }

  @override
  Future<void> sendPaymentRequest() async {
    ZarinPal().startPayment(
      _paymentRequest,
      (status, paymentGatewayUri) {
        if (status == 100) {
          _urlHandler.openUrl(paymentGatewayUri!);
        }
      },
    );
  }
}
