var Contact = Spine.Model.setup("Contact", ["first_name", "last_name", "email",
                                            "mobile", "work", "address", "notes"]);

// Persist model between page reloads
Contact.extend(Spine.Model.Local);
Contact.extend(Spine.Model.Filter);

Contact.selectAttributes = ["first_name", "last_name", "email", 
                            "mobile", "work", "address"];

Contact.nameSort = function(a, b){ return a.first_name > b.first_name };

Contact.include({
  selectAttributes: function(){
    var result = {};
    for (var i=0; i < this.parent.selectAttributes.length; i++) {
      var attr = this.parent.selectAttributes[i];
      result[attr] = this[attr];
    }
    return result;
  },
  
  fullName: function(){
    if ( !this.first_name && !this.last_name ) return;
    return(this.first_name + " " + this.last_name);
  }
});