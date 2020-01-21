# Recommendation for Newcomer Cloud Services 

Our solution consists of:
1. A mechanism to allow users to self-assess the accuracy of their recommendations and autonomously decide on whether to participate in the recommendation process or not.
2. A machine learning technique that generates reliable endorsements on newcomer cloud services through extracting hidden similarities      among the specications of new and existing ones
3. A dishonesty-aware aggregation technique for endorsements coming from multiple advisors
4. A credibility update mechanism that captures the dynamism in the endorsers' credibility
5. An incentive mechanism to motivate advisors to participate in the endorsement process


## Requirements
* Matlab (2016A and above)
* Python 3
* Python PIL (pip install Pillow)
* The CloudHarmony dataset (available in Excel format in the file "Cloud.xlsx").
* The Epinions dataset  (available in text format in the file "Epinions.txt").

## Implementation

* The CloudHarmony dataset is available in Excel format in the file "Cloud.xlsx".
* The Epinions dataset is available in text format in the file "Epinions.txt".
* The main class is "Main.m".
* The Dempster-Shafer aggregation code is described in the class "DempsterShafer.m".
* The decision tree code is described in the class "DecBoot.m".
* The comparison with the "Fuzzy Formal Concept Analysis" model is available in the folder "Fuzzy FCA".


For the fuzzy logic part (Fuzzy FCA), we designed our system logic using Fuzzy Logic Designer from the MATLAB toolkit. Once we have the .fis (fuzzy inference system) file which describes our fuzzy system, we connect our Python code to MATLAB in order to let it automatically evaluate users' input (eg. Promised_Availability, Actual_Availability, Outages, etc.).

**Please note: BigTrustScheduling is not yet production ready. However, the project is rapidly progressing with some very useful features.**
