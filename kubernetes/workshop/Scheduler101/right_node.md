# How Kubernetes Selects The Right node?

- This part takes the most work as there are several algorithms that the Scheduler must use to make this decision. Some of those algorithms depend on user-supplied options, while Kubernetes itself calculates others.
- In simple world we can explain in simple questions - just assume schduler ask these questions to nodes-
# Do You Have What it Takes To Run This Pod?

- A node may be overloaded with so many busy pods consuming most of its CPU and memory. So, when the scheduler has a Pod to deploy, it determines whether or not the node has the necessary resources.
- If a Pod deploy to node that doesnot have enough memeory(just an example ) that pod has requesting that hosted appliction might behave unexpectedly or even crash.

# Are You a Better Candidate For Having This Pod ?

- In addition to true/false decisions a.k.a predicates, the scheduler executes some calculations (or functions) to determine which node is more suited to be hosting the pod in question.
- For example, a node where the pod image is already present (like it’s been pulled before in a previous deployment) has a better chance of having the pod scheduled to it because no time will be wasted downloading the image again.
- Another example is when the scheduler favors a node that does not include other pods of the same Service. This algorithm helps spread the Service pods on multiple nodes as much as possible so that one node failure does not cause the entire Service to go down. Such a decision-making method is called the spreading function.
- Several decisions, like the above examples, are grouped, and weight is calculated for each node based on the final decision. The node with the highest priority wins the pod deployment.
# The Final Decision

- The scheduler determines all the nodes that it knows they exist and are healthy.
- The scheduler runs the  tests to filter out nodes that are not suitable. The rest of the nodes form a group of possible nodes.
- The scheduler runs priority tests against the possible nodes. Candidates are ordered by their score with the highest ones on the top. At this point, the highest-scoring possible node gets chosen. But sometimes there may be more than one node with the same score.
- If nodes have the same score, they are moved to the final list. The Kubernetes Scheduler selects the winning node in a round-robin fashion to ensure that it equally spreads the load among the machines.
