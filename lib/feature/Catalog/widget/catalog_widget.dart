import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/Catalog/view/create_catalog_view.dart';
import '../../../Core/Widgets/custom_item_card.dart';
import '../../../models/catalog_item_model.dart';
import '../Funcation/catalog_function.dart';
import 'catalog_stream_widget.dart';


class CatalogWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CatalogWidget();
  }
}


class _CatalogWidget extends State<CatalogWidget>{
  List<CatalogItemModel> _allItem=[];
  List<CatalogItemModel> _searchItem=[];
  bool _search=false;
  TextEditingController _name=TextEditingController();
  @override
  void initState() {
    super.initState();
    getItemsSearch();
  }
  void getItemsSearch()async{
    List<CatalogItemModel> item=await GetAllItems(context);
    setState(() {
      _allItem=item;
    });
    print(_allItem.length);
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight * 0.22,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF07933E),
                    Color(0xFF007530),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenHeight * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.04),
                !_search? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Catalog',
                            style: TextStyle(
                              fontSize: screenWidth * 0.085,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      IconButton(onPressed: (){
                        setState(() {
                          _search=!_search;
                        });
                      }, icon: Icon(Icons.search,color: Colors.white,))
                    ],
                  ):Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         SizedBox(
                           child: TextFormField(
                             controller: _name,
                             obscureText: false,
                             decoration: InputDecoration(
                               prefixIcon: const Icon(Icons.search),
                               hintText: 'Search Item',
                               filled: true,
                               fillColor: Colors.grey[200],
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                 borderSide: BorderSide.none,
                               ),
                               contentPadding: EdgeInsets.symmetric(
                                   vertical: screenHeight * 0.02,
                                   horizontal: screenWidth * 0.05),
                             ),
                             keyboardType: TextInputType.name,
                             onChanged: (value){
                               setState(() {
                                 print(value);
                                 _searchItem=SearchItem(_allItem, value);
                                 print(_searchItem.length);
                               });
                             },
                           ),
                           width: screenWidth*0.6,
                         ),
                       ],
                     ),
                     IconButton(onPressed: (){
                       setState(() {
                         _search=!_search;
                       });
                     }, icon: Icon(Icons.clear,color: Colors.white,))
                   ],
                 ),
                ],
              ),
            ),
            _search?SizedBox(
              height: screenHeight*0.7,
              child: GradSearch(_searchItem),
            )
                :SizedBox(
                height: screenHeight*0.9,
                child: CatalogStreamWidget()
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.bottomSheet(CreateCatalogView());
      },child: Icon(Icons.add,color: Colors.black,),
        backgroundColor: Colors.grey[100],),
    );
  }

  Widget GradSearch(List<CatalogItemModel> items){
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return  Padding(
      padding: const EdgeInsets.all(18.0),
      child: GridView.builder(
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: screenWidth * 0.03,
            mainAxisSpacing: screenHeight * 0.02,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index){
            return InkWell(
              child: CustomItemCard(items[index]),
              onTap: (){
                // Get.to(ItemDetailsCatalogView(widget.cat,widget.sub,widget.sub.items[index]),duration: Duration(seconds: 1),
                //     transition: Transition.fadeIn);
              },
            );
          }
      ),
    );
  }
}