import 'package:apple_shop/util/url_handler.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymantRequest(int finalPrice);
  Future<void> sendPaymantRequest();
  Future<void> verifyPaymantRequest();
}

class ZarinpalPayment extends PaymentHandler {
  final PaymentRequest _paymentRequest = PaymentRequest();
  String? status;
  String? authority;
  UrlHandler urlHandler;
  ZarinpalPayment(this.urlHandler);
  @override
  Future<void> initPaymantRequest(int finalPrice) async {
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setAmount(finalPrice);
    _paymentRequest.setDescription('this is for test apple shop');
    _paymentRequest.setCallbackURL('expertflutter://shop');
    _paymentRequest.setMerchantID('71c705f8-bd37-11e6-aa0c-000c295eb8fc');
    // linkStream.listen((deeplink) {
    //   if (deeplink!.toLowerCase().contains('authority')) {
    //      authority = deeplink.extractValueFromQuery( 'Authority');
    //      status = deeplink.extractValueFromQuery( 'Status');
    //     print(authority);
    //     print(status);
    // verifyPaymantRequest();

    //   }
    // });
  }

  @override
  Future<void> sendPaymantRequest() async {
    ZarinPal().startPayment(_paymentRequest, (status, paymentGatewayUri) {
      if (status == 100) {
        urlHandler.openchUrl(paymentGatewayUri!);
      }
    });
  }

  @override
  Future<void> verifyPaymantRequest() async {
    ZarinPal().verificationPayment(status!, authority!, _paymentRequest,
        (isPaymentSuccess, refID, paymentRequest) {
      if (isPaymentSuccess) {
        print(refID);
      } else {
        print('error');
      }
    });
  }
}
