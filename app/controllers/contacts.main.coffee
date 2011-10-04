Spine   = require('spine')
Contact = require('models/contact')
Manager = require('spine/lib/manager')
$       = Spine.$

$.fn.serializeForm = ->
  result = {}
  for item in $(@).serializeArray()
    result[item.name] = item.value
  result

class Show extends Spine.Controller
  className: 'show'
  
  events:
    'click .edit': 'edit'
  
  constructor: ->
    super
    @active @change
  
  render: ->
    @html require('views/show')(@item)
    
  change: (params) =>
    @item = Contact.find(params.id)
    @render()
    
  edit: ->
    @navigate('/contacts', @item.id, 'edit')

class Edit extends Spine.Controller
  className: 'edit'
  
  events:
    'submit form': 'submit'
    'click .save': 'submit'
    'click .delete': 'delete'
    'click .addLocation': 'addLocation'
    'click .destroyLocation': 'destroyLocation'
    
  elements: 
    'form': 'form'
    
  constructor: ->
    super
    @active @change
    Contact.bind 'change', (contact) =>
      @render() if contact.eql(@item)
  
  render: ->
    @html require('views/form')(@item)
    
  change: (params) =>
    @item = Contact.find(params.id)
    @render()
    
  submit: (e) ->
    e.preventDefault()
    params = @form.serializeForm()
    @item.updateAttributes(params)
    @navigate('/contacts', @item.id)
    
  delete: ->
    @item.destroy() if confirm('Are you sure?')
    
  addLocation: ->
    @item.addLocation()
  
  destroyLocation: ->
    @item.destroyLocation()
    
class Main extends Spine.Controller
  className: 'main viewport'
  
  constructor: ->
    super
    @show    = new Show
    @edit    = new Edit
    
    @manager = new Manager(@show, @edit)
    
    @append @show, @edit
    
module.exports = Main