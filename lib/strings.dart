const String api_key = "AIzaSyBezh64MI6CDiRtc1wok3JWI3ZmRqAqgbo";
const api_key2 = "AIzaSyAT-PUw3DpJlZoRo0TwhDNmY7AwoR7THuI";
const api_key1 = "AIzaSyBZtIEU0pC2XtQgRr07bpp0vwceEFb4Dso";
const command =
    "-i videourl -i audiourl -c:v copy -c:a aac -strict experimental -shortest outputurl";
// if (total != -1) {
//   final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//     setState(() {
//       progess = count / total * 100;
//     });

//     // Check if download is complete
//     if (count >= total) {
//       log("Total: $total");
//       log("Count: $count");
//       timer.cancel(); // Cancel the timer first
//       setState(() {
//         downloadstart = false;
//         progess = 0;
//       });
//     }
//   });
// }