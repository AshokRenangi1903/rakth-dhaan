import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("FAQs"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // q1
          GFAccordion(
            titleBorderRadius: BorderRadius.circular(10),
            collapsedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            expandedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            contentBackgroundColor: Color.fromARGB(190, 245, 231, 248),
            title: "Who can donate blood?",
            content:
                "In most states, donors must be age 17 or older. Some states allow donation by 16-year-olds with a signed parental consent form. Donors must weigh at least 110 pounds and be in good health. Additional eligibility criteria apply.",
          ),

          //q2
          GFAccordion(
            titleBorderRadius: BorderRadius.circular(10),
            collapsedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            expandedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            contentBackgroundColor: Color.fromARGB(190, 245, 231, 248),
            title: "What are the three parts of blood donation?",
            content:
                "For a whole blood donation, one pint of blood is collected and separated into its three components: plasma, platelets and red blood cells.",
          ),
          //q3
          GFAccordion(
            titleBorderRadius: BorderRadius.circular(10),
            collapsedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            expandedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            contentBackgroundColor: Color.fromARGB(190, 245, 231, 248),
            title: "Who may donate blood?",
            content:
                "Donors should be between the ages of 18 and 65, weigh at least 50 kg and not have donated blood within the previous 12 weeks (for males).",
          ),

          //q4
          GFAccordion(
            titleBorderRadius: BorderRadius.circular(10),
            collapsedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            expandedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            contentBackgroundColor: Color.fromARGB(190, 245, 231, 248),
            title: "Is there anything special I need to do before donating?",
            content:
                "Eat at your regular mealtimes and drink plenty of fluid before you donate blood. Have a snack at least four hours before you donate, but do not eat too much right before the donation.",
          ),

          //q5
          GFAccordion(
            titleBorderRadius: BorderRadius.circular(10),
            collapsedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            expandedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            contentBackgroundColor: Color.fromARGB(190, 245, 231, 248),
            title: "What is the procedure when I donate blood?",
            content:
                "Firstly, you will be asked to provide personal details such as your name, address, age, weight, ID number and/or date of birth. A medical history is taken by means of a written questionnaire.",
          ),

          //q6
          GFAccordion(
            titleBorderRadius: BorderRadius.circular(10),
            collapsedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            expandedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            contentBackgroundColor: Color.fromARGB(190, 245, 231, 248),
            title: "How long does the donation take?",
            content:
                "The procedure, which is performed by a trained, skilled health-care professional, takes approximately 30 minutes. You will give about 450 ml of blood, after which you will be advised to remain on the donor bed for a few minutes longer and then to take some refreshments. Plan to spend about half an hour to an hour at the blood donor centre for the entire process, depending on the size of the centre and the number of donors.",
          ),

          //q7
          GFAccordion(
            titleBorderRadius: BorderRadius.circular(10),
            collapsedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            expandedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            contentBackgroundColor: Color.fromARGB(190, 245, 231, 248),
            title: "What is a “unit” of blood?",
            content:
                "A unit is about 450 ml of donated blood. The average adult has between four and five litres of blood in his or her body, and can easily spare one unit.",
          ),

          //q8
          GFAccordion(
            titleBorderRadius: BorderRadius.circular(10),
            collapsedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            expandedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            contentBackgroundColor: Color.fromARGB(190, 245, 231, 248),
            title: "Is it possible to get HIV/AIDS from donating blood?",
            content:
                "No. You cannot get AIDS or any other infectious disease by giving blood. The materials used for your blood donation, including the needle, blood collection bag, tubes and finger prick needle are new, sterile and disposable. These are used only once for your blood donation and then destroyed after use.",
          ),

          //q9
          GFAccordion(
            titleBorderRadius: BorderRadius.circular(10),
            collapsedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            expandedTitleBackgroundColor: Color.fromARGB(255, 241, 218, 244),
            contentBackgroundColor: Color.fromARGB(190, 245, 231, 248),
            title: "What is the most important blood to donate?",
            content:
                "A+ is a common blood type which makes it the most needed blood for transfusions, so you may be asked to donate whole blood. Whole blood donors are eligible to give blood every 8 weeks. Platelets are another way to maximize your donation as an A+ blood type.",
          ),
        ]),
      ),
    );
  }
}
