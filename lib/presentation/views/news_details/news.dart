import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:rss/data/model/news/news-details.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsPage extends StatelessWidget {
  final Newdetailsmodel newsDetails;
  const NewsPage({Key? key, required this.newsDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  downloadNews(newsDetails);
                },
                icon: Icon(Icons.download),
              ),
            ],
          ),
          Text(
            newsDetails.data!.title.toString(),
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
            //  Theme.of(context).textTheme.headline3!.copyWith(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.grey),

            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                newsDetails.data!.newsModule.toString() ?? "",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 14,
                  ),
                  Text(
                    newsDetails.data!.newsDate.toString(),
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    //  Theme.of(context).textTheme.headline3!.copyWith(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.grey),

                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                newsDetails.data!.dateline.toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Html(
            data: "${newsDetails.data!.news} ",
            style: {
              "body": Style(
                fontSize: FontSize(14.0),
                color: Colors.black,
                textAlign: TextAlign.justify,
                lineHeight: LineHeight.number(1.5),
                fontWeight: FontWeight.normal,
              ),
            },
          )
        ],
      ),
    );
  }

  void downloadNews(Newdetailsmodel data) async {
    print(data.data!.dateline);
    String dir = '';

    dir = (await getExternalStorageDirectory())!.path;
    var path = "$dir/" + data.data!.title! + data.data!.dateline! + ".text";
    File file = File(path);
    file
        .writeAsString(
      "Dateline : " +
          data.data!.dateline.toString() +
          "\n" +
          "News title : " +
          data.data!.title.toString() +
          "\n" +
          "News subject : " +
          data.data!.subject.toString() +
          "\n" +
          "News Details : " +
          data.data!.news.toString(),
    )
        .then((value) async {
      final params = SaveFileDialogParams(sourceFilePath: file.path);

      final filePath = await FlutterFileDialog.saveFile(params: params);
      print(filePath);
    });
  }
}
