Get-ChildItem 
$WORK_DIR=pwd
$MCAFEE_REPO_LIST="aemcore"
$MCAFEE_REPO_BRANCH="dev2"
$MCAFEE_REPO_BASE_PATH="git\@github-lvs.corpzone.internalzone.com:asuhail/"
echo MCAFEE_REPO_LIST=${MCAFEE_REPO_LIST}
echo MCAFEE_REPO_BRANCH=${MCAFEE_REPO_BRANCH}
echo MCAFEE_REPO_BASE_PATH=${MCAFEE_REPO_BASE_PATH}
echo $WORK_DIR
Set-Location -Path "C:\Users\asuhail\OneDrive - McAfee\Documents\powershell scripts"
echo Remove-Item mcafee
Remove-Item mcafee -Force
echo git init mcafee
git init mcafee
Set-Location mcafee
ni pom.xml
git add pom.xml
git commit -m "First commit"
$modules=""
#Checkout the PLAT Branch in the initial master
echo git checkout -b ${MCAFEE_REPO_BRANCH}
if ($? -ne 0) {
    echo git checkout -b ${MCAFEE_REPO_BRANCH}
}
foreach ( $gitRepo in $MCAFEE_REPO_LIST ){
    gitRepoPath="${MCAFEE_REPO_BASE_PATH}${gitRepo}.git"
modules="${modules}<module>${gitRepo}</module>"
echo "MCAFEE_REPO_BASE_PATH=${MCAFEE_REPO_BASE_PATH}"
echo "gitRepo=${gitRepo}"    
#Change number 2 Add Remote alias
echo git remote add ${gitRepo} --no-tags "${MCAFEE_REPO_BASE_PATH}${gitRepo}.git"
git remote add ${gitRepo} --no-tags "${MCAFEE_REPO_BASE_PATH}${gitRepo}.git"
  # Change 3 Fetch the remote and branch
  echo git fetch ${gitRepo}  ${MCAFEE_REPO_BRANCH}
  git fetch ${gitRepo} ${MCAFEE_REPO_BRANCH} 
   # Change Number 4
   echo git subtree add ${gitRepo} ${MCAFEE_REPO_BRANCH} --prefix=${gitRepo} --squash
   git subtree add ${gitRepo} ${MCAFEE_REPO_BRANCH} --prefix=${gitRepo} --squash
   #echo git subtree add --prefix ${gitRepo}  "${MCAFEE_REPO_BASE_PATH}${gitRepo}.git" ${branchName} --squash
   #git subtree add --prefix ${gitRepo}  "${MCAFEE_REPO_BASE_PATH}${gitRepo}.git" ${branchName} --squash  

}
Tee-Object -FilePath "pom.xml" >>EOF
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>customer.group.id</groupId>
    <artifactId>customer-reactor</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <packaging>pom</packaging>
    <modules>${modules}</modules>
    <profiles>
    <!-- ====================================================== -->
	        <!-- A D O B E   P U B L I C   P R O F I L E                -->
	        <!-- ====================================================== -->
	        <profile>
	            <id>adobe-public</id>

	            <activation>
	                <activeByDefault>true</activeByDefault>
	            </activation>

	            <properties>
	                <releaseRepository-Id>adobe-public-releases</releaseRepository-Id>
	                <releaseRepository-Name>Adobe Public Releases</releaseRepository-Name>
	                <releaseRepository-URL>https://repo.adobe.com/nexus/content/groups/public</releaseRepository-URL>
	            </properties>

	            <repositories>
	                <repository>
	                    <id>adobe-public-releases</id>
	                    <name>Adobe Public Repository</name>
	                    <url>https://repo.adobe.com/nexus/content/groups/public</url>
	                    <releases>
	                        <enabled>true</enabled>
	                        <updatePolicy>never</updatePolicy>
	                    </releases>
	                    <snapshots>
	                        <enabled>false</enabled>
	                    </snapshots>
	                </repository>
	            </repositories>

	            <pluginRepositories>
	                <pluginRepository>
	                    <id>adobe-public-releases</id>
	                    <name>Adobe Public Repository</name>
	                    <url>https://repo.adobe.com/nexus/content/groups/public</url>
	                    <releases>
	                        <enabled>true</enabled>
	                        <updatePolicy>never</updatePolicy>
	                    </releases>
	                    <snapshots>
	                        <enabled>false</enabled>
	                    </snapshots>
	                </pluginRepository>
	            </pluginRepositories>
	        </profile>
            </profiles>            
    </project>
EOF>>
git add .\pom.xml
git commit -m "first commit"
Get-ChildItem

                        