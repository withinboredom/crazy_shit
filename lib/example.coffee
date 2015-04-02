cqrs.context 'Conference': =>
  cqrs.valueType 'Attendee': =>
    cqrs.property 'FirstName'
    cqrs.property 'LastName'
    cqrs.property 'Email'
  cqrs.aggregate 'Conference': (id) =>
    cqrs.property 'AccessCode'
    cqrs.property 'OwnerName'
    cqrs.property 'OwnerEmail'
    cqrs.property 'Slug'
    cqrs.property 'WasEverPublished'
    cqrs.property 'Seats', Map
    cqrs.property 'Name'
    cqrs.property 'Description'
    cqrs.property 'Location'
    cqrs.property 'Tagline'
    cqrs.property 'TwitterSearch'
    cqrs.property 'StartDate'
    cqrs.property 'EndDate'
    cqrs.property 'IsPublished'
    cqrs.command 'CreateConference': (conference) =>
      failif: =>
        @found()
      logic: =>
        @isPublished = false
      reject: =>
        return new Error 'Chosen conference is taken'
      accept: =>
        cqrs.emit 'ConferenceCreated',
          conference: conference
    cqrs.command 'CreateSeat': (seat) =>
      failif: =>
        @notFound()
      logic: =>
        @Seats.push seat
      reject: =>
        return new Error 'Not Found'
      accept: =>
        if @WasEverPublished
          cqrs.emit 'SeatCreated',
            seat: seat
    cqrs.read 'FindConferenceBySlug': (slug) =>
      data: =>
        return Conference.find
          Slug: slug
    cqrs.read 'FindConferenceByEmail': (email, accessCode) =>
      data: =>
        return Conference.find
          OwnerEmail: email
          AccessCode: accessCode
    cqrs.read 'FindSeatTypes': () =>
      data: =>
        conf = Conference.find id
        return conf.Seats
  cqrs.aggregate 'Order': (id) =>
    states:
      Pending: 0
      Paid: 1
    relatesTo 'Conference'