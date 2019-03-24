import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import './detail.dart';
import './service/service.dart' as service;

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
 List SearchList;
 String searchValue;
 
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: <Widget>[
          customAppBar(context),
         SearchList !=  null ? Container(
             height: MediaQuery.of(context).size.height - 150.0,
             child: ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      itemCount: SearchList.length,
                      itemBuilder: (context, i) =>
                          itemCard(context, SearchList, i)),
          ):
         
          Container(
            // elevation: 2.0,
            height: MediaQuery.of(context).size.height - 150.0,
            child: ListView.builder(
                // scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (context, i) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Upcoming Movie',
                                style: TextStyle(
                                  color: Color(0xff0079ab),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'See All',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff00baf9)),
                              )
                            ],
                          ),
                          updateUpcomingMovie(context),
                          Column(
                            children: <Widget>[
                              Container(
                                margin:
                                    EdgeInsets.only(top: 20.0, bottom: 10.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Now Playing',
                                  style: TextStyle(
                                    color: Color(0xff0079ab),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              // now_playing_slide(context),
                              updateTempWidget(context),
                              Container(
                                margin:
                                    EdgeInsets.only(top: 20.0, bottom: 10.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Top Rated',
                                  style: TextStyle(
                                    color: Color(0xff0079ab),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              // itemCard(context),
                              //  itemCard(context),
                              //   itemCard(context),
                              updateTopratedMovie(context),
                            ],
                          )
                        ],
                      ),
                    )),
          ),
        ],
      ),
         drawer: buildDrawer(context),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
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
              
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: <Widget>[
                     Image.asset('assets/television.png',
                 width:60.0),
                 SizedBox(height: 5.0),
                 Text('Filmatic Fan',style:TextStyle(
                   color:Color(0xffffffff),
                   fontSize: 22.0,
                 ))

                   ],
                 )
             
                  ),
                  clipper: MyClipper(),
                ),
               
              ),
        
          ListTile(
            leading: const Icon(Icons.home,
            color: Color(0xff000000)),
            title: Text('Home'),
            onTap: () {
            
              Navigator.pop(context);
            },
          ),

           ListTile(
            leading: const Icon(Icons.tv,
            color: Color(0xff000000),),
            title: Text('TV Shows'),
            onTap: () {
            
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.live_tv,
            color: Color(0xff000000)),
            title: Text('Web Series'),
            onTap: () {
            
              Navigator.pop(context);
            },
          ),
           ListTile(
            leading: const Icon(Icons.satellite,
            color: Color(0xff000000)),
            title: Text('Episodes'),
            onTap: () {
            
              Navigator.pop(context);
            },
          ),
         
        ],
      ),
    );
  }

  Stack rectangular_card(context, data, i) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push<bool>(
              context,
              MaterialPageRoute(builder: (context) => Detail( id : data[i]['id'])),
            );
          },
          child: Container(
            margin: EdgeInsets.only(right: 22.0, top: 5.0, bottom: 5.0),
            width: 130.0,
            height: 150.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                  ),
                ],
                
                ),
                child: ClipRRect(
                   borderRadius: BorderRadius.circular(10.0),
                                  child: FadeInImage.assetNetwork(
  placeholder: 'assets/loading.png',
  
  image: '${service.imgUrl}${data[i]['poster_path']}',fit: BoxFit.fill,
  // fit: BoxFit.fill,

),
                ),
          ),
        ),
        Positioned(
          bottom: 5.0,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 5.0),
              // height: 50.0,
              width: 130.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0)),
                  color: Color(0xff000000).withOpacity(0.4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data[i]['title'],
                    style: TextStyle(
                        color: Color(0xffffffff), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    'Release Date : ${data[i]['release_date']}',
                    style: TextStyle(color: Color(0xffffffff), fontSize: 10.0),
                  ),
                ],
              )),
        )
      ],
    );
  }

  Widget round_card(data, i) {
    return GestureDetector(
          onTap: () {
            Navigator.push<bool>(
              context,
              MaterialPageRoute(builder: (context) => Detail( id : data[i]['id'])),
            );
          },
          child:Container(
      margin: EdgeInsets.only(right: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10.0),
            // alignment: Alignment.topLeft,
            // padding: ,
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(100.0),
                border: Border.all(
                    color: Color(0xff007aad),
                    style: BorderStyle.solid,
                    width: 2.0),
                // image: DecorationImage(
                //   image: NetworkImage(
                //       '${service.imgUrl}${data[i]['poster_path']}'),
                //   fit: BoxFit.fill,
                // )
                ),
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(100.0),
                                  child: FadeInImage.assetNetwork(
  placeholder: 'assets/loading.png',
  image: '${service.imgUrl}${data[i]['poster_path']}',
  fit: BoxFit.fill,

),
                ),
          ),
          SizedBox(
            height: 2.0,
          ),
          Flexible(
            child: Container(
              alignment: Alignment.topCenter,
              width: 60.0,
              child: Text(
                data[i]['release_date'],
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: Color(0xff008dc7),
                  fontWeight: FontWeight.w600,
                  fontSize: 10.0,
                ),
              ),
            ),
          )
        ],
      ),
    ),);
  }

  Widget itemCard(context, data, i){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 100.0,
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
                  child: InkWell(
                    onTap: (){
                       Navigator.push<bool>(
              context,
              MaterialPageRoute(builder: (context) => Detail( id : data[i]['id'])),
            );
                    },
            child: Row(
              children: <Widget>[
                Container(
                  width: 80.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0)),
                      // image: DecorationImage(
                      //     image: NetworkImage(
                      //         '${service.imgUrl}${data[i]['poster_path']}'),
                      //     fit: BoxFit.cover)
                          ),

                          child:ClipRRect(
                   borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0)),
                                  child: FadeInImage.assetNetwork(
  placeholder: 'assets/loading.png',
  
  image: '${service.imgUrl}${data[i]['poster_path']}',fit: BoxFit.fill,
  // fit: BoxFit.fill,

),
                ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 120.0,
                   height: 100.0,
                   
                  padding:
                      EdgeInsets.only(top: 6.0, left: 6.0, bottom: 6.0, right: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          data[i]['title'],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),

                       Text(
                          data[i]['overview'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 10.0,
                          ),
                        ),
                     

                     
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column customAppBar(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: 150.0,
              width: double.infinity,
              // color: Color(0xff00baf9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60.0),
                  bottomRight: Radius.circular(60.0),
                ),
                color: Color(0xff00baf9),
              ),
            ),
            Positioned(
              top: -140.0,
              right: 100.0,
              child: Container(
                height: 300.0,
                width: 300.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200.0),
                    color: Color(0xff89e6ff).withOpacity(0.4)),
              ),
            ),
            Positioned(
              top: -150.0,
              left: 150.0,
              child: Container(
                  height: 250.0,
                  width: 250.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150.0),
                      color: Color(0xff89e6ff).withOpacity(0.5))),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15.0),
                      child: IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        color: Colors.white,
                        iconSize: 30.0,
                      ),
                    ),
                    // SizedBox(
                    //     width: MediaQuery.of(context).size.width - 120.0),
                    Container(
                      child: Text(
                        'Filmatic Fan',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Color(0xffffffff),
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(right: 25.0),
                      // alignment: Alignment.topLeft,
                      height: 30.0,
                      width: 30.0,
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(25.0),
                      //     border: Border.all(
                      //         color: Colors.white,
                      //         style: BorderStyle.solid,
                      //         width: 2.0),
                      //     image: DecorationImage(
                      //       image: AssetImage('assets/dragon.jpg'),
                      //       fit: BoxFit.fill,
                      //     )),
                      child:  Image.asset('assets/television.png',
                 width:30.0),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    child: TextField(

                      onChanged: (text) {
                        // print(text.length);
                        // searchFilm(text);
                        setState(() {
                        searchValue = text;
                        print(text);
                        print(searchValue);
                        if(searchValue == '' ){
                           SearchList = null;
                        }
                          
                        });
                      },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            // suffixIcon: Icon(Icons.search,
                            //     color: Color(0xff6c6c6c), size: 25.0),
                            suffixIcon: Material(
                              
                               elevation: 2.0,
                               borderRadius: BorderRadius.circular(30.0),
                               
                               child: InkWell(
                                 onTap: (){
                                  searchFilm(searchValue);
                                 },
                                               child: Icon(Icons.search,
                                  color: Color(0xff6c6c6c), size: 25.0),
                               ),

                            ),
                            contentPadding:
                                EdgeInsets.only(left: 25.0, top: 15.0),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                                color: Colors.grey, fontFamily: 'Quicksand',fontWeight: FontWeight.w500))),
                  ),
                ),
                SizedBox(height: 10.0)
              ],
            )
          ],
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  Future<dynamic> getNowPlaying() async {
    String url =
        'https://api.themoviedb.org/3/movie/popular?api_key=${service.api_key}';
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  Widget updateTempWidget(context) {
    return FutureBuilder(
      future: getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            dynamic content = snapshot.data;
            return SizedBox(
              height: 160.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Container(
                  // elevation: 2.0,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: content['results'].length,
                      itemBuilder: (context, i) =>
                          rectangular_card(context, content['results'], i)),
                ),
              ),
            );
          }
        } else {
          return Container(
              height: 120.0,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xff00d2ff),
                ),
              ));
        }
      },
    );
  }

  Future<dynamic> getUpcomingMovie() async {
    String url =
        'https://api.themoviedb.org/3/movie/upcoming?api_key=${service.api_key}';
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  Widget updateUpcomingMovie(context) {
    return FutureBuilder(
      future: getUpcomingMovie(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            dynamic content = snapshot.data;
            return SizedBox(
              height: 125.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Container(
                  // elevation: 2.0,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: content['results'].length,
                      itemBuilder: (context, i) =>
                          round_card(content['results'], i)),
                ),
              ),
            );
          }
        } else {
          return Container(
              height: 120.0,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xff00d2ff),
                ),
              ));
        }
      },
    );
  }

  Future<dynamic> getTopratedMovie() async {
    String url =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=${service.api_key}';
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  Widget updateTopratedMovie(context) {
    return FutureBuilder(
      future: getTopratedMovie(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            dynamic content = snapshot.data;
            return SizedBox(
              height: 500.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                  // elevation: 2.0,
                  child: ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      itemCount: content['results'].length,
                      itemBuilder: (context, i) =>
                          itemCard(context, content['results'], i)),
                ),
              ),
            );
          }
        } else {
          return Container(
            height: 120.0,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xff00d2ff),
              ),
            ),
          );
        }
      },
    );
  }

void searchFilm(search) async{
  Map data =  await getSearchedMovie(search);
  // print(data.toString());
  print(data['results']);
  setState(() {
    SearchList = data['results'];
    print(SearchList);

  });
  
  

}

  Future<dynamic> getSearchedMovie(String search) async {
    // print(search);
    String url =
        'https://api.themoviedb.org/3/search/movie?api_key=${service.api_key}&query=${search}';
    http.Response response = await http.get(url);
    // print(json.decode(response.body).results);
    // SearchList = json.decode(response.body).results;
    return json.decode(response.body);
  } 
}




class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    var firstEndPoint = Offset(size.width, size.height);
    var firstControlPoint =Offset(size.width * 0.5,size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    // path.lineTo(size.width, size.height - 70.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


