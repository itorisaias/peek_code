[![codecov](https://codecov.io/gh/theguuholi/peek_code/branch/main/graph/badge.svg?token=MCPYCP2HEI)](https://codecov.io/gh/theguuholi/peek_code)

[![Pipeline Status](https://github.com/theguuholi/peek_code/workflows/CI/badge.svg)](https://github.com/theguuholi/peek_code/actions)


# GraphQL back-end API take-home challenge

![gql+peek](https://user-images.githubusercontent.com/221693/62170358-f89cfd80-b2df-11e9-9488-e913f1866613.png)

We here at Peek are big fans of GraphQL. We like the benefits it provides over a classical REST API, including the
strong typing, the flexibility for the client to request exactly what they need, and the automatic documentation it
provides.

## Problem Description

We need to build a simple order management API. This API should accept placement of orders and payments for those
orders. But, we don't want to require full payment up front. We'd like to allow installment payments over time as well.

#### Orders

We don't need anything too complex. An order can be as simple as a description of the item(s) purchased, and the total
cost. And since we're allowing multiple payments, we need to keep track of the balance due.

It might also be nice to allow clients to request the list of payments that have been applied to an order, so let's
include that too.

We also need some way to identify the order.

So an `Order` might look like:

* `id` - Some identifier
* `description` - Just a string describing the product(s) purchased
* `total` - The total value of the order
* `balanceDue` - How much is still owed
* `paymentsApplied` - The list of payments applied to this order so far

#### Payments

A payment should belong to an order, and just define an amount paid. It's probably also a good idea to keep track of
when the payment was made. Maybe an optional note might be useful too.

So a `Payment` might look something like this:

* `id` - Some identifier
* `amount` - The amount of the payment
* `appliedAt` - When the payment was applied
* `note` - An optional string

### Queries & Mutations

The API should provide a certain set of queries and mutations to be useful.

At a minimum, we need:

* a query to fetch all orders
* a mutation to create an order
* a mutation to apply a payment to an order

### API Expectations & Extras

At a minimum, we ask the above be implemented, and at least 2 of the following extra expectations that your API will provide:

* Don't expose auto-incrementing IDs through your API
  * If you choose to use auto-incrementing IDs for your objects, don't expose them directly through the API. Use some
  kind of obfuscation or generate unique IDs of some sort.
* All mutations should be idempotent
  * If a payment is submitted twice, don't overcharge the customer.
* Provide an atomic "place order and pay" mutation
  * Allow a client to place an order and pay in a single mutation, but ensure that it's atomic.
  * What use cases might result in a failure?
* Explore subscriptions
  * Implement a basic subscription so a client can be notified anytime an order is placed or a payment is made.

## Useful Tools & Info

There are many clients for interacting with and testing GraphQL APIs, some of the ones we've found useful are:

* [graphql-playground](https://github.com/prisma/graphql-playground) - a web-based GraphQL IDE of sorts; allows browsing
the documentation,
query auto-completion, etc.
* [Insomnia](https://insomnia.rest/graphql/) - a desktop API testing application with good GraphQL support.

You can also find many possibly useful links from the
[Awesome GraphQL list](https://github.com/chentsulin/awesome-graphql).


# Payload

mutation{
  createOrder(payload: {description: "Macbook", total: 1000.0,
    payments: {
      amount: 10.5,
      appliedAt: "2021-02-26T22:33:40.999287",
      note: "simple payment"
    }
  }){
    balanceDue
    description
    id
    payments{
      amount
      appliedAt
      id
      note
    }
    total
  }
}
