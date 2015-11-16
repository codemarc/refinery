# refinery

Recently I was working on a data project and I need 
to do a little cleanup on some of the data that had been 
captured. In another life I had worked on a [project named 
egret](http://codemarc.net/egret) that was a branch of Google/Open Refine.

I thought to myself, it would be useful to grab the latest 
version of open refine and spin up a copy to wrangle that data. 
So being a scripter I wrote a little shell script to do just that.

These days I always think cloud first so I built a docker image
to run in the cloud as well. And then I added the linkage between 
github and docker to automate the image build.

Now I needed a place to host this and since I like to rotate thru
the different cloud vendors and environments (to stay current with each) 
I chose the Google cloud for this effort. 

To get this running in the Google Container Engine
took a little doing. You first build you app, containerize it, 
test it locally in docker. Make sure you have installed and 
updated the command line tools for google cloud (gcloud and kubectl)
 
Then  
* create a project and container engine instance
* push your image from your docker to the google container registry (gcr.io)
* run the image and create an external load balancer to access it from the web
* try it out 
* dont forget to shut it down when not in use

Your mileage may vary... You can see the running version of this off of 
[codemarc.net](http://codemarc.net#download). Click on the running link
because Its not always up.
