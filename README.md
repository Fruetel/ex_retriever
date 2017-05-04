# ExRetriever

ExRetriever is a small microservice application that can be used for document retrieval in a distributed web crawler architecture. It fetches messages containing URLs from a RabbitMq exchange, retrieves the URLs and publishes the result to another exchange.

RabbitMq parameters can be configured by setting appropriate environment variables:

RABBITMQ_URL
URL of the RabbitMq instance to use, e.g. amqp://user:password@rabbitmq.example.com

INCOMING_EXCHANGE
Name of the exchange that delivers messages for URLs to be retrieved

INCOMING_ROUTING_KEY
Routing key that is used to bind to the incoming exchange

SERVICE_NAME
Name of the service, e.g. ex_retriever

OUTGOING_EXCHANGE
Name of the exchange where retrieved documents should be published

OUTGOING_ROUTING_KEY
Routing key for published documents
