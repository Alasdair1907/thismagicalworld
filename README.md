###### To get this code running:

1. Make sure that you have the following installed:
    - Java 14+
    - PostgreSQL (12)
    - GIT

    Download the latest version of tomcat archive from http://tomcat.apache.org/

2. Get the source code:
    git clone https://github.com/Alasdair1907/MagicJournal.git

3. Set up SQL:
    - Create a database (in this example, database is demodb with user demo and password demo123)
    - Put database info into the hibernate config at /src/main/resources/hibernate.cfg.xml
    Edit these lines:
    
    &lt;property name="connection.url">jdbc:postgresql://localhost:5432/demodb&lt;/property><br />
    &lt;property name="connection.username">demo&lt;/property><br />
    &lt;property name="connection.password">demo123&lt;/property><br />
    
    - Create the tables by executing the sql script at /src/misc/create-tables.postgres.sql:<br />
    psql -U demo -h localhost -d demodb -f create-tables.postgres.sql

4. Copy contents of the tomcat lib folder (the one inside the downloaded tomcat archive) to the project's /lib folder

5. Build the project:<br />
    ./gradlew build<br />
    (on windows, gradlew.sh build)

    If the project has been built successfully, you will see the following message:
    BUILD SUCCESSFUL

6. Deploy .WAR file
    You will find the compiled Web ARchive (.war) file in the /build/libs/ directory.<br />
    You can simply copy it to the webapps folder of tomcat, name it ROOT.war (make sure that there is no directory named ROOT), and run the tomcat from the bin folder by executing ./catalina.sh run

7. Set up the vital parts of the blog:
    - Make a folder for image and file storage, for example, at /home/user/imageStorage and /home/user/fileStorage
    - In your browser navigate to localhost:8080/admin, log in as 'admin' with password 'password'
    Click 'Settings'
    
    Edit these settigns:
    - Image Storage Path (for example /home/user/imageStorage)
    - Storage Path for Non-Image Files (for example /home/user/fileStorage)
    - Set the dimensions for preview images (1280 recommended) and thumbnail images (800 recommended)
