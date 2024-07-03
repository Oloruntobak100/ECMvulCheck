# CBN PAPERLITE AND FIAPS IN JAVA

## build and deploy local
rm -rf "C:/xampp/tomcat/webapps/ECM6/" && mvn clean && mvn package && cp "C:/Users/Administrator/IdeaProjects/ECM4/target/ECM4-1.0-SNAPSHOT.war" "C:/xampp/tomcat/webapps/ECM6.war"
Or
install and configure system environment for java 21
Install Apache Maven 3.9.6
Set up Environment Variables for MAVEN
Install and setup Express edition of SQL Server 2019 and download SQL Management Studio 18/19 or Connect
to an existing database through the config.json
Install Apache Tomcat version 9
Clone/Pull the ECM repo from GitHub
Generating the WAR file using:
On the CMD window/Linux terminal, navigate to the directory of the ECM repo on the App Server
Run mvn clean
Run mvn package: This will generate an ECM6-2.war file in the target folder of the ECM repo on the App Server


## Custom Config Files Location
*Windows*
`C:\dev1kit\paperlite\`
Or leave blank in the GlobalFunctions class (app_config_dir) to utilize the internal settings

*Linux*
`/var/lib/dev1kit/paperlite/`
Or leave blank in the GlobalFunctions class (app_config_dir_linux) to utilize the internal settings

## foreach loop
for( Object status_update_table : status_updates.names() ){  
	JSONObject jv = status_updates.getJSONObject( status_update_table.toString() );  
}  

## Recent Updates
### 02-jun-23 
Grade Level Field enabled on users table  
Cash advance kilometer chart, rate & grade level table added

**TOOLS: IntelliJ IDEA, Active Directory, JAVA, Maven, dev1kit.com, Tomcat and MS SQL Database**

## Project Scope based on Award Letter
**PHASE 1**
- Rebuild and Stabilization of 14 FIAPS Processes in PHP
- Development of Web Portal for Submission of Documents for the 14 FIAPS Processes


**PHASE 2**
- Development of 23 ECM Processes in JAVA
- Translation of the 14 FIAPS Processes from PHP to JAVA

## Work Done
### PHASE 1
1. Renewal of License
2. Change External Auditor
3. Change of Name
4. Equity Investment
5. Board & Management
6. Org. Structure
7. Shares Transfer
8. Share Capital
9. Branch Expansion
10. Penalties & Sanction
11. Black Book
12. Black Book Delisting
13. Black Book Miscellaneous
14. Annual Report
15. License
16. Registration
17. Examination Report Library
18. Request for Download

### PHASE 2: ECM 23 Processes
**LITIGATION SUPPORT**

1. DEFENSE IN COURT
2. EXTERNAL SOLICITOR BILL SETTLEMENT
3. RENDERING LEGAL OPINION
4. COMPLIANCE WITH JUDGEMENT AND AWARD
5. WITNESS HANDLING
6. APPEAL AGAINST ADVERSE JUDGEMENTS
7. DEVELOPMENT IN LAW SUITS
8. INSTITUTING LAW SUIT
9. OUT OF COURT SETTLEMENT DURING PROCEEDINGS IN COURT
10. WRITS OF SUMMONS
11. MEDIATION BEFORE INSTITUTING ACTION IN COURT
12. RESPONDING TO GARNISHEE ORDER
13. SUBPOENA
14. DE-BRIEFING OF EXTERNAL SOLICITORS
15. ALTERNATIVE DISPUTE RESOLUTION (OUT OF COURT SETTLEMENT - POST JUDGEMENT)

**CASH ADVANCE**

16. CASH ADVANCE ADMINISTRATOR CHEQUES
17. CASH ADVANCE SINGLE & MULTI TRIP
18. CASH ADVANCE RETIRE & REIMBURSEMENT

**MEETING CO-ORDINATION (MPC/MPIC)**

19. MPC MEETING CO-ORDINATION PROCESS
20. ECM-MPIC MEETING CO-ORDINATION PROCESS

**CAREER DEV. AND TRAINING**

21. TRAINING MANAGEMENT
22. CAREER DEVELOPMENT REQUEST FOR MANAGEMENT APPROVAL
23. REQUEST FOR VERIFICATION & UPDATE OF ADDITIONAL QUALIFICATION
