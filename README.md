
# A/B Test For Simple People

A/B testing has a unique technical flaw and strength: by design, the experience needs to be tightly coupled with your application.

The data aggregation, on the other hand, is a little complicated and involves some machinery overhead.

Then, interpreting the data is mathy. 

First, define you Experiments & Variations. Both have simple labels for 'name'. Variations have automatic `letter_designation` field which is set automatically and can't be changed.

Next, your code needs a 'key' — a unique string to identy

Here, Splut will solve part of your problem, expecting you to bring to the table any of:

• A logged-in user
• A session
• A visit

Based on any of these three (your choice), you can give Splut this contextual object + Experiment, and Splut will handle putting (and keeping them in) the correcti
Assuming you  have no logged-in user, you must use a session or a visit.

To define a visit, you can piggyback off of my other gem Universal Track Manager



You will need to look up your own experiment:
```
experiment = Splut::Experiment.find_by(...)
```

Then, put your visitor into your experiment:

```
visit =  current_visit  # defined by universal-track-manager gem
exp = Splut::Experiment.find_by(name: "My Experiment 1")
participant = exp.participate!(visit)
variation = participant.variation
```

You are now free to do things like get the `variation.name` and `variation.letter_designation`

```
selector = ContentSelector.new( variation: variation )
@my_image = selector.get_image
```

In this mini-example, you would implement a service class called `ContentSelector` which receives a `Splut::Variation` object when it is initialized (a service object).

On this service object you would implement `get_image` to return an image based on the variation group the visitor is put into. 

Alternatively, you can implement additional parameters passed into the service object that refine the result, but contine to result in variation content as defined. 

(For example, date-based incentivization + an A/B test; or, a user-specific piece of content + an A/B test)

There are of course several other ways to implement this and no service class is necessary. 

Then, you'll use the result from `get_image` (or any other kind of variated result you can think of) to render out a result.

# Install

rails generate splut:install