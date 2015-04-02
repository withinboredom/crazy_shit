@cqrs = {}

cqrs.context = (theContext) =>

  _.each theContext, (value, name) =>
    C = class
    C.prototype[name] = value()
    debugger

  c = Immutable.fromJS(theContext)
  c.forEach (value, name) =>
    @[name] = new cqrs.Context value

class cqrs.Context