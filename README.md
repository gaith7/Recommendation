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
* The CloudHarmony dataset is available in Excel format in the file "Cloud.xlsx".
* The Epinions dataset is available in text format in the file "Epinions.txt".

## Implementation
There are two files for the code

* The CloudHarmony dataset is available in Excel format in the file "Cloud.xlsx".
* The Epinions dataset is available in text format in the file "Epinions.txt".
* The main class is "Main.m".
* The Dempster-Shafer aggregation code is described in the class "DempsterShafer.m".
* The decision tree code is described in the class "DecBoot.m".
* The comparison with the "Fuzzy Formal Concept Analysis" model is available in the folder "Fuzzy FCA".


For the fuzzy logic part (Fuzzy FCA), we designed our system logic beforehand by using Fuzzy Logic Designer inside MATLAB toolkit. Once we have the .fis (fuzzy inference system) file which describes our fuzzy system, we connect our Python code to MATLAB in order to let it automatically evaluate user input.

**Please note: BigTrustScheduling is not yet production ready. However, the project is rapidly progressing with some very useful features.**
