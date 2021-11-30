import 'package:flutter/material.dart';

import '../../utils/app_style.dart';
import '../../utils/app_theme.dart';

import '../../model/calculator_history.dart';

import '../../service/calculator_controller.dart';

import './widget/calculator_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ValueNotifier<String> calculationQuery = ValueNotifier<String>("");
  List<CalculatorHistory> historyList = [];

  void calculate() {
    final tempResult = CalculatorController.instance.evaluate(calculationQuery.value).toString();
    historyList.add(
      CalculatorHistory(
        query: calculationQuery.value,
        result: tempResult,
      ),
    );
    calculationQuery.value = tempResult;
  }

  void delete() {
    if (calculationQuery.value.isNotEmpty) {
      calculationQuery.value = calculationQuery.value.substring(0, calculationQuery.value.length - 1);
    }
  }

  void clear() {
    calculationQuery.value = "";
  }

  void input(String input) {
    if (calculationQuery.value == '0') {
      clear();
    }
    calculationQuery.value += input;
  }

  void showHistory() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      )),
      builder: (context) {
        final mediaQueryData = MediaQuery.of(context);
        return SizedBox(
          height: mediaQueryData.size.height,
          width: mediaQueryData.size.width,
          child: historyList.isEmpty
              ? Center(
                  child: Text(
                    "History not found",
                    style: AppStyle.instance.textStyle(
                      fontSize: 20,
                      color: AppTheme.intance.muted,
                    ),
                  ),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        clear();
                        Navigator.of(context).pop();
                        input(historyList[index].query);
                      },
                      child: Container(
                        width: mediaQueryData.size.width,
                        padding: const EdgeInsets.only(
                          right: 20,
                          left: 10,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              historyList[index].query,
                              style: AppStyle.instance.textStyle(
                                fontSize: 20,
                                color: AppTheme.intance.muted,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "= ${historyList[index].result}",
                              style: AppStyle.instance.textStyle(
                                fontSize: 30,
                                color: AppTheme.intance.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: AppTheme.intance.muted,
                    );
                  },
                  itemCount: historyList.length,
                ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Calculator",
          style: AppStyle.instance.textStyle(
            color: AppTheme.intance.muted,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => showHistory(),
            icon: Icon(
              Icons.history,
              color: AppTheme.intance.primary,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: ValueListenableBuilder(
            valueListenable: calculationQuery,
            builder: (context, value, child) {
              return SizedBox(
                height: mediaQueryData.size.height - mediaQueryData.padding.top,
                width: mediaQueryData.size.width,
                child: Column(
                  children: [
                    Container(
                      height: (mediaQueryData.size.height - mediaQueryData.padding.top - kToolbarHeight) * 0.3,
                      width: mediaQueryData.size.width,
                      padding: EdgeInsets.only(
                        right: mediaQueryData.size.width * 0.05,
                        bottom: mediaQueryData.size.width * 0.05,
                      ),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        calculationQuery.value,
                        style: AppStyle.instance.textStyle(
                          fontSize: 40,
                          color: AppTheme.intance.muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: (mediaQueryData.size.height - mediaQueryData.padding.top - kToolbarHeight) * 0.7,
                      width: mediaQueryData.size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CalculatorButton(
                                text: "(",
                                color: AppTheme.intance.secondry,
                                method: () => input("("),
                              ),
                              CalculatorButton(
                                text: ")",
                                color: AppTheme.intance.secondry,
                                method: () => input(")"),
                              ),
                              CalculatorButton(
                                text: "%",
                                color: AppTheme.intance.secondry,
                                method: () => input("%"),
                              ),
                              CalculatorButton(
                                text: "/",
                                color: AppTheme.intance.primary,
                                method: () => input("/"),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CalculatorButton(
                                text: "7",
                                color: AppTheme.intance.muted,
                                method: () => input("7"),
                              ),
                              CalculatorButton(
                                text: "8",
                                color: AppTheme.intance.muted,
                                method: () => input("8"),
                              ),
                              CalculatorButton(
                                text: "9",
                                color: AppTheme.intance.muted,
                                method: () => input("9"),
                              ),
                              CalculatorButton(
                                text: "*",
                                color: AppTheme.intance.primary,
                                method: () => input("*"),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CalculatorButton(
                                text: "4",
                                color: AppTheme.intance.muted,
                                method: () => input("4"),
                              ),
                              CalculatorButton(
                                text: "5",
                                color: AppTheme.intance.muted,
                                method: () => input("5"),
                              ),
                              CalculatorButton(
                                text: "6",
                                color: AppTheme.intance.muted,
                                method: () => input("6"),
                              ),
                              CalculatorButton(
                                text: "-",
                                color: AppTheme.intance.primary,
                                method: () => input("-"),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CalculatorButton(
                                text: "1",
                                color: AppTheme.intance.muted,
                                method: () => input("1"),
                              ),
                              CalculatorButton(
                                text: "2",
                                color: AppTheme.intance.muted,
                                method: () => input("2"),
                              ),
                              CalculatorButton(
                                text: "3",
                                color: AppTheme.intance.muted,
                                method: () => input("3"),
                              ),
                              CalculatorButton(
                                text: "+",
                                color: AppTheme.intance.primary,
                                method: () => input("+"),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CalculatorButton(
                                text: "0",
                                color: AppTheme.intance.muted,
                                method: () => input("0"),
                              ),
                              CalculatorButton(
                                text: "C",
                                color: AppTheme.intance.muted,
                                method: clear,
                              ),
                              CalculatorButton(
                                text: "Del",
                                color: AppTheme.intance.muted,
                                method: () => delete(),
                              ),
                              CalculatorButton(
                                text: "=",
                                color: AppTheme.intance.primary,
                                method: () => calculate(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
