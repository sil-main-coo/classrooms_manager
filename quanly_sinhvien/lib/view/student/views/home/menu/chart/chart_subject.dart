import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CharSubjectStudent extends StatefulWidget {
  @override
  _CharSubjectState createState() => _CharSubjectState();
}

class _CharSubjectState extends State<CharSubjectStudent> {
  int _index=0;
  final _data= ['Lớp 1A', 'Lớp 1B', 'Lớp 1C', 'Lớp 1D'];
  String _valueString;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _valueString = _data[_index];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: _buildDropMenu(context),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),

      ),
      automaticallyImplyLeading: false,
    );
  }

  _buildDropMenu(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: primaryLight),
      child: DropdownButton<String>(
        value: _valueString,
        icon: Icon(Icons.arrow_drop_down, color: Colors.white,),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
            color: Colors.white
        ),
        onChanged: (String newValue) {
          setState(() {
            _valueString = newValue;
            _index= _data.indexOf(newValue);
          });
        },
        items: _data.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        })
            .toList(),
      ),
    );
  }

  _buildBody() {
    return IndexedStack(
      index: _index,
      children: List<Widget>.generate(4, (index){
        return ChartItem(title: "Title $index",);
      }),
    );
  }
}

class ChartItem extends StatefulWidget {
  ChartItem({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _MyHomePageState extends State<ChartItem> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = [
      new ClicksPerYear('2016', 12, Colors.red),
      new ClicksPerYear('2017', 42, Colors.yellow),
      new ClicksPerYear('2018', _counter, Colors.green),
    ];

    var series = [
      new charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
    );
    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    return new Center(
        child: Column(
          children: <Widget>[
            chartWidget,
            Text(widget.title),
            new FloatingActionButton(
              heroTag: "chart${widget.title}",
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: new Icon(Icons.add),
            ),
          ],
        )

    );
  }
}