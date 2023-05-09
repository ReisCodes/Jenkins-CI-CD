# CICD, Jenkins, CDE (git pull local test)

# testing ci from github with tech221

## What is Jenkins

* Open source automation server, facilitates/helps continuous integration and continuous delivery (CI/CD) pipelines
* Allows developers to automate building, testing, and deploying software applications
* CI = merging code from multiple developers in a shared repo multiple times a day, lest them detect integration issues earlier, and reduce time and effort needed to fix

## What other tools available

* GITLAB CI/CD = provide built in cicd capabilities, define and manage piplines directly inside gitlab repo
* Bamboo = CICD tool by atlassian, robust build, test, deployment automation capabilities
* GitHub Actions - CICD solution by GITHUB, allows devs to define worklows using YAML to automate sdlc

## Jenkins stages

* Source - pipeline retrives source code. checking the code and getting latest updates
* Build - source code compiled (readable, syntax free), dependencies resolved ( and artefacts generated, convert source code into deployable form eg exec files or libs
* Test - Various tests executed to ensure quality and functinality of application, eg unit tests, integration tests, and other automated tests
* Production - After tests, application is deployed to production environment, you prepare the infrastructure, by configuring app and deploying it to environment
* 

## Difference between continuous delivery (CD) and continuous deployment (CDE)

* CD = Continuous Delivery is an extension of continuous integration to make sure that you can release new changes to your customers quickly in a sustainable way. This means that on top of having automated your testing, you also have automated your release process and you can deploy your application at any point of time by clicking on a button. In continuous Delivery the deployment is completed manually.
* Continuous Deployment goes one step further than continuous delivery, with this practice, every change that passes all stages of your production pipeline is released to your customers, there is no human intervention, and only a failed test will prevent a new change to be deployed to production.

goal of cicd - achieve end to end autoamtion

![image](https://user-images.githubusercontent.com/129314018/235719214-a2dab7e2-ff88-441d-a7d8-56c17a4180fd.png)

* Local Host - represent local environment (computer)
* GitHub via SSH - We use SSH to securely connect to GitHub repository
* Jenkins via SSH - Will connect to the GitHub via SSH, allowing it to fetch code from the repository
* Jenkins uses GitHub Status API to update status of commit/pull request, can show if deployment was successful or not
* Jenkins also uses Deployment API to trigger and manage deployments
* WebHook trigger lets GitHub send notifications to Jenkins when an event happens in the repository, this can be a code push/pull, makes Jenkins perform a build or deployment process, it is like a signal for Jenkins to perform the actions needed depending on what takes place within the repository
* Master Node = Main jenkins server, Agent Node = computers, eg: EC2 instances
* Jenkins will use master node to manage and schedule tasks
* When there is lot of work, master node can share tasks with agent nodes, which perform tasks quickly by working on them simultaneously
* The link between both master and agent is like master node is distributing tasks to the agent nodes, and they will recieve updates on the progress.


## CI/CD - Jenkins to GitHub App deployment

### Pre-requisites
<details>
  <summary>[PREREQUISITES TO CLONE APP FOLDERS]</summary>
  
  We used the following commands in order to clone someones app folder and environment folder to our local machine
  which we in turn pushed to this repository.
  
  479  git clone https://github.com/khanmaster/sre_jenkins_cicd.git
  
  486  cp -R app /c/Users/tahir.LAPTOP-2JTDBK37/Documents/tech_221/CICD_tech221
  
  490  cd sre_jenkins_cicd/
  
  491  cp -R environment /c/Users/tahir.LAPTOP-2JTDBK37/Documents/tech_221/CICD_tech221
  
  495  git add .
  
  496  git commit -m "Cloned folders from other repository"
  
  497  git push origin main
  
  498  git fetch origin
  
  499  git merge origin/main
  
  500  cd Documents/
  
  501  cd tech_221/
  
  502  cd CICD_tech221/
  
  503  ls
  
  504  git status
  
  505  git commit -m "first commit"
  
  507  git status
  
  509  git push
</details>


### Jenkins to GitHub App deployment

1. Pre-requisites to starting with Jenkins, follow [Using SSH with GitHub](https://github.com/mthussain1234/test-ssh#using-ssh-with-github)
2. Make your keys, we had named them `reis-jenkins-key`, and be sure to follow the documentation, also make sure the `app` folders are cloned, as you can see in the contents of this github repository.
 <b>When adding key to github make sure to check the read and write option.</b>
 <b>add ssh key also</b>
3. On Jenkins, click `New Item`.

![image](https://user-images.githubusercontent.com/129314018/235678316-948b83c1-5034-4647-afc6-eb37d9e21a99.png)

4. On the next page, enter the name we use `reis-CI` similar naming conventions are allowed, and select `freestyle project` and click Ok

![image](https://user-images.githubusercontent.com/129314018/235678494-d680aede-a141-4cfb-94be-fbec8ba44806.png)

5. On the next page, do your description as you please, we do it as shown below, select `Discard old builds`, and as shown below check the `Github project` to allow for the use of the app folder as discussed below
6. On the GitHub repository also shown below, copy the `HTTPS` link of the repo and copy it into the Jenkins `project url`

![image](https://user-images.githubusercontent.com/129314018/235699049-7c83fc8f-8cb6-4b6a-acb5-de1ec5cb4618.png)

7. Scrolling down, check the box as shown below, and type `sparta ubuntu node` and click the popup, on the label expression.

![image](https://user-images.githubusercontent.com/129314018/235699355-d16b50b9-4c53-4e23-9c72-5c3dccc3012b.png)

8. On Source code management click `Git`, and on repository URL, we can see below on the repository we click `Code` then click `ssh` and copy and paste that url in the repository URL.

![image](https://user-images.githubusercontent.com/129314018/235699909-30280628-5d2a-4579-8d07-663401c952ea.png)

9. You may be met with an error, if so click the `add` as shown below and click `Jenkins`

![image](https://user-images.githubusercontent.com/129314018/235700005-71b70e29-4420-4a4e-ac09-6b71c419f3ed.png)

10. A pop up should appear, and the ssh keys we created before hand, using GitBash, navigate to `ssh` folder and do `cat <private-key>` and copy the private key.
11. We then click the SSH dropdown on `Kind` and enter the key-name on Username, so they match
12. On `private key` click `enter directly` and paste your private key in the box as shown below, and press add.

![image](https://user-images.githubusercontent.com/129314018/235700561-3e5456a1-9277-4583-966f-7a451112aecf.png)

13. On branches to build, change `master` to `main` as that is the branch we are using

![image](https://user-images.githubusercontent.com/129314018/235702105-133d4640-edde-4ede-845a-13e4414f9e6d.png)

14. On Build environment, check the `provide node & npm ...` as shown below

![image](https://user-images.githubusercontent.com/129314018/235702267-97a23956-71c9-4517-90d2-d43933c4894d.png)

15. Scrolling down, `add build step` then click execute shell.

![image](https://user-images.githubusercontent.com/129314018/235702442-b3d41f78-436e-4449-bb11-99f7c14f81ee.png)

16. In `execute shell` enter (and save after) : 
```
cd app
npm install
npm test
```

17. Click `Build now` and wait for the build history to update, when the new build shows up, click the dropdown as shown below, and click `console output`

![image](https://user-images.githubusercontent.com/129314018/235704026-6c4ccbd1-c692-41eb-9598-e9ebcde7a55e.png)

18. After clicking `console output` we can scroll down to see checks passed, and we can see what it can look like for a succesful test, shown below.

![image](https://user-images.githubusercontent.com/129314018/235704124-d9a22683-5a16-49d1-9cc3-f62c245a0076.png)

### Webhook creation

1. Create webhook for Jenkins/endpoint
2. create a webhook in github for repo where we have app code
3. test webhook - testing status code 200
4. make change to github readme and commit change

![image](https://user-images.githubusercontent.com/129314018/235880570-4303e7c6-faed-4df1-bdd8-ee3a5bbecd2e.png)

![image](https://user-images.githubusercontent.com/129314018/235880905-2b521219-6731-44aa-9d15-f685e2f00783.png)

- save after checking box as shown below

![image](https://user-images.githubusercontent.com/129314018/235882064-94742946-8745-4acc-8865-1d9d624a4c55.png)

### On local machine - Jenkins 

1. On GitBash, we navigate to our directory linked to repo.
2. `git pull` to pull changes from the GitHub changes we made earlier
3. `nano README.md` make some changes to test it
4. `git add .` then `git commit -m "xxxx"` then `git push` to push it to the GitHub
5. Check Jenkins after pushing the new changes, and it should show you a new build being deployed as shown below.

![image](https://user-images.githubusercontent.com/129314018/235890506-64845f78-e9dc-4166-84db-cd6e5df40586.png)

### TAS - MERGE - NEW BRANCH - JENKINS

1. Create new job called mohammad-ci-merge, we do this by selecting our old mohammad-ci template
2. create dev branch on local host and make change to readme
3. we do this by `git branch dev` then `git checkout dev`
4. push to github which should trigger job
5. if test passed, merge code to main branch
6. we now switch to our target branch which is `main` by `git checkout main`
7. We then `git merge dev` which should merge our dev branch into the main branch
8. `git add .` then `git commit -m "xxxx"` then `git push origin main` and it should push the new merged branch, and we can test this by checking Jenkins, and it should show a new build being deployed.
9. Like before, it should show the updated code/readme on your GitHub

#### Automating this

1. Make a new job, we call it `reis-ci-merge-dev` and we as before create a template from `reis-ci-merge` and scroll down to source code management, additional behaviours and do as below. 

![image](https://user-images.githubusercontent.com/129314018/235922617-a80f8139-a5a1-4582-bbdb-af5410d17680.png)

2. On post build actions select git publisher, and select as shown below.

![image](https://user-images.githubusercontent.com/129314018/235922782-0a335a5d-1f90-4ddb-82d7-d04342116821.png)

3. Go to our `reis-ci-merge` job, scroll all the way down to post build actions and select post-build actions like below, and select the job we just created.

![image](https://user-images.githubusercontent.com/129314018/235923005-8055aa4b-bb93-4d96-8af7-04fb1e943741.png)

4. Save and we test as before, on GitBash, change code/readme, `git add .` -> `git commit -m "xxx"` -> `git push origin dev`.
5. once done, it will deploy it on `reis-ci-merge` which will update it on the `dev` branch and as we did post build actions, this triggers the `reis-ci-merge-dev` job to deploy, this will merge the `dev` branch with the new changes with the `main branch`
6. Test this by checking the repo on GitHub and navigating between both branches, and see if the changes made on the `dev` branch are the same as the `main` branch


## create 3rd job to push code to production

1. Launch instance from previous AMIs, we use our app AMI `ami-06042513c73c0c668`, and configure security groups as shown below 

![image](https://user-images.githubusercontent.com/129314018/235996432-b02016e9-74fb-4c81-95d5-5edb8308f906.png)

2. Launch Instance


3. Create a new job to deploy our sparta app we use `reis-sparta-app`
4. Configure the job as seen in the screenshots below in order

![image](https://user-images.githubusercontent.com/129314018/235975825-dc766cd1-286d-4d04-8bd0-70f0e482238e.png)
![image](https://user-images.githubusercontent.com/129314018/235975895-b99b6813-2f29-4127-8f31-1c7606c1d777.png)
![image](https://user-images.githubusercontent.com/129314018/235975976-aa5775be-9955-4d2f-b63f-b9b56ec5b7ce.png)
![image](https://user-images.githubusercontent.com/129314018/235976048-bb3fc050-3fa3-4403-86fa-582337ba1a0d.png)

5. As seen above, in the execute shell enter these commands changing the `ip` to your Public ipv4 addres found on 
EC2 instance.

```
scp -v -r -o StrictHostKeyChecking=no app/ ubuntu@<my-ip>:/home/ubuntu/
ssh -A -o StrictHostKeyChecking=no ubuntu@<my-ip> <<EOF
#sudo apt install clear#

cd app

#sudo npm install pm2 -g
# pm2 kill
nohup node app.js > /dev/null 2>&1 &
```
6. Save changes and build to test the deployment of the app
7. Type public ip with `:3000` at the end to see if the app has deployed

![image](https://user-images.githubusercontent.com/129314018/235997171-ba85ba80-e607-45e1-b950-3fd6b7b675cc.png)

# How to install and set up Jenkins on EC2 instance

This guide will provide an information on how to install Jenkins on the EC2 instance and create a Master node

## Step 1. Create a new EC2 Instance

1. Go to AWS and launch a new instance
2. You can name it something like `jenkins-master` as it will be your master node
3. For AMI use `Ubuntu 18.04`
4. Use `t2.Medium`
5. For SG you need the following ports:
    * SSH port 22 - for your IP
    * Custom TCP port 8080 - for Jenkins access from anywhere
    * Custom TCP port 43 - access from anywhere to allow connectiong with github
6. Use `tech221.pem` as SSH key
7. Launch the instance

## Step 2. Connect to the instance to install Jenkins

1. Use SSH connection to log in to your instance thourgh GitBash terminal
2. Use the following commands to install all the dependancies:
```
sudo apt-get update
sudo apt-get install default-jdk -y


wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

sudo ufw allow OpenSSH
sudo ufw enable

sudo su
ssh -T git@github.com
```

## Step 3. Create Jenkins account and finish the set-up

1. Connect to Jenkins server in your browser by using `<EC2_publicIP>:8080`
2. It will ask you to confirm the password. In your terminal write `sudo cat /var/lib/jenkins/secrets/initialAdminPassword` in order to retrieve the password, copy and then paste it to Jenkins.
3. Follow the steps to set-up Jenkins, enter your credentials and install recommended packages.
4. Once logged in, go to `Manage Jenkins`
5. Search for `Manage Plugins`
6. Go to `Available Plugins` and then search and install the following plugins:
    * Amazon EC2 plugin
    * NodeJS plugin
    * SSH Agent plugin
7. Then, go back to `Manage Jenkins`
8. Go to `Global Tool Configuration`
9. Scroll down and search for `NodeJS`
10. Add a new version of NodeJS you want to install. For this task I used version 12.1.0
11. Click `Save`

## Step 4. Create jobs on Master Node in order to establish and test CI/CD pipeline

First, we need to establish a `webhook trigger` in order for GitHub to communicate with Jenkins when new code being pushed. For that, we need to go to our GitHub repo -> Settings -> Weebhooks -> Add webhook. There, create a new weebhook with url `http://<jenkinsIP>:8080/github-webhook/` and Content type `application/jason`. 
Also, ensure that you launch your EC2 instance with App installed.

Then, we need to create our first job:
1. Create a new task, for example `spartaApp-ci`, as Freestyle project.
2. You can follow the guide on how to create the job [CI/CD guide](CICDandJenkins.md)
3. In genaral:
    * Set Discard old build to 3
    * GitHub project paste https link to your repo
4. In Source code management:
    * Select Git
    * Paste ssh link to your repo
    * create a credential ssh key
    * Branch to build set to `dev`
5. Build Triggers select `GitHub`
6. Build Environment:
    * Select Provide Node & npm bin/folder to PATH
    * in NodeJS Installation select the node installation we created earlier
7. In Build Steps and shell script:
```
cd app
npm install
npm test
```
8. Click save and test the job if it works

Create a second job to marge code:
1. Create a new task, for example `spartaApp-merge` as Freestyle project
2. You can follow the guide on how to create the job [CI/CD guide](CICDandJenkins.md)
3. In genaral:
    * Set Discard old build to 3
    * GitHub project paste https link to your repo
4. In Source code management:
    * Select Git
    * Paste ssh link to your repo
    * create a credential ssh key
    * Branch to build set to `dev`
    * Add additional behaviour `Merge before build`
    * Name o repository set to origin
    * Branch to merge to set to main
5. Add Post-Build Actions `Git Publisher` and tick boxes for `Push Only if build successful` and `Merge Results`
6. Test the job after you saved it

Create a final job:
1. Create a new task, for example `spartaApp-cd`, as Freestyle project.
2. You can follow the guide on how to create the job [CI/CD guide](CICDandJenkins.md)
3. In genaral:
    * Set Discard old build to 3
    * GitHub project paste https link to your repo
4. In Source code management:
    * Select Git
    * Paste ssh link to your repo
    * create a credential ssh key
    * Branch to build set to `main`
5. Build Environment:
    * Select SSH Agent
    * Create credentils using AWS pem file
7. In Build Steps and shell script:
```
scp -v -r -o StrictHostKeyChecking=no app/ ubuntu@<EC2_publicIP>:/home/ubuntu/
ssh -A -o StrictHostKeyChecking=no ubuntu@<EC2_publicIP> <<EOF
#sudo apt install clear#

cd app
#sudo npm install pm2 -g
# pm2 kill
nohup node app.js > /dev/null 2>&1 &
```
8. Save and test the job


Once all the jobs are working we can link them together to trigger next job when previous one is completed:
1. Go to `spartaApp-ci` configuration and in Post-Build Actions add `Build other projects`, where you want to build `spartaApp-merge`
2. Go to `spartaApp-merge` configuration and in Post-Build Actions add `Build other projects`, where you want to build `spartaApp-cd`
3. Now make some changes in the code and push it to your GitHub. If everything is correct it should trigger all of the jobs one after another and update your app
4. Go to `<EC2_piblicIP>:3000` in order to check if the app is working and updates have been applied
