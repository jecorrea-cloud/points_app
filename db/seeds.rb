puts "Seeding transactions..."

Transaction.create([
    { "payer": "DANNON", "points": 1000, "date": "2020-11-02T14:00:00Z" },
    { "payer": "UNILEVER", "points": 200, "date": "2020-10-31T11:00:00Z" },
    { "payer": "DANNON", "points": -200, "date": "2020-10-31T15:00:00Z" },
    { "payer": "MILLER COORS", "points": 10000, "date": "2020-11-01T14:00:00Z" },
    { "payer": "DANNON", "points": 300, "date": "2020-10-31T10:00:00Z" }
])

puts "Done seeding!"