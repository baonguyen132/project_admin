import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:exchange_book/model/UserModal.dart';
import 'package:exchange_book/theme/theme.dart';

class ManageUser extends StatefulWidget {
  const ManageUser({super.key});

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  List<dynamic> list = [] ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData() ;
  }

  void loadData() async {
    List<dynamic> data = await UserModel.loadDataUser() ;
    setState(() {
      list = data ;
    });
  }

  DataColumn cellTitleTable(String title) {
    return DataColumn(
      label: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  DataCell cellData(String data) {
    return DataCell(
      Text(
        data,
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).colorScheme.maintext,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
  DataRow rowData(List<dynamic> data) {
    return DataRow(
      cells: [
        cellData(data[0].toString()),
        cellData(data[1]),
        cellData(data[2]),
        data[4] == 5 ? cellData("Admin") : cellData("Client"),
        cellData(data[5].toString()),
        DataCell(
          IconButton(
            icon: const Icon(Icons.verified_user, color: Colors.green),
            onPressed: () {
              // xử lý cấp quyền
            },
          ),
        ),
        DataCell(
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              // xử lý xóa
            },
          ),
        ),
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
              ),
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.blue,
                ),
                columnSpacing: 24,
                dataRowHeight: 60,
                headingRowHeight: 60,
                columns: [
                  cellTitleTable("ID"),
                  cellTitleTable("Name"),
                  cellTitleTable("Email"),
                  cellTitleTable("Position"),
                  cellTitleTable("CID"),
                  cellTitleTable("Grant"),
                  cellTitleTable("Delete"),
                ],
                rows: List.generate(list.length, (index) {
                  return rowData(list[index]) ;
                }),
              ),
            ),
          ),
        ),
      ),
    );

  }
}
