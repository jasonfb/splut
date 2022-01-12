
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

# Install

rails generate splut:install