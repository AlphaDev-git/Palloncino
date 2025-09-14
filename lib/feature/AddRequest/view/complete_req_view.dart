import 'package:flutter/material.dart';
import 'package:pallon_app/feature/AddRequest/widget/compelete_req_widget.dart';
import 'package:pallon_app/models/req_model.dart';


class CompeleteReqView extends StatelessWidget{
  ReqModel req;
  CompeleteReqView(this.req);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CompeleteReqWidget(req);
  }
}