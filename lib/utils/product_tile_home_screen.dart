import 'package:auctify/const/constants.dart';
import 'package:flutter/material.dart';

// Create a reusable widget for the circle image with border
class CircleImageWithBorder extends StatelessWidget {
  final String? imageAsset;
  final String? imageUrl;
  final String name;

  const CircleImageWithBorder({
    Key? key,
    this.imageAsset,
    this.imageUrl,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (imageAsset != null) {
      imageProvider = AssetImage(imageAsset!);
    } else if (imageUrl != null) {
      imageProvider = NetworkImage(imageUrl!);
    } else {
      // You can set a default image provider here if needed
      imageProvider = AssetImage('');
    }

    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(name, style: smallNormal.copyWith(color: Colors.grey.shade800)),
      ],
    );
  }
}

class ProductCard extends StatefulWidget {
  final String imageAsset;
  final String name;
  final String uname;
  final String price;
  final IconData iconData;

  const ProductCard({
    required this.imageAsset,
    required this.name,
    required this.price,
    required this.iconData,
    required this.uname,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isIconPressed = false;

  void toggleIconState() {
    setState(() {
      isIconPressed = !isIconPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 170,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              image: DecorationImage(
                image: NetworkImage(
                  widget.imageAsset,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: normalImportant.copyWith(fontSize: 18),
                ),
                Text(
                  widget.uname,
                  style: smallNormal.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('current bid', style: smallNormal),
                        Text('\$${widget.price}', style: normalImportant),
                        SizedBox(height: 12),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(left: 60)),
                    InkWell(
                      onTap: toggleIconState,
                      child: Icon(
                        isIconPressed ? Icons.favorite : widget.iconData,
                        size: 25,
                        color: isIconPressed ? Colors.black : Colors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
