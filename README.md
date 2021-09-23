Know Thy Population: Population Segmentation  
=============================================

Central City Concern is a nonprofit organization in Portland, Oregon that is committed to ending homelessness. The need to understand, quantify, and plan strategically around the populations we serve motivated a project, which we lovingly refer to as "KPOP." KPOP is both a framework for understanding our population as well as an algorithm for sorting our clients into segments.

### The Framework  

![Framework](/img/kpop_framework.PNG)  
The KPOP framework consists of 19 subgroups, which are defined primarily by age, health problems, and hospital utilization. We recognize that there are many other aspects of our clients' lives that are relevant to their health and well-being, but this framework provides us with useful insights into the most common patterns of needs.

### The Process  

![Process](/img/kpop_process.PNG)  
KPOP began as a design project, which included the brightest minds from around the organization. We began with the assumption that all of the knowledge we need to segment our population already exists, but the trouble is that the knowledge lives inside of multiple people's heads. We embarked on the process outlined below \(see our [slide deck](https://bitbucket.org/centralcityconcern/kpop/src/master/slides) for more details\) to develop the final algorithm.

After a series of ideation sessions with our experts, we dove into quantitative analysis using latent class models. We then transformed the output of the models into a card game to allow us to include our experts in the analysis processes. To enable us to incorporate the qualitative analysis into the final algorithm, we mapped the feedback to original data via the latent class models. After the multiple translations of the data, the resulting subgroups were too fuzzy to train our algorithm. To address this we simulated training data based on the empirical distributions of characteristics coupled with our qualitative understanding of what the subgroups should look like. Finally, we trained a neural network to recognize these subgroups, and then deployed this model to run regularly in our enterprise data warehouse.

When it comes to population segmentation, there are no right or wrong answers--but there are useful ones! KPOP is a work-in-progress, and is our current best guess as to what a useful segmentation framework looks like in our context.
