# refinery

Recently I was working on a data project and I need 
to do a little cleanup on some of the data that had been 
captured. In another life I had worked on a project named egret
that was a branch of Google/Open Refine.

I thought to myself, it would be useful to grab the latest 
version of open refine and spin up a copy. So being a scripter
I wrote a little shell script to do just that.

These days I always think cloud first so a added a docker image
to run in the cloud as well. And then I added the linkage between 
github and docker to automate the image build as well.

The commands to get this running in the Google Container Engine
took a little doing. You first build you app, containerize it, 
test it locally in docker. Make sure you have installed and 
updatedthe command line tools for google cloud (gcloud and kubectl)
  
* create a project and container engine instance
* push your image from your docker to the google container registry (gcr.io)
* run the image and create an external load balancer to access it from the web
* try it out 
* dont forget to shut it down when not in use


