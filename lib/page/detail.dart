import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import './service/service.dart' as service;


class Detail extends StatefulWidget {
   dynamic id;
   Detail({Key key, this.id});

  @override
  DetailState createState() {
    return new DetailState();
  }
}

class DetailState extends State<Detail> {
  dynamic detailVar;
  //  initState() {
  //   movieDetail();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: updateDetailMovie(context),
    );
  }

//   void movieDetail() async{
//   Map data =  await getDetailMovie();
//   print(data.toString());
//   print(data['backdrop_path']);

//   // print(data['results']);
//   setState(() {
// detailVar = data;
//   });

// }

  Future<dynamic> getDetailMovie() async {
    // print(search);
    String url =
        'https://api.themoviedb.org/3/movie/${widget.id}?api_key=${service.api_key}';
    http.Response response = await http.get(url);
    // print(json.decode(response.body).results);
    // SearchList = json.decode(response.body).results;
    return json.decode(response.body);
  }

   Widget updateDetailMovie(context) {
    return FutureBuilder(
      future: getDetailMovie(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            dynamic content = snapshot.data;
            return ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250.0,
                child: ClipPath(
                  child: Container(
                       decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xff00baf9),
                  Color(0xff50daff)])
                ),
                  ),
                  clipper: MyClipper(),
                ),
               
              ),
               Container(
               margin: EdgeInsets.only(right: 45.0,bottom: 0.0,left: 45.0,top: 80.0),

             child: Container(
                  width: MediaQuery.of(context).size.width - 90.0,
                  height: 300.0,
                    decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10.0,
                  ),
                ],
                
                ),
                  child: ClipRRect(
                   borderRadius: BorderRadius.circular(10.0),
                                  child: FadeInImage.assetNetwork(
  placeholder: 'assets/loading.png',
  
  image: '${service.imgUrl}${content['backdrop_path']}',fit: BoxFit.fill,
  // fit: BoxFit.fill,

),
                ),
                  
                ),

          ),

              Positioned(
                top: 15.0,
                left: 10.0,
                child: GestureDetector(
              onTap: () {
               Navigator.of(context).pop();
            
              },
                                  child: Container(
                    child: Row(children: [
                      Image.asset(
                        'assets/arrow.png',
                        width: 22.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('Back',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 17.0,
                          ))
                    ]),
                  ),
                ),
              ),
            
            ],
          ),
                   Container(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  // width: 60.0,
                  child: Padding(
                    padding: EdgeInsets.only(top: 80.0,right: 20.0),
                    child: Image.asset(
                      'assets/edit.png',
                      width: 35.0,
                    ),
                  ),
                ),
                Container(
                
                  width: MediaQuery.of(context).size.width - 120.0,
                  padding: EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        content['title'],
                        style: TextStyle(
                          color: Color(0xff2f2f2f),
                          fontSize: 30.0,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                  padding: EdgeInsets.only(bottom: 20.0),

                          decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xffbcbcbc),
                     width: 1.0))),
                        child:  Text(
                        content['overview'],
                        style: TextStyle(
                          color: Color(0xffbcbcbc),
                          fontSize: 12.0,
                          fontFamily: 'Quicksand',
                        ),
                      ) ,
                      ),
                     Container(
                       padding: EdgeInsets.all(10.0),
                       child: Column(
                         children: <Widget>[
                            Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Budget',
                            style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 12.0,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600,
                        ),),
                         Text(content['budget'].toString(),
                            style: TextStyle(
                          color: Color(0xff6c6c6c),
                          fontSize: 12.0,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w500,
                        ),)
                        ],
                      ),
                      SizedBox(height: 4.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Imdb Rating',
                            style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 12.0,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600,
                        ),),
                         Text(content['vote_average'].toString(),
                            style: TextStyle(
                          color: Color(0xff6c6c6c),
                          fontSize: 12.0,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w500,
                        ),)
                        ],
                      ),
                       SizedBox(height: 4.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Language',
                            style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 12.0,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600,
                        ),),
                         Text(content['spoken_languages'][0]['name'],
                            style: TextStyle(
                          color: Color(0xff6c6c6c),
                          fontSize: 12.0,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w500,
                        ),)
                        ],
                      ),
                       SizedBox(height: 4.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Released',
                            style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 12.0,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600,
                        ),),
                         Text(content['release_date'].toString(),
                            style: TextStyle(
                          color: Color(0xff6c6c6c),
                          fontSize: 12.0,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w500,
                        ),)
                        ],
                      )
                         ],
                       ),
                     )
                     
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
          }
        } else {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                     Image.asset('assets/television-blue.png',
                 width:60.0),
                 SizedBox(height: 5.0),
                 Text('Filmatic Fan',style:TextStyle(
                   color:Color(0xff00baf9),
                   fontSize: 22.0,
                 )),
                  SizedBox(height: 15.0),
                  CircularProgressIndicator(
                backgroundColor: Color(0xff00baf9),
                
              ),

                   ],
                 ),
           
          );
        }
      },
    );
  }

}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    var firstEndPoint = Offset(size.width, size.height);
    var firstControlPoint =Offset(size.width * 0.5,size.height - 20.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    // path.lineTo(size.width, size.height - 70.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
