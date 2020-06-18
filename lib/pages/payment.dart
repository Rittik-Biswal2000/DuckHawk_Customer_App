import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class pay extends StatefulWidget {
  final p,u;
  pay(this.p,this.u);
  @override
  _payState createState() => _payState();
}
Razorpay razorpay;
class _payState extends State<pay> {
  @override
  void initState() {
    super.initState();
    razorpay=new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,handlerExternalWallet);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,handlerErrorFailure);
  }
  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }
  void openCheckout(){
    var options={
      "key":"rzp_live_duRi21o5TNatUk",
      "amount":(double.parse(widget.u))*100,
      "name":"Sample App",
      "description":"Payment......",
      "prefill":{
        "contact":"",
        "email":""
      },
      "external":{
        "wallets":["paytm"],
      }
    };
    try{
      razorpay.open(options);

    }catch(e){
      print(e.toString());
    }
  }
  void handlerPaymentSuccess(){
    print("Payment Successful");
  }
  void handlerErrorFailure(){
    print("Payment Error");
  }
  void handlerExternalWallet(){
    print("Ext Wallet");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff104670),
        title: new Text("Payments"),
      ),
      body: Container(
        child: FlatButton(
          onPressed: (){
            openCheckout();
          },
          child: Text("Pay Now"),
        ),
      ),

    );
  }
}
