#This is the dockerfile for a test of the CAMCONTAINER concept
#Based on vmware/powerclicore, it adds some custom content so that it can be used as a portable script enviroment for CAM
#Some scripts can be run autonamously. Others will rely on a local config file that is unique to the local enviroment where the container and its scripts are run
#This proof of concept is public

FROM vmware/powerclicore:latest

LABEL authors="kloosterhuispro@gmail.com"

#Go into powershell to do some powershelly things
SHELL [ "pwsh", "-command" ]

#Suppress Certificate errors for vCenter Connections (not exactly best practice)
RUN Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false

#suppress CEIP
RUN Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -Confirm:$false

#Go into bash to do some bashy stuff
SHELL [ "bash", "-c"]

#Make a directory for local content (no longer used)
#RUN mkdir -p /localcontent

#Install Unzip
RUN tdnf install -y unzip

# Set working directory to /
WORKDIR /

#Download all the local content from Github, unzip it, move it to /localcontent

RUN curl -o ./camcontainercontent-master.zip -J -L https://github.com/thefluffysysop/camcontainercontent/archive/master.zip && \
unzip camcontainercontent-master.zip && \
rm -f camcontainercontent-master.zip && \
mv ./camcontainercontent-master ./localcontent && \
chmod 755 ./localcontent


#old style (no longer used)
#Copy content from https://github.com/thefluffysysop/camcontainercontent into /localcontent
#RUN mkdir /localcontent/vsanreport1
#RUN curl https://raw.githubusercontent.com/thefluffysysop/camcontainercontent/master/vsanreport1/vsanreport1.ps1 -o /localcontent/vsanreport1/vsanreport1.ps1


#Cleanup

#Set working dir back to root
WORKDIR /

#delete unzip package and clean everything else
RUN tdnf erase -y unzip && \
    tdnf clean all

#Set default command back to running powershell
CMD ["/bin/pwsh"]




