class Note{
  String Owner_Number,Shop_Name;
  Note(this.Owner_Number,this.Shop_Name);
  Note.fromJson(Map<String, dynamic>json){
    Owner_Number=json['Owner_Number'];
    Shop_Name=json['Shop_Name'];
  }
}