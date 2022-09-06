import 'package:arcopen_enquirer/config/routes/k_router.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/core/models/finance.dart';
import 'package:arcopen_enquirer/http/responses/finance_response.dart';
import 'package:arcopen_enquirer/modules/finances/finance_controller.dart';
import 'package:arcopen_enquirer/widgets/dialogs/invoice_details_dialog.dart';
import 'package:arcopen_enquirer/widgets/finances/finance_card.dart';
import 'package:arcopen_enquirer/widgets/misc/page_skeleton.dart';
import 'package:arcopen_enquirer/widgets/states/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';

class FinancesScreen extends StatefulWidget {
  const FinancesScreen({Key? key}) : super(key: key);

  @override
  _FinancesScreenState createState() => _FinancesScreenState();
}

class _FinancesScreenState extends State<FinancesScreen> {
  late int _selectedIndex;
  FinanceController _financeController = FinanceController();

  @override
  void initState() {
    _selectedIndex = 0;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _financeController.loadFinanceDetails();
    });
    super.initState();
  }

  void _updateActiveIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: OkitoBuilder(
          controller: _financeController,
          builder: () {
            return PageSkeleton(
              retryCallback: _financeController.loadFinanceDetails,
              controller: _financeController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      _BalanceCard(amount: _financeController.totalPaid, totalJobs: _financeController.totalJobs),
                      SizedBox(width: 10),
                      _WalletCard(
                        amount: _financeController.funded,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    height: 40,
                    child: ToggleButtons(
                      borderRadius: BorderRadius.circular(8.0),
                      borderWidth: 0,
                      borderColor: Okito.theme.primaryColor,
                      onPressed: (index) {
                        _updateActiveIndex(index);
                      },
                      children: [
                        Container(
                          color: _selectedIndex == 0 ? Okito.theme.primaryColor : Colors.white,
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.4,
                          alignment: Alignment.center,
                          child: Text(
                            "Paid",
                            style: Okito.theme.textTheme.bodyText2!.copyWith(
                              fontSize: 12.0,
                              color: _selectedIndex == 0 ? Colors.white : ColorConstants.greyColor,
                            ),
                          ),
                        ),
                        Container(
                          color: _selectedIndex == 1 ? Okito.theme.primaryColor : Colors.white,
                          width: MediaQuery.of(context).size.width * 0.4,
                          alignment: Alignment.center,
                          child: Text(
                            "Unpaid",
                            style: Okito.theme.textTheme.bodyText2!.copyWith(
                              fontSize: 12.0,
                              color: _selectedIndex == 1 ? Colors.white : ColorConstants.greyColor,
                            ),
                          ),
                        ),
                      ],
                      isSelected: [_selectedIndex == 0, _selectedIndex == 1],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "TRANSACTIONS",
                          style: Okito.theme.textTheme.bodyText2!.copyWith(
                            fontSize: 10.0,
                            letterSpacing: 1.3,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.greyColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (_selectedIndex == 0) _PaidTransactionsTab(transactions: _financeController.paidTransactions),
                  if (_selectedIndex == 1) _UnPaidTransactionsTab(transactions: _financeController.unpaidTransactions),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final String amount, totalJobs;
  const _BalanceCard({Key? key, required this.amount, required this.totalJobs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "TOTAL EARNED",
                style: Okito.theme.textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 10),
              Text(
                amount,
                style: Okito.theme.textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                  color: ColorConstants.greenColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                totalJobs,
                overflow: TextOverflow.ellipsis,
                style: Okito.theme.textTheme.bodyText2!.copyWith(
                  color: ColorConstants.greyColor,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WalletCard extends StatelessWidget {
  final String amount;
  const _WalletCard({Key? key, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "FUNDED",
                style: Okito.theme.textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 10),
              Text(
                amount,
                style: Okito.theme.textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                  color: Okito.theme.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaidTransactionsTab extends StatelessWidget {
  const _PaidTransactionsTab({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  final List<PaidTransaction> transactions;

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) return EmptyState();
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        PaidTransaction transaction = transactions[index];
        final Finance finance = Finance(
          amount: transaction.amountPaid,
          company: transaction.memberName,
          createdAt: transaction.paymentDate,
          date: transaction.paymentDate,
          jobTitle: transaction.businessName,
          jobType: transaction.jobType,
          profilePicture: transaction.profilePic,
          paid: true,
          stars: transaction.stars,
        );
        return FinanceCard(
          finance: finance,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          KRouter().pop();
                        },
                        iconSize: 10,
                        icon: Icon(PhosphorIcons.x_bold),
                      ),
                      Expanded(
                        child: Text(
                          transaction.businessName,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                  content: InvoiceDetailsDialog(
                    isPaid: true,
                    finance: finance,
                    transactionId: transaction.transactionId,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _UnPaidTransactionsTab extends StatelessWidget {
  const _UnPaidTransactionsTab({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  final List<UnpaidTransaction> transactions;

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) return EmptyState();
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        UnpaidTransaction transaction = transactions[index];
        final Finance finance = Finance(
          paid: false,
          stars: transaction.stars,
          amount: transaction.amountPaid,
          company: transaction.memberName,
          createdAt: "",
          date: "",
          jobTitle: transaction.businessName,
          jobType: transaction.jobType,
          profilePicture: transaction.profilePic,
        );

        return FinanceCard(
          finance: finance,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          KRouter().pop();
                        },
                        iconSize: 10,
                        icon: Icon(PhosphorIcons.x_bold),
                      ),
                      Expanded(
                        child: Text(
                          transaction.businessName,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                  content: InvoiceDetailsDialog(
                    isPaid: false,
                    finance: finance,
                    transactionId: transaction.transactionId,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
