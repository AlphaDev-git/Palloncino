import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pallon_app/models/catalog_item_model.dart';


class CustomItemCard extends StatelessWidget{
  CatalogItemModel _itemModel;
  CustomItemCard(this._itemModel);
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
    final double cardWidth = screenWidth * 0.45;
    final double cardBorderRadius = screenWidth * 0.09;
    final double shadowSpreadRadius = screenWidth * 0.005;
    final double shadowBlurRadius = screenWidth * 0.02;
    final double shadowOffsetDy = screenWidth * 0.01;
    final double placeholderStrokeWidth = 2.0;
    final double errorIconSize = screenWidth * 0.1;
    final double imageAspectRatio = 16 / 9;
    final double imageHeight = cardWidth / imageAspectRatio;
    final double contentPadding = screenWidth * 0.025;
    final double verticalSpacing = screenWidth * 0.008;
    final double titleFontSize = screenWidth * 0.038;
    return Container(

      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: shadowSpreadRadius,
            blurRadius: shadowBlurRadius,
            offset: Offset(0, shadowOffsetDy),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(cardBorderRadius)),
            child: SizedBox(
              height: imageHeight,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: _itemModel.path != null
                    ? _itemModel.path
                    : 'https://placehold.co/600x400/cccccc/000000?text=No+Image',
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: Center(child: CircularProgressIndicator(strokeWidth: placeholderStrokeWidth, color: Colors.grey)),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(Icons.broken_image, size: errorIconSize, color: Colors.grey),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(contentPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: verticalSpacing),
                Text(
                  _itemModel.name,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'NotoKufiArabic',
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: verticalSpacing),
                Text(
                  _itemModel.des,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'NotoKufiArabic',
                    color: Colors.grey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: verticalSpacing),
                SizedBox(
                  width: screenWidth*0.5,
                  child: ElevatedButton(onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFCE232B),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(screenWidth * 0.05),
                        ),
                        elevation: 5,
                      ),
                      child: Text("${_itemModel.price}",style: TextStyle(
                        color: Colors.white
                      ),)
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}