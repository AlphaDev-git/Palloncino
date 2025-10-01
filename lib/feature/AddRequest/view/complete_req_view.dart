import 'package:flutter/material.dart';
import 'package:pallon_app/feature/AddRequest/widget/compelete_req_widget.dart';
import 'package:pallon_app/models/catalog_model.dart';
import 'package:pallon_app/models/req_model.dart';


class CompeleteReqView extends StatelessWidget{
  ReqModel req;
  List<Catalog> cat;
  CompeleteReqView(this.req,this.cat);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CompeleteReqWidget(req,cat);
  }
}