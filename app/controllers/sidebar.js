jQuery(function($){

window.Sidebar = Spine.Controller.create({
  elements: {
    ".items": "items",
    "input": "input"
  },
  
  events: {
    "click .items li": "click",
    "click button": "create",
    "keyup input": "filter"
  },
  
  scoped: ["render", "change"],
  
  init: function(){
    Contact.bind("refresh change", this.render);
    this.App.bind("show:contact edit:contact", this.change);    
  },
  
  template: function(items){
    return($("#contactsTemplate").tmpl(items));
  },
  
  filter: function(){
    this.query = this.input.val();
    this.render();
  },
  
  render: function(){
    // Filter items by query
    var items = Contact.filter(this.query);
    
    // Filter by first name
    items = items.sort(function(a, b){ return a.first_name > b.first_name });
    
    // Render the list of contacts
    this.items.html(this.template(items));
    
    // Set the currently selected item
    this.setCurrent(this.current);
    
    // Select first contact, if nothing else is selected
    if ( !this.current || !this.current.exists() )
      this.children(":first").click();
  },
  
  children: function(sel){
    return this.items.find("li" + (sel || ""));
  },
  
  change: function(item){
    this.setCurrent(item);
  },
  
  setCurrent: function(item){
    if ( !item ) return;
    this.current = item;

    this.deactivate();
    this.children().forItem(this.current).addClass("current");    
  },
  
  deactivate: function(){
    this.children().removeClass("current");
  },
  
  click: function(e){
    var item = $(e.target).item();
    this.App.trigger("show:contact", item);
  },
  
  create: function(){
    var item = Contact.create();
    this.App.trigger("edit:contact", item);
  }
});
  
})