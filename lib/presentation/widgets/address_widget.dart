import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rss/common/constants/strings.dart';

class AddressWidget extends StatelessWidget {
  final String province;
  final String district;
  final String muni;

  const AddressWidget({
    Key? key,
    required this.province,
    required this.district,
    required this.muni,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 6,
              color: Colors.blueAccent.withOpacity(0.1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildButton(context, province, 'Province'),
            buildDivider(),
            buildButton(context, district, 'District'),
            buildDivider(),
            buildButton(context, muni, 'Municipality'),
          ],
        ),
      );
  Widget buildDivider() => Container(
        height: 24,
        width: 1,
        color: primaryColor,
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              text,
              style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: primaryColor,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              value,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 11),
            ),
            SizedBox(height: 2),
          ],
        ),
      );
}
