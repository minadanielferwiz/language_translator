import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslator extends StatefulWidget {
  const LanguageTranslator({super.key});

  @override
  State<LanguageTranslator> createState() => _LanguageTranslatorState();
}

class _LanguageTranslatorState extends State<LanguageTranslator> {
  var language = ["Arabic","English"];
  var originLanguage = "From";
  var DestinationLanguage = "To";
  var output = "";
  TextEditingController languageController = TextEditingController();
  void translate(String src,String destination,String input) async{
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input,from: src,to: destination);
    setState(() {
      output = translation.text.toString();
    });
    if(src=='--' || destination=='--'){
      output = "fail to translate";
    }
  }

  String getLanguage(String language){
    if(language =="English"){
      return "en";
    }else if(language == "Arabic"){
      return "ar";
    }

    return "--";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff10223d),
      appBar: AppBar(
        title: Text("Language Translator",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color(0xff10223d),
        elevation: 0.0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            
            children: [
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(focusColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.white,
                  hint: Text(originLanguage,style: TextStyle(color: Colors.white),),
                  icon:Icon(Icons.keyboard_arrow_down),
                  items: language.map((String dropdownStringItem){
                    return DropdownMenuItem(child: Text(dropdownStringItem),value: dropdownStringItem,);
                  }).toList(),
                  onChanged: (String? value) =>{
                    setState(() {
                      originLanguage = value!;
                    })
                  } ,

                  ),
                  SizedBox(width: 40,),
                  Icon(Icons.arrow_right_alt_outlined,color: Colors.white,size: 40,),
                  SizedBox(width: 40,),
                  DropdownButton(focusColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.white,
                  hint: Text(DestinationLanguage,style: TextStyle(color: Colors.white),),
                  icon:Icon(Icons.keyboard_arrow_down),
                  items: language.map((String dropdownStringItem){
                    return DropdownMenuItem(child: Text(dropdownStringItem),value: dropdownStringItem,);
                  }).toList(),
                  onChanged: (String? value) =>{
                    setState(() {
                      DestinationLanguage = value!;
                    })
                  } ,

                  ),
                ],
              ),
              SizedBox(height: 40,),
              Padding(padding: EdgeInsets.all(8),
              child: TextFormField(
                cursorColor: Colors.white,
                autofocus: false,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "please enter your text..",
                  labelStyle: TextStyle(fontSize: 18,color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 1)
                  ),
                  errorStyle: TextStyle(color: Colors.red,fontSize: 18)
                ),
                controller: languageController,
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'please enter text to translate';
                  }
                  return null;
                },
              ),),
              Padding(padding: EdgeInsets.all(8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xff2b3c5a) ),
                onPressed: (){
                  translate(getLanguage(originLanguage), getLanguage(DestinationLanguage),languageController.text.toString());
                }, child: Text("Translate",style: TextStyle(color: Colors.white),)),),
                SizedBox(height: 20,),
                Text(
                  "\n$output",
                  style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                )
                
            ],
          ),
        ),
      ),
    );
  }
}