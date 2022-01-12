
# A/B Test For Simple People

A/B testing has a unique technical flaw and strength: by design, the experience needs to be tightly coupled with your application.

The data aggregation, on the other hand, is a little complicated and involves some machinery overhead.

Then, interpreting the data is mathy. 


# Install

rails generate splut:install


# Experiments, Variations, Impressinos, and SegementParticipants

This is the basic design of Splut. Splut creates the four tables shown in rectagles. The spluttable thing belongs to both Impression and SegementParticipant as **polymorphic**, but you will pass it into the experiment object. 

![Splut ERD-2022-01-11](https://user-images.githubusercontent.com/59002/149049308-8bf00ff8-498b-4f74-9240-7520ea1569d5.jpg)

# Who Am I

First, define your Experiments & Variations. Both have simple labels for 'name'. Variations have automatic `letter_designation` field which is set automatically and can't be changed. # TODO: IMPLEMENT ME

Next, your code needs a 'key' — a unique string to identy

Here, Splut will solve part of your problem, expecting you to bring to the table any of:

1) A logged-in user
2) A session
3) A visit
4) anything that be attached to a Rails model using polymorphism

Based on any of these three (your choice), you can give Splut this contextual object + Experiment, and Splut will handle putting (and keeping them in) the correcti
If you have no logged-in user, you can't use choice #1.
To define a visit, you can piggyback off of my other gem Universal Track Manager:
https://github.com/jasonfb/universal_track_manager/

Otherwise, you're on your own for how you want to define the context of the visitor/customer/user.

# An Experiment & A Visitor

You will need to look up your own experiment:
```
experiment = Splut::Experiment.find_by(...)
```

Then, get your visitor from universal track manager :

```
visit =  current_visit  # defined by universal-track-manager gem
```

then, put your visitor into your experiment:
```
exp = Splut::Experiment.find_by(name: "My Experiment 1")
participant = exp.participate!(visit)
@variation = participant.variation
```

You are now free to do things like get the `@variation.name` and `@variation.letter_designation`

```
selector = ContentSelector.new( variation: @variation )
@my_image = selector.get_image
```

(note the example switches into the instance variable `@` syntax here for no good reason. perhaps, say, you are in a controller and are preparing this for a view, you might want to use an instance variable, but the choice is arbitrary in this example.)

In this mini-example, you would implement a service class called `ContentSelector` which receives a `Splut::Variation` object when it is initialized (a service object).

On this service object you would implement `get_image` to return an image based on the variation group the visitor is put into. 

Alternatively, you can implement additional parameters passed into the service object that refine the result, but contine to result in variation content as defined. 

(For example, date-based incentivization + an A/B test; or, a user-specific piece of content + an A/B test)

There are of course several other ways to implement this and no service class is necessary. 

Then, you'll use the result from `get_image` (or any other kind of variated result you can think of) to render out a result.


# Success!

You have two choices:
1) You can call success! on the Impression
2) You can call success! on the SegmentParticipant object

Either way, both objects will be set to success. However, if you call it on the SegmentParticipant, on ly the last Impression will be set to success. 

(Since Impression belongs to SegmentParticipant, there is only one to set to successful.)


Either way, the Variation keeps track of four key metrics, using the magical **counter_culture gem**:

• _impression_total
• _segmentation_total
• _impression_success
• _segmentation_success

Be sure to see the counter culture docs for some under the hood details:

https://github.com/magnusvk/counter_culture


# Et Violá

Your variations are tracked with totals and success measures. 