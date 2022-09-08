cd  goldenwaste-sda-hackathon
dir
mvn clean
mvn compile
mvn package
cd ~
cd .m2
vi settings.xml
---
<settings>
 <servers>
    <server>
      <id>nexus</id>
      <username>admin</username>
      <password>123456</password> -> your password create
    </server>
  </servers>
  <mirrors>
    <mirror>
      <!--This sends everything else to /public -->
      <id>nexus</id>
      <mirrorOf>*</mirrorOf>
      
      <url>http://ec2-3-86-191-132.compute-1.amazonaws.com:8081/repository/maven-public/</url> ->change your host
    </mirror>
  </mirrors>
  <profiles>
    <profile>
      <id>nexus</id>
      <!--Enable snapshots for the built in central repo to direct -->
      <!--all requests to nexus via the mirror -->
      <repositories>
        <repository>
          <id>central</id>
          <url>http://central</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>true</enabled></snapshots>
        </repository>
      </repositories>
     <pluginRepositories>
        <pluginRepository>
          <id>central</id>
          <url>http://central</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>true</enabled></snapshots>
        </pluginRepository>
      </pluginRepositories>
    </profile>
  </profiles>
  <activeProfiles>
    <!--make the profile active all the time -->
    <activeProfile>nexus</activeProfile>
  </activeProfiles>
</settings>
--
cd  goldenwaste-sda-hackathon
vi pom.xml
-----
 <distributionManagement>
    <repository>
      <id>nexus</id>
      <name>Releases</name>
      <url>http://ec2-3-86-191-132.compute-1.amazonaws.com:8081/repository/maven-releases</url>
    </repository>
    <snapshotRepository>
      <id>nexus</id>
      <name>Snapshot</name>
      <url>http://ec2-3-86-191-132.compute-1.amazonaws.com:8081/repository/maven-snapshots</url>
    </snapshotRepository>
  </distributionManagement>
  <build> ->befor past code
---
mvn clean
mvn compile
mvn package
mvn deploy