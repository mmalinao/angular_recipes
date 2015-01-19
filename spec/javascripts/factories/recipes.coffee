Factory.define "recipe", ->
  @sequence 'id'
  @sequence 'name', (i) ->
    "Recipe #{i}"
  @sequence 'instructions', (i) ->
    "Lorem ipsum #{i}"
