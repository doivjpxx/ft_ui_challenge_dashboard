import 'package:flutter/material.dart';
import 'package:ft_ui_challenge_dashboard/constants/assets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;

final List<Activity> activities = [
  Activity(title: "Results", icon: FontAwesomeIcons.listOl),
  Activity(title: "Messages", icon: FontAwesomeIcons.sms),
  Activity(title: "Appointments", icon: FontAwesomeIcons.calendarDay),
  Activity(title: "Video Consultation", icon: FontAwesomeIcons.video),
  Activity(title: "Summary", icon: FontAwesomeIcons.fileAlt),
  Activity(title: "Billing", icon: FontAwesomeIcons.dollarSign),
];

class MyDashboard1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.grey.shade100,
        title: Text(
          'Dashboard',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundImage: NetworkImage(images[0]),
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          _buildStats(),
          _buildChart(),
          _buildActivities(context)
        ],
      ),
    );
  }

  SliverPadding _buildActivities(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverToBoxAdapter(
          child: Card(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Activities",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  children: activities
                      .map((activity) => Column(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Theme.of(context).buttonColor,
                                child: activity.icon != null
                                    ? FaIcon(
                                        activity.icon,
                                        size: 18.0,
                                      )
                                    : null,
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                activity.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                              )
                            ],
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildChart() {
    return SliverToBoxAdapter(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Sales",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
                  ),
                  Container(
                    child: DonutPieChart.withSampleData(),
                    height: 200.0,
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildStats() {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid.count(
        crossAxisCount: 3,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.5,
        children: <Widget>[
          _buildCard(Colors.blue, '+500', 'leads'.toUpperCase()),
          _buildCard(Colors.pink, '+300', 'customers'.toUpperCase()),
          _buildCard(Colors.green, '+1200', 'orders'.toUpperCase()),
        ],
      ),
    );
  }
}

extension MoreMyDashboard1 on MyDashboard1 {
  Widget _buildCard(Color color, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: color),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            subtitle,
          ),
        ],
      ),
    );
  }
}

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  const DonutPieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutPieChart.withSampleData() {
    return new DonutPieChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.ArcRendererConfig(
          arcWidth: 60,
          arcRendererDecorators: [new charts.ArcLabelDecorator()]),
    );
  }

  static List<charts.Series<LinearSales, String>> _createSampleData() {
    final data = [
      new LinearSales("July", 100),
      new LinearSales("August", 75),
      new LinearSales("September", 25),
      new LinearSales("October", 5),
    ];

    return [
      new charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.month,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class LinearSales {
  final String month;
  final int sales;

  LinearSales(this.month, this.sales);
}

class Activity {
  final String title;
  final IconData icon;
  Activity({this.title, this.icon});
}
