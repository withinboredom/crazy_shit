cqrs.valueType = (vtype) ->
  debugger
  c = Immutable.fromJS(vtype)

  c.forEach (value, name) ->
    @[name] = cqrs.ValueType.Generate(value)


class cqrs.ValueType
  constructor: (init, properties) ->

  @Generate: (init) ->
    return (properties) ->
      return new ValueType init, properties