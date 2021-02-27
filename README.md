[![codecov](https://codecov.io/gh/theguuholi/peek_code/branch/main/graph/badge.svg?token=MCPYCP2HEI)](https://codecov.io/gh/theguuholi/peek_code)

[![Pipeline Status](https://github.com/theguuholi/peek_code/workflows/CI/badge.svg)](https://github.com/theguuholi/peek_code/actions)


# GraphQL back-end API take-home challenge

![gql+peek](https://user-images.githubusercontent.com/221693/62170358-f89cfd80-b2df-11e9-9488-e913f1866613.png)

We here at Peek are big fans of GraphQL. We like the benefits it provides over a classical REST API, including the
strong typing, the flexibility for the client to request exactly what they need, and the automatic documentation it
provides.

#### Orders

We don't need anything too complex. An order can be as simple as a description of the item(s) purchased, and the total
cost. And since we're allowing multiple payments, we need to keep track of the balance due.

It might also be nice to allow clients to request the list of payments that have been applied to an order, so let's
include that too.

#### Payments

A payment should belong to an order, and just define an amount paid. It's probably also a good idea to keep track of



* a mutation to apply a payment to an order

### API Expectations & Extras

At a minimum, we ask the above be implemented, and at least 2 of the following extra expectations that your API will provide:

* All mutations should be idempotent
  * If a payment is submitted twice, don't overcharge the customer.
* Explore subscriptions
  * Implement a basic subscription so a client can be notified anytime an order is placed or a payment is made.


You can also find many possibly useful links from the
[Awesome GraphQL list](https://github.com/chentsulin/awesome-graphql).


# Payload

mutation{
  createOrder(payload: {description: "Macbook", total: 1000.0,
    payments: [{
      amount: 10.5,
      appliedAt: "2021-02-26T22:33:40.999287",
      note: "simple payment"
    },
      {
      amount: 10.5,
      appliedAt: "2021-02-26T22:33:40.999287",
      note: "simple payment"
    }
    ]
  }){
    messages{
      code
      field
      message
      template
    }
    result{
      balanceDue
      description
      id
      payments{
        orderId
        amount
        appliedAt
        id
        note
      }
      total
    }
  }
}

