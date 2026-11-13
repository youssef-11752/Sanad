import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/role_model.dart';
import '../provider/type_provider.dart';
import '../widgets/selection_btn.dart';
import '../widgets/selection_cards.dart';
import '../widgets/selection_header.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  // function runs when the continue button is pressed "go to client or provider home screen"
  void _onContinuePressed(BuildContext context) {
    final selectedRole =
        context.read<RoleSelectionProvider>().selectedRole;

    if (selectedRole == UserRoleType.client) {
      // go to the client screen 
    } else {
      // go to the provider screen 
    }
  }

  @override
  Widget build(BuildContext context) {

    // listen to changes in role selection provider
    final roleProvider = context.watch<RoleSelectionProvider>();

    return Directionality( // to make the whole page from right to left even the cards and the check container in it
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 251, 245, 231),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // calling header widget
                  SelectionHeader(),

                  SizedBox(height: 36),
                  // badge after header part
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.teal[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'أهلا بيك في سند',
                        style: TextStyle(color: Colors.teal[700]),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'إزاي نقدر نكون سندك؟',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700],
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'اختار طريقة استخدامك, تقدر تضيف حساب مهني في أي وقت',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),

                  SizedBox(height: 32),

                  // display role cards "from provider file list" , spread operator add widget to the list whre the map creates widget for each card "each role"
                  ...roleProvider.roles.map((role) { // go through each item in the list 
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SelectionCards(
                        role: role, // from modle filr
                        // check whether this card is selected or not
                        isSelected: roleProvider.selectedRole == role.type,
                        // update the selected role using provider when the user taps on the card
                        onTap: () {
                          context.read<RoleSelectionProvider>().selectRole(role.type); // functon that changes the selected role type runs
                        },
                      ),
                    );
                  }),

                  SizedBox(height: 30),

                  // btn text changes according to the selected role
                  SelectionBtn(
                    label: roleProvider.activeRoleModel.buttonText, // get the btn txt from the currently selected role model
                    onPressed: () => _onContinuePressed(context), // call continue function that navigates user to the selected role screen
                  ),

                  SizedBox(height: 16),

                  Center(
                    child: Text(
                      'بيوت متطمنة، وصنايعية محل ثقة',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
